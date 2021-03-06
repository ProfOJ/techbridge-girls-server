const getConnection = require("../config/mysql");
const Promise = require("bluebird");
const s3 = require('../services/s3').s3;
const urlSigner = require('../services/s3').urlSigner;
const uuid = require("uuid/v1");

const using = Promise.using;

module.exports = {
	getMyProposals: function (req, res) {
		if (req.user.type !== 0)
			return res.status(400).json({ message: 'Only makers can get their proposals.' });

		using(getConnection(), connection => {
			const query = "SELECT p.*, HEX(p.id) AS id, IFNULL(applications, 0) AS applications, IFNULL(leads, 0) AS leads, " +
				"COUNT(p.id) AS offers_count FROM proposals p " +
				"LEFT OUTER JOIN offers o ON o.proposal_id = p.id " +
				"LEFT OUTER JOIN (SELECT proposal_id, COUNT(*) AS applications FROM offers WHERE status = 1 GROUP BY proposal_id) a " +
				"ON a.proposal_id = p.id " +
				"LEFT OUTER JOIN (SELECT proposal_id, COUNT(*) AS leads FROM offers WHERE status = 0 GROUP BY proposal_id) l " +
				"ON l.proposal_id = p.id " +
				"WHERE p.maker_id = UNHEX(?) AND p.status != 2 GROUP BY p.id"
			return connection.execute(query, [req.user.id]);
		})
			.spread(data => {
				return res.json(data);
			})
			.catch(err => {
				return res.status(400).json({ message: "Please contact an admin." });
			});
	},
	getMyApplications: function (req, res) {
		if (req.user.type !== 1)
			return res.status(400).json({ message: 'Only suppliers can get their applications.' });

		using(getConnection(), connection => {
			const query = "SELECT *, HEX(id) AS id FROM proposals WHERE id IN (SELECT proposal_id FROM offers " +
				"WHERE supplier_id = UNHEX(?) AND status > 0)"
			return connection.execute(query, [req.user.id]);
		})
			.spread(data => {
				return res.json(data);
			})
			.catch(err => {
				return res.status(400).json({ message: "Please contact an admin." });
			});
	},
	getPercentCompleted: function (req, res) {
		Promise.join(using(getConnection(), connection => {
			let user_id;
			if (req.user.type == 0)
				user_id = "offers.user_id ";
			else if (req.user.type == 1)
				user_id = "proposals.user_id ";
			else
				return res.status(400).json({ message: 'Invalid user type provided.' });

			const query = "SELECT proposals.*, offers.*, proposals.completion AS completion, picture, HEX(proposals.id) AS proposal_id, " +
				"HEX(offers.user_id) AS user_id " +
				"FROM proposals LEFT JOIN offers ON id = proposal_id LEFT JOIN users ON users.id = " + user_id +
				"WHERE (offers.user_id = UNHEX(?) OR proposals.user_id = UNHEX(?)) " +
				"AND offers.status > 1 AND proposals.status > 1";
			return connection.execute(query, [req.user.id, req.user.id]);
		}), using(getConnection(), connection => {
			const query = "SELECT HEX(proposal_id) AS proposal_id, SUM(output) AS completed FROM reports " +
				"WHERE (user_id = UNHEX(?) OR proposal_id IN (" +
				"SELECT id FROM proposals WHERE user_id = UNHEX(?))) GROUP BY proposal_id";
			return connection.execute(query, [req.user.id, req.user.id]);
		}), (proposals, reports) => {
			return res.json({ proposals: proposals[0], reports: reprots[0] });
		})
			.catch(err => {
				console.log(err);
				return res.status(400).json({ message: "Please contact an admin." });
			});
	},
	uploadFiles: function (req, res) {
		if (!req.files || !req.files.buffer)
			return res.status(400).json({ message: "req.files does not exist" });

		if (req.files.length < 1)
			return res.status(400).json({ message: "No files were selected to upload." });

		if (req.files[req.files.length - 1].mimetype != "application/pdf" && !req.body.defaultNDA)
			return res.status(400).json({ message: "NDA must must be in .pdf format." });

		let files = [];
		Promise.map(req.files, function (file) {
			return new Promise((resolve, reject) => {
				s3.upload({
					Bucket: "ronintestbucket/testfolder",
					Key: 'ELLIOT I NEED YOUR HELP HERE',
					Body: file.buffer,
					ContentType: file.mimetype,
					ACL: "private"
				}, function (err, success) {
					if (err)
						return reject(err);
					else
						return resolve();
				});
			})
		})
			.then(() => {
				if (file.filename == req.files[req.files.length - 1].filename && !req.body.defaultNDA)
					files.push({ type: 1, filename: file.filename });
				else
					files.push({ type: 0, filename: file.filename });

				return res.json(files)
			})
			.catch(err => {
				console.log(err);
				return res.status(400).json({ message: "Internal error, please contact an admin." });
			});
	},
	getProposalsForPage: function (req, res) {
		if (req.user.type != 1)
			return res.status(400).json({ message: "Only Suppliers may view all proposals." });

		using(getConnection(), connection => {
			const query = "SELECT process FROM user_processes WHERE user_id = UNHEX(?)";
			return connection.execute(query, [req.user.id]);
		})
			.spread(data => {
				return using(getConnection(), connection => {
					let processes = []
					for (let i = 0; i < data.length; i++)
						processes.push(data[i].process);

					var query = "SELECT *, GROUP_CONCAT(process SEPARATOR ', ') AS processes, HEX(proposals.id) " +
						"AS id, proposals.created_at AS created_at FROM proposals LEFT JOIN proposal_processes " +
						"ON proposals.id = proposal_id WHERE proposals.status = 0 AND (audience = 0 OR process IN " +
						"(?)) GROUP BY proposals.id, proposal_processes.process ORDER BY proposals.created_at DESC LIMIT ?, 11";
					return connection.query(query, [processes, (req.params.page - 1) * 10]);
				});
			})
			.spread(data => {
				return res.json(data);
			})
			.catch(err => {
				console.log(err);
				return res.status(400).json({ message: "Please contact an admin." });
			});
	},
	show: function (req, res) {
		Promise.join(using(getConnection(), connection => {
			const query = "SELECT *, HEX(id) AS id, HEX(user_id) AS user_id FROM proposals LEFT JOIN files " +
				"ON id = proposal_id WHERE id = UNHEX(?)";
			return connection.execute(query, [req.params.id]);
		}), using(getConnection(), connection => {
			if (req.user.type == 1) {
				const query = "SELECT * FROM offers WHERE proposal_id = UNHEX(?) " +
					"AND user_id = UNHEX(?) LIMIT 1";
				return connection.execute(query, [req.params.id, req.user.id]);
			} else
				return [[]];
		}), (files, offer) => {
			if (files[0].length == 0 || (req.user.type == 0 && req.user.id != files[0][0].user_id) ||
				(req.user.type == 1 && offer[0].length > 0 && offer[0][0].status < 0))
				throw { status: 400, message: "Could not find valid proposal." };

			if (req.user.type == 1 && offer[0].length == 0) {
				// Remove private files:
				for (let i = files[0].length - 1; i >= 0; i--) {
					if (files[0][i].type == 0) {
						if (files[0].length == 1) {
							files[0][0].filename = 'https://s3-us-west-1.amazonaws.com/ronintestbucket/public_assets/170128_Mutual_NDA.pdf'
							files[0][0].type = 1;
						}
						else
							files[0].splice(i, 1);
					}
				}
				//Clear out confidential information
				files[0][0].user_id = "";
				files[0][0].proposal_id = "";
				files[0][0].zip = "";
				files[0][0].info = "";
				files[0][0].id = "";

			}

			// Rename files:
			for (let i = 0; i < files[0].length; i++) {
				if (files[0][i].filename != 'https://s3-us-west-1.amazonaws.com/ronintestbucket/public_assets/170128_Mutual_NDA.pdf') {
					files[0][i].filename = urlSigner.getUrl('GET', `/testfolder/${files[0][i].filename}`, 'ronintestbucket', 10);
				}
			}

			return res.json({ files: files[0], offer: offer[0][0] });
		})
			.catch(err => {
				console.log(err);
				if (err.status)
					return res.status(err.status).json({ message: err.message });
				return res.status(400).json({ message: "Please contact an admin." });
			});
	},
	create: function (req, res) {
		if (req.user.type != 0)
			return res.status(400).json({ message: "Only Makers may create proposals." });

		if (!req.body.processes || !req.body.product || !req.body.quantity || !req.body.completion ||
			!req.body.zip || req.body.audience === null)
			return res.status(400).json({ message: "All form fields are required." });

		if (req.body.quantity < 1)
			return res.status(400).json({ message: "You must specify a quantity of at least 1." });

		if (req.body.audience != 0 && req.body.audience != 1)
			return res.status(400).json({ message: "Invalid target suppliers provided." });

		const proposal_id = uuid().replace(/\-/g, "");
		req.body.product = req.body.product.replace(/\'/g, "''");
		req.body.info = req.body.info.replace(/\'/g, "''");
		using(getConnection(), connection => {
			const data = [proposal_id, 0, req.body.product, req.body.quantity, req.body.completion,
				req.body.zip, req.body.audience, req.body.info, req.user.id];
			const query = "INSERT INTO proposals SET id = UNHEX(?), status = ?, product = ?, quantity = ?, " +
				"completion = ?, zip = ?, audience = ?, info = ?, created_at = NOW(), updated_at = NOW(), " +
				"user_id = UNHEX(?)";
			return connection.query(query, data);
		})
			.then(() => {
				return Promise.join(using(getConnection(), connection => {
					let data = [];
					for (let i = 0; i < req.body.processes.length; i++)
						data.push([req.body.processes[i], `UNHEX('${proposal_id}')`, "NOW()", "NOW()"]);

					const query = "INSERT INTO proposal_processes (process, proposal_id, " +
						"created_at, updated_at) VALUES ?";
					return connection.query(query, [data]);
				}), using(getConnection(), connection => {
					let data = [];
					for (let i = 0; i < req.body.files.length; i++) {
						const file = req.body.files[i];
						data.push([file.filename, file.type, "NOW()", "NOW()", `UNHEX('${proposal_id}')`]);
					}

					const query = "INSERT INTO files (filename, type, created_at, updated_at, " +
						"proposal_id) VALUES ?";
					return connection.query(query, [data]);
				}), () => {
					return res.end();
				});
			})
			.catch(err => {
				console.log(err)
				return res.status(400).json({ message: "Please contact an admin." });
			});
	},
	delete: function (req, res) {
		if (req.user.type != 0)
			return res.status(400).json({ message: "Only Makers may delete their proposals." });

		using(getConnection(), connection => {
			const query = "DELETE FROM proposals WHERE id = UNHEX(?) AND user_id = UNHEX(?) AND STATUS = 0 LIMIT 1";
			return connection.execute(query, [req.params.id, req.user.id]);
		})
			.spread(data => {
				if (data.affectedRows == 0)
					throw { status: 400, message: "Could not delete proposal, please contact an admin." };
				return res.end();
			})
			.catch(err => {
				if (err.status)
					return res.status(err.status).json({ message: err.message });
				return res.status(400).json({ message: "Please contact an admin." });
			});
	}
}
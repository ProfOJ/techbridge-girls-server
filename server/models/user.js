var Promise = require("bluebird");
var using = Promise.using;
var getConnection = require("../config/mysql");
var bcrypt = require("bcrypt");
var jwt = require("jsonwebtoken");
var fs = require("fs");
var jwt_key = fs.readFileSync("keys/jwt", "utf8");

module.exports = {
	update: function(req, callback) {
		jwt.verify(req.cookies.evergreen_token, jwt_key, function(err, payload) {
			if (err)
				callback({status: 401, message: "Invalid token. Your session is ending, please login again."});
			else {
				using(getConnection(), connection => {
					var query = "UPDATE users SET ?, updated_at = NOW() WHERE HEX(id) = ? LIMIT 1";
					return connection.query(query, [req.body, payload.id]);
				})
				.then(data => {
					if (data.changedRows != 1)
						throw {status: 400, message: "Failed to save changes."};
					else
						return using(getConnection(), connection => {
							var query = "SELECT *, HEX(id) AS id FROM users WHERE HEX(id) = ? LIMIT 1";
							return connection.execute(query, [payload.id]);
						});
				})
				.then(data => {
					var evergreen_token = jwt.sign({
						id: data[0].id,
						type: data[0].type,
						company: data[0].company,
						contact: data[0].contact,
						created_at: data[0].created_at
					}, jwt_key, {expiresIn: "5d"});
					callback(false, evergreen_token);
				})
				.catch(err => {
					callback({status: 400, message: "Please contact an admin."})
				});
			}
		});
	},
	delete: function(req, callback) {
		jwt.verify(req.cookies.evergreen_token, jwt_key, function(err, payload) {
			if (err)
				callback({status: 401, message: "Invalid token. Your session is ending, please login again."});
			else
				using(getConnection(), connection => {
					return connection.execute("DELETE FROM users WHERE HEX(id) = ? LIMIT 1", [payload.id]);
				})
				.then(data => {
					if (data.affectedRows != 1)
						callback({status: 400, message: "Failed to delete your account."});
					else
						callback(false);
				})
				.catch(err => {
					callback({status: 400, message: "Please contact an admin."})
				});
		});
	},
	changePassword: function(req, callback) {
		jwt.verify(req.cookies.evergreen_token, jwt_key, function(err, payload) {
			if (err)
				callback({status: 401, message: "Invalid token. Your session is ending, please login again."});
			else if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d$@$!%*?&](?=.{7,})/.test(req.body.new))
				callback({status: 400, message: "Password must be at least 8 characters long and have a lowercase letter, an uppercase letter, and a number."});
			else
				bcrypt.genSalt(10, function(err, salt) {
					if (err)
						callback({status: 400, message: "Salt error."});
					else
						bcrypt.hash(req.body.new, salt, function(err, hash) {
							if (err)
								callback({status: 400, message: "Hash error."});
							else
								using(getConnection(), connection => {
									var query = "UPDATE users SET password = ?, updated_at = NOW() WHERE HEX(id) = ? LIMIT 1";
									return connection.execute(query, [hash, payload.id]);
								})
								.spread(data => {
									if (data.changedRows != 1)
										throw {status: 400, message: "Unable to change password."};
									else
										return using(getConnection(), connection => {
											// Retrieve updated user:
											var query = "SELECT *, HEX(id) AS id FROM users WHERE HEX(id) = ? LIMIT 1";
											return connection.execute(query, [payload.id]);
										});
								})
								.then(data => {
									var evergreen_token = jwt.sign({
										id: data[0].id,
										type: data[0].type,
										company: data[0].company,
										contact: data[0].contact,
										created_at: data[0].created_at
									}, jwt_key, {expiresIn: "5d"});
									callback(false, evergreen_token);
								})
								.catch(err => {
									if (err.status)
										callback(err);
									else
										callback({status: 400, message: "Please contact an admin."})
								});
						});
				});
		});
	},
	register: function(req, callback) {
		if (req.body.type === undefined || !req.body.company || !req.body.contact || !req.body.email
		|| !req.body.password || !req.body.confirm_password)
			callback({status: 400, message: "All form fields are required."});
		// Validate company:
		else if (!req.body.company)
			callback({status: 400, message: "Company name cannot be blank."});
		// Validate contact:
		else if (!/^[a-z ]{2,32}$/i.test(req.body.contact))
			callback({status: 400, message: "Invalid contact name."});
		// Validate email:
		else if (!/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/.test(req.body.email))
			callback({status: 400, message: "Invalid email. Email format should be: email@mailserver.com."});
		// Validate password:
		else if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d$@$!%*?&](?=.{7,})/.test(req.body.password))
			callback({status: 400, message: "Password must be at least 8 characters long and have a lowercase letter, an uppercase letter, and a number."});
		// Validate confirm_password:
		else if (req.body.password != req.body.confirm_password)
			callback({status: 400, message: "Passwords do not match."});
		// Else valid new user:
		else
			// Encrypt password and save:
			bcrypt.genSalt(10, function(err, salt) {
				if (err)
					callback({status: 400, message: "Salt error."});
				else
					bcrypt.hash(req.body.password, salt, function(err, hash) {
						if (err)
							callback({status: 400, message: "Hash error."});
						else
							using(getConnection(), connection => {
								var data = [
									req.body.type,
									req.body.company,
									req.body.contact,
									req.body.email,
									hash
								];
								var query = "INSERT INTO users SET id = UNHEX(REPLACE(UUID(), '-', '')), \
								type = ?, company = ?, contact = ?, email = ?, password = ?, created_at = NOW(), \
								updated_at = NOW()";
								return connection.execute(query, data);
							})
							.then(() => {
								return using(getConnection(), connection => {
									var query = "SELECT *, HEX(id) AS id FROM users WHERE email = ? LIMIT 1";
									return connection.execute(query, [req.body.email]);
								});
							})
							.spread(data => {
								var evergreen_token = jwt.sign({
									id: data[0].id,
									type: data[0].type,
									company: data[0].company,
									contact: data[0].contact,
									created_at: data[0].created_at
								}, jwt_key, {expiresIn: "5d"});
								callback(false, evergreen_token);
							})
							.catch(err => {
								if (err["code"] == "ER_DUP_ENTRY")
									callback({status: 400, message: "Email already in use, please log in."});
								else
									callback({status: 400, message: "Please contact an admin."})
							});
					});
			});
	},
	login: function(req, callback) {
		// Validate login data:
		if (!req.body.email || !req.body.password)
			callback({status: 400, message: "All form fields are required."});
		else if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d$@$!%*?&](?=.{7,})/.test(req.body.password))
			callback({status: 400, message: "Invalid password."});
		else
			using(getConnection(), connection => {
				// Get user by email:
				var query = "SELECT *, HEX(id) AS id FROM users WHERE email = ? LIMIT 1";
				return connection.execute(query, [req.body.email]);
			})
			.spread(data => {
				if (data.length == 0)
					throw {status: 400, message: "Email does not exist, please register."};
				else
					// Check valid password:
					bcrypt.compare(req.body.password, data[0].password, function(err, isMatch) {
						if (err)
							throw {status: 400, message: "Invalid email/password."};
						else if (!isMatch)
							throw {status: 400, message: "Email/password does not match."};
						else {
							var evergreen_token = jwt.sign({
								id: data[0].id,
								type: data[0].type,
								company: data[0].company,
								contact: data[0].contact,
								created_at: data[0].created_at
							}, jwt_key, {expiresIn: "5d"});
							callback(false, evergreen_token);
						}
					});
			})
			.catch(err => {
				if (err.status)
					callback(err);
				else
					callback({status: 400, message: "Please contact an admin."})
			});
	}
};

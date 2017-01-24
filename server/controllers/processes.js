module.exports = function(jwt_key) {
	var process = require('../models/process')(jwt_key);
	return {
		set: function(req, res) {
			process.set(req, function(err, data) {
				if (err)
					res.status(err.status).json({message: err.message});
				else
					res.json(data);
			});
		}
	}
}
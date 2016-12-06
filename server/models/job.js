var connection = require('../config/mysql');
var jwt = require('jsonwebtoken');
var fs = require('fs');
var jwt_key = fs.readFileSync('keys/jwt', 'utf8');

module.exports = {
	index: function(callback) {
		connection.query("SELECT *, HEX(id) AS id, HEX(contractor_id) AS contractor_id FROM jobs", function(err, data) {
			if (err)
				callback({errors: {database: {message: `Database error: ${err.code}.`}}});
			else
				callback(false, data)
		});
	},
	show: function(req, callback) {
		var query = "SELECT *, HEX(id) AS id, HEX(contractor_id) AS contractor_id FROM jobs WHERE HEX(id) = ? LIMI 1";
		connection.query(query, req.params.id, function(err, data) {
			if (err)
				callback({errors: {database: {message: `Database error: ${err.code}.`}}});
			else
				callback(false, data);
		});
	},	
	create: function(req, callback) {
		jwt.verify(req.cookies.token, jwt_key, function(err, data) {
			if (err)
				callback({errors: {jwt: {message: "Invalid token. Your session is ending, please login again."}}});
			else {
				var _data = {
					amount: req.body.amount,
					completion_date: req.body.completion_date,
					description: req.body.description,
					pickup_only: req.body.pickup_only,
					loader_onsite: req.body.loader_onsite,
					address: req.body.address,
					city: req.body.city,
					zip: req.body.zip
				};
				console.log("_data:", _data)
				connection.query("INSERT INTO jobs SET ?, id = UNHEX(REPLACE(UUID(), '-', '')), \
				contractor_id = UNHEX(?), created_at = NOW(), updated_at = NOW()", [_data, data.id], function(err) {
					console.log("sql:", this.sql);
					if (err)
						callback({errors: {database: {message: `Database error: ${err.code}.`}}});
					else 
						callback(false);				
				});
			}
		});
	},
	update: function(req, callback) {
		jwt.verify(req.cookies.token, jwt_key, function(err, data) {
			if (err)
				callback({errors: {jwt: {message: "Invalid token. Your session is ending, please login again."}}});
			else {
				var _data = {
					amount: req.body.amount,
					completion_date: req.body.completion_date,
					description: req.body.description,
					pickup_only: req.body.pickup_only,
					address: req.body.address,
					city: req.body.city,
					zip: req.body.zip
				}
				var query = "UPDATE jobs SET ?, updated_at = NOW() WHERE HEX(id) = ? AND HEX(contractor_id) = ? LIMIT 1";
				connection.query(query, [_data, req.params.id, data.id], function(err, data) {
					if (err)
						callback({errors: {database: {message: `Database error: ${err.code}.`}}});
					else
						callback(false);
				});
			}
		});
	},
	delete: function(req, callback) {
		jwt.verify(req.cookies.token, jwt_key, function(err, data) {
			if (err)
				callback({errors: {jwt: {message: "Invalid token. Your session is ending, please login again."}}});
			else
				var query = "DELETE FROM jobs WHERE HEX(id) = ? AND HEX(contractor_id) = ? LIMIT 1";
				connection.query(query, [req.params.id, data.id], function(err) {
					if (err)
						callback({errors: {database: {message: `Database error: ${err.code}.`}}});
					else
						callback(false);
				});
		});
	}
};
var connection = require('../config/mysql');
var bcrypt = require('bcrypt');
var jwt = require('jsonwebtoken');
var fs = require('fs');
var jwt_key = fs.readFileSync('keys/jwt', 'utf8');

module.exports = {
	// index: function(callback) {
	// 	connection.query("SELECT *, HEX(id) AS id FROM users", function(err, data) {
	// 		if (err)
	// 			callback({errors: {database: {message: "Please contact an admin."}}})
	// 		else
	// 			callback(false, data)
	// 	});
	// },
	// show: function(req, callback) {
	// 	jwt.verify(req.cookies.evergreen_token, jwt_key, function(err, data) {
	// 		if (err)
	// 			callback({errors: {jwt: {message: "Invalid token. Your session is ending, please login again."}}});
	// 		else {
	// 			var response = {};
	// 			var query = "SELECT * FROM users where HEX(id) = ? LIMIT 1";
	// 			connection.query(query, req.params.id, function(err){
	// 				if (err)
	// 					callback({errors: {jwt: {message: "Invalid token. Your session is ending, please login again."}}});
	// 				else {
	// 					response["user"] = data;
	// 					var query = "SELECT *, HEX(id) AS id FROM jobs where HEX(user_id) = ?"
	// 					connection.query(query, req.params.id, function(err, data){
	// 						if (err)
	// 							callback({errors: {jwt: {message: "Invalid token. Your session is ending, please login again."}}});
	// 						else {
	// 							response["jobs"] = data;
	// 							callback(false, response);
	// 						}
	// 					});
	// 				}
	// 			});
	// 		}
	// 	});
	// },
	update: function(req, callback) {
		jwt.verify(req.cookies.evergreen_token, jwt_key, function(err, data) {
			if (err)
				callback({errors: {jwt: {message: "Invalid token. Your session is ending, please login again."}}});
			else {
				var query = "UPDATE users SET ?, updated_at = NOW() WHERE HEX(id) = ? LIMIT 1";
				connection.query(query, [req.body, data.id], function(err) {
					if (err)
						callback({errors: {database: {message: "Please contact an admin."}}});
					else {
						// Retrieve updated user:
						var query = "SELECT *, HEX(id) AS id FROM users WHERE HEX(id) = ? LIMIT 1";
						connection.query(query, data.id, function(err, data) {
							if (err)
								callback({errors: {database: {message: "Please contact an admin."}}})
							else {
								var evergreen_token = jwt.sign({
									id: data[0].id,
									type: data[0].type,
									company: data[0].company,
									contact: data[0].contact
								}, jwt_key);
								callback(false, evergreen_token);
							}
						});
					}
				});
			}
		});
	},
	delete: function(req, callback) {
		jwt.verify(req.cookies.evergreen_token, jwt_key, function(err, data) {
			if (err)
				callback({errors: {jwt: {message: "Invalid token. Your session is ending, please login again."}}});
			else
				connection.query("DELETE FROM users WHERE HEX(id) = ? LIMIT 1", data.id, function(err) {
					if (err)
						callback({errors: {database: {message: "Please contact an admin."}}});
					else
						callback(false);
				});
		});
	},
	changePassword: function(req, callback){
		jwt.verify(req.cookies.evergreen_token, jwt_key, function(err, data) {
			if (err)
				callback({errors: {jwt: {message: "Invalid token. Your session is ending, please login again."}}});
			else {
				if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d$@$!%*?&](?=.{7,})/.test(req.body.new))
					callback({errors: {password : {message: "Password must be at least 8 characters long and have a lowercase letter, an uppercase letter, and a number."}}});
				else {
					bcrypt.genSalt(10, function(err, salt) {
						if (err)
							callback({errors: {salt: {message: "Salt error."}}})
						else
							bcrypt.hash(req.body.new, salt, function(err, hash) {
								if (err)
									callback({errors: {hash: {message: "Hash error."}}})
								else {
									var newPassword = {
										password: hash
									};
									var query = "UPDATE users SET ?, updated_at = NOW() WHERE HEX(id) = ? LIMIT 1";
									connection.query(query, [newPassword, data.id], function(err) {
										if (err)
											callback({errors: {database: {message: "Please contact an admin."}}});
										else {
											// Retrieve updated user:
											var query = "SELECT *, HEX(id) AS id FROM users WHERE HEX(id) = ? LIMIT 1";
											connection.query(query, data.id, function(err, data) {
												if (err)
													callback({errors: {database: {message: "Please contact an admin."}}})
												else {
													var evergreen_token = jwt.sign({
														id: data[0].id,
														type: data[0].type,
														company: data[0].company,
														contact: data[0].contact
													}, jwt_key);
													callback(false, evergreen_token);
												}
											});
										}
									});
								}
							});
					});
				}
			}
		});
	},
	register: function(req, callback) {
		if (req.body.type === undefined || !req.body.company || !req.body.contact || !req.body.email
		|| !req.body.password || !req.body.confirm_password)
			callback({errors: {form : {message: "All form fields are required."}}});
		else {
			// Check for unique email:
			var query = "SELECT email FROM users WHERE email = ? LIMIT 1";
			connection.query(query, req.body.email, function(err, data) {
				if (err)
					callback({errors: {database: {message: "Please contact an admin."}}})
				// If email already exists:
				else if (data.length > 0)
					callback({errors: {email: {message: "Email already in use, please log in."}}});
				// Validate company:
				else if (!req.body.company)
					callback({errors: {last_name : {message: "Company name cannot be blank."}}});
				// Validate contact:
				else if (!/^[a-z ]{2,32}$/i.test(req.body.contact))
					callback({errors: {last_name : {message: "Invalid contact name."}}});
				// Validate email:
				else if (!/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/.test(req.body.email))
					callback({errors: {email : {message: "Invalid email. Email format should be: email@mailserver.com."}}});
				// Validate password:
				else if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d$@$!%*?&](?=.{7,})/.test(req.body.password))
					callback({errors: {password : {message: "Password must be at least 8 characters long and have a lowercase letter, an uppercase letter, and a number."}}});
				// Validate confirm_password:
				else if (req.body.password != req.body.confirm_password)
					callback({errors: {confirm_password: {message: "Passwords do not match."}}});
				// Else valid new user:
				else
					// Encrypt password and save:
					bcrypt.genSalt(10, function(err, salt) {
						if (err)
							callback({errors: {salt: {message: "Salt error."}}})
						else
							bcrypt.hash(req.body.password, salt, function(err, hash) {
								if (err)
									callback({errors: {hash: {message: "Hash error."}}})
								else {
									var data = {
										id: "UNHEX(REPLACE(UUID(), '-', ''))",
										type: req.body.type,
										company: req.body.company,
										contact: req.body.contact,
										email: req.body.email,
										password: hash,
										created_at: "NOW()",
										updated_at: "NOW()"
									};
									connection.query("INSERT INTO users SET ?", data, function(err) {
										if (err)
											callback({errors: {database: {message: "Please contact an admin."}}})
										else {
											// Retrieve new user:
											var query = "SELECT *, HEX(id) as id FROM users WHERE email = ? LIMIT 1";
											connection.query(query, req.body.email, function(err, data) {
												if (err)
													callback({errors: {database: {message: "Please contact an admin."}}})
												else {
													var evergreen_token = jwt.sign({
														id: data[0].id,
														type: data[0].type,
														company: data[0].company,
														contact: data[0].contact
													}, jwt_key);
													callback(false, evergreen_token);
												}
											});
										}
									});
								}
							});
					});
			});
		}
	},
	login: function(req, callback) {
		// Validate login data:
		if (!req.body.email || !req.body.password)
			callback({errors: {login: {message: "All form fields are required."}}});
		else if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d$@$!%*?&](?=.{7,})/.test(req.body.password))
			callback({errors: {password: {message: "Invalid password."}}});
		else {
			// Get user by email:
			var query = "SELECT *, HEX(id) AS id FROM users WHERE email = ? LIMIT 1";
			connection.query(query, req.body.email, function(err, data) {
				if (err)
					callback({errors: {database: {message: "Please contact an admin."}}});
				else if (data.length == 0)
					callback({errors: {email: {message: "Email does not exist, please register."}}});
				else
					// Check valid password:
					bcrypt.compare(req.body.password, data[0].password, function(err, isMatch) {
						if (err)
							callback({errors: {bcrypt: {message: "Invalid email/password."}}});
						else if (!isMatch)
							callback({errors: {password: {message: "Email/password does not match."}}});
						else {
							var evergreen_token = jwt.sign({
								id: data[0].id,
								type: data[0].type,
								company: data[0].company,
								contact: data[0].contact
							}, jwt_key);
							callback(false, evergreen_token);
						}
					});
			});
		}
	}
};

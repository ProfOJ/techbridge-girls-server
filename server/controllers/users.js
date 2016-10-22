var mongoose = require('mongoose');
var bcrypt = require('bcrypt');

var User = mongoose.model('User');
module.exports = {
	index: function(req, res) {
		User.find({}, function(err, data) {
			if (err)
				res.json(err);
			else
				res.json(data);
		});
	},
	create: function(req, res) {
		if (req.body.password != req.body.confirm_password)
				res.json({error: "Passwords do not match."});

		var user = new User(req.body);

		// Check for unique email:
		User.findOne({email: user.email}, function(err, data) {
			if (err)
				res.json(err);
			else if (data.length > 0)
				res.json({error: "Email already registered."});

			// Check for unique username:
			User.findOne({username: user.username}, function(err, data) {
				if (err)
					res.json(err);
				else if (data.length > 0)
					res.json({error: "Username already in use."});

				user.save(function(err, data) {
					if (err) 
						res.json(err);
					else
						res.json(data);
				});
			});
		});
	},
	update: function(req, res) {
		User.update({_id: req.params.id}, {$set: {
			first_name: req.body.first_name,
			last_name: req.body.last_name,
			birthday: req.body.birthday
		}}, function(err, data) {
			if (err) 
				res.json(err);
			else
				res.json(data);
		});
	},
	delete: function(req, res) {
		User.remove({_id: req.params.id}, function(err, data) {
			if (err) 
				res.json(err);
			else
				res.json(data);
		});
	},
	show: function(req, res) {
		User.findOne({_id: req.params.id}, function(err, data) {
			if (err) 
				res.json(err);
			else
				res.json(data);
		});
	},
	login: function(req, res) {
		// Get user by username:
		User.findOne({username: req.body.username}, function(err, data) {
			if (err) 
				res.json(err);
			else {
				// Check valid password:
				user.comparePassword(req.body.password, function(err, isMatch) {
					if (err)
						res.json(err);
					else if (!isMatch)
						res.json({error: "Username/password does not match."});
					else
						res.json(data);
				});
			}
		});
	}
}
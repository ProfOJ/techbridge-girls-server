app.factory('usersFactory', function($http, $cookies) {
	return {
		// index: function(callback) {
		// 	$http.get('/api/users').then(function(res) {
		// 		callback(res.data);
		// 	});
		// },
		show: function(id, callback) {
			$http.get(`/api/users/${id}`, {
				headers: {'Authorization': `Bearer ${$cookies.get('evergreen_token')}`}
			}).then(function(res) {
				callback(res.data);
			}, function(res) {
				callback(res);
			});
		},
		update: function(data, callback) {
			$http.put(`/api/users`, data, {
				headers: {'Authorization': `Bearer ${$cookies.get('evergreen_token')}`}
			}).then(function(res) {
				callback(res.data);
			}, function(res) {
				callback(res);
			});
		},
		changePassword: function(data, callback) {
			$http.put(`/users/changePassword`, data, {
				headers: {'Authorization': `Bearer ${$cookies.get('evergreen_token')}`}
			}).then(function(res){
				callback(res.data);
			}, function(res) {
				callback(res);
			});
		},
		delete: function(callback) {
			$http.delete('/api/users', {
				headers: {'Authorization': `Bearer ${$cookies.get('evergreen_token')}`}
			}).then(function(res) {
				callback(res.data);
			}, function(res) {
				callback(res);
			});
		},
		register: function(data, callback) {
			$http.post('/users/register', data)
			.then(function(res) {
				callback(res.data);
			}, function(res) {
				callback(res);
			});
		},
		login: function(data, callback) {
			$http.post('/users/login', data)
			.then(function(res) {
				callback(res.data);
			}, function(res) {
				callback(res);
			});
		}
	}
})

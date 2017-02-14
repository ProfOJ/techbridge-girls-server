app.controller('profileController', function ($scope, $location, $routeParams, $rootScope, usersFactory, urlsFactory) {
	$scope.editingURLS = false;

	$scope.requestProfile = function() {
		usersFactory.show($scope.profilerequest, function(data) { //we could be viewing our own profile or another company's
			if (data.status == 401)
				$scope.logout();
			else if (data.status >= 300)
				$scope.error = data.data.message;
			else {
				$scope.user = data
				if ($scope.viewingOtherProfile) {
					$scope.companyprofile = data.company
				}
			}
		});
	} //this function is invoked when the controller loads.

	if (payload) {
		$scope.tab = "profile";
		$scope.company = payload.company; //used to determine whether some elements should be hidden or displayed.
		if ($routeParams.id) { //if there are parameters in the url then use them to query for the backend.
			$scope.viewingOtherProfile = true;
			$scope.profilerequest = $routeParams.id;
		} else {
			$scope.profilerequest = payload.id;
			$scope.requestProfile();
		}
	}
	else {
		$location.url('/');
	}


	$scope.switchEditingURLS = function() {
		$scope.editingURLS? $scope.editingURLS=false:$scope.editingURLS=true
	}

	$scope.updateURLS = function(){
		if (true) {
			urlsFactory.create($scope.user, function(data){
				$scope.switchEditingURLS()
				$scope.requestProfile()
			});
		} else {
			$scope.switchEditingURLS()
		}
	}

$scope.uploadPicture = function(){
	var request = new XMLHttpRequest();
	request.open("POST", "/uploadPicture");
	request.onload = function() {
		// console.log("response:", this.response)
		// console.log("responseText:", this.responseText)
		// var response = JSON.parse(this.response);
		console.log(Date.now())
		$location.url(`/profile#${Date.now()}`)
		// if (!response.message) {
		// 	$scope.proposal.files = responseText;
		// 	$scope.$apply();
		// 	$scope.create();
		// } else {
		// 	console.log(response.message);
		// }
	}
	var formData = new FormData(); //use FormData object to post picture with AJAX
	var _ = document.getElementById('picture').files[0];
	console.log(_)
	formData.append("picture", document.getElementById('picture').files[0]);
	request.send(formData);
}
});

app.controller('proposalsController', function ($scope, $location, proposalsFactory, offersFactory) {
	if (payload) {
		$scope.tab = "proposals";
		if ($scope.type == 0) {
			//Get proposals that you've created
			proposalsFactory.index(function(data){
				console.log(data);
				$scope.proposals = data
			});
		}
		else if ($scope.type == 1) {
			//Get proposals you've applied to
			proposalsFactory.index(function(data){
				$scope.proposals = data
			});
		}
	}
	else
		$location.url('/');


		$scope.getOffers = function(proposal){
			if ($scope.proposalView == proposal)
				$scope.proposalView = undefined;
			else
				offersFactory.index(proposal.id, function(data){
					$scope.offers = data;
					$scope.offerView = $scope.offers[0];
					$scope.proposalView = proposal;
					$scope.offerView.PPU = (parseFloat($scope.offerView.total)/parseFloat($scope.proposalView.quantity)).toFixed(2);
				});
		};

		$scope.getOffer = function(offer){
			$scope.offerView = offer;
			$scope.offerView.PPU = (parseFloat($scope.offerView.total)/parseFloat($scope.proposalView.quantity)).toFixed(2);
		};
})

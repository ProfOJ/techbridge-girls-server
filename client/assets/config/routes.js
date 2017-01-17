var app = angular.module('app', ['ngRoute', 'ngCookies']);
app.config(function ($routeProvider) {
	$routeProvider
	//////////////////////////////////////////////////////
	//										MAKER
	//////////////////////////////////////////////////////
	.when('/maker/create-proposal',{
		templateUrl: 'partials/maker/create-proposal.html',
		controller: 'createProposalController'
	})
	//////////////////////////////////////////////////////
	//										SUPPLIER
	//////////////////////////////////////////////////////
	.when('/supplier',{
		templateUrl: 'partials/supplier/open-proposals.html',
		controller: 'openProposalsController'
	})
	.when('/supplier/create-offer/:id',{
		templateUrl: 'partials/supplier/create-offer.html',
		controller: 'createOfferController'
	})
	.when('/supplier/processes',{
		templateUrl: 'partials/supplier/processes.html',
		controller: 'processesController'
	})
	//////////////////////////////////////////////////////
	//										SHARED
	//////////////////////////////////////////////////////
	.when('/',{
		templateUrl: 'partials/index.html',
		controller: 'indexController'
	})
	.when('/:user_type/join',{
		templateUrl: 'partials/join.html',
		controller: 'registerController'
	})
	.when('/login',{
		templateUrl: 'partials/login.html',
		controller: 'loginController'
	})
	.when('/recover',{
		templateUrl: 'partials/recover.html'
	})
	.when('/:user_type/dashboard',{
		templateUrl: 'partials/dashboard.html',
		controller: 'dashboardController'
	})
	.when('/:user_type/proposals',{
		templateUrl: 'partials/proposals.html',
		controller: 'proposalsController'
	})
	.when('/:user_type/success',{
		templateUrl: 'partials/success.html'
	})
	.when('/:user_type/tracking',{
		templateUrl: 'partials/tracking.html',
		controller: 'trackingController'
	})
	.when('/:user_type/profile',{
		templateUrl: 'partials/profile.html',
		controller: 'profileController'
	})
	.when('/:user_type/messages',{
		templateUrl: 'partials/messages.html',
		controller: 'messagesController'
	})
	.when('/proposal/:id',{
		templateUrl: 'partials/proposal.html',
		controller: 'proposalController'
	})
	.when('/logout',{
		templateUrl: 'partials/logout.html',
		controller: 'logoutController'
	})
	.otherwise({
		redirectTo: '/'
	});
});

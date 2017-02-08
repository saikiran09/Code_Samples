var app = angular.module('myApp');

app.directive("tile", function(chartService){
	return {
		restrict : "AE",
		//require: "MainCtrl",
		scope: {
			tiles: "=tiles",
			colnumber: "=colnumber",
			data: "=data"
		},
		templateUrl: "js/template/tile.html",
		// controller: "MainCtrl",
		// controllerAs: 'vm',
		bindToController: true,
		link: function(scope, element, attr, controller) {
			console.log(scope);

		}
	}
})
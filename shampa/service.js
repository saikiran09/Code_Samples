angular.module('myApp')
.service('chartService',  function($http,$q){
	var self = this;
	self.getCharts = function() {
		var deferred = $q.defer();
		var data;
		$http.get("data.json").success(function(response){
			data = response;
			deferred.resolve(data);
		});
		return deferred.promise;
	};
	
});
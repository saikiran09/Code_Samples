(function() {
    var app = angular.module('MyApp', []);

    //app.controller('MyAppController',function(){
   app.controller('MyAppController',['$http', function($http){
            var instance = this;
            instance.product = gem;
            instance.searchInput= "";
            instance.shows = [
                {
                    title: 'Game of Thrones',
                    year: 2011,
                    favorite: true
                },
                {
                    title: 'Walking Dead',
                    year: 2010,
                    favorite: false
                },
                {
                    title: 'Firefly',
                    year: 2002,
                    favorite: true
                },
                {
                    title: 'Banshee',
                    year: 2013,
                    favorite: true
                },
                {
                    title: 'Greys Anatomy',
                    year: 2005,
                    favorite: false
                }
            ];

            instance.orders = [
                {
                    id: 1,
                    title: 'Year Ascending',
                    key: 'year',
                    reverse: false
                },
                {
                    id: 2,
                    title: 'Year Descending',
                    key: 'year',
                    reverse: true
                },
                {
                    id: 3,
                    title: 'Title Ascending',
                    key: 'title',
                    reverse: false
                },
                {
                    id: 4,
                    title: 'Title Descending',
                    key: 'title',
                    reverse: true
                }
            ];
            instance.order = instance.orders[0];


            instance.new = {};
            instance.addShow = function() {
                instance.shows.push(instance.new);
                instance.new = {};
            };


       // });



            instance.tvshows= [];
            $http.get('package.json').success(function(data){
                instance.tvshows = data;
            });


    }]);


    var gem={
        name:'venky',
        price:'12.2'
    }
})();
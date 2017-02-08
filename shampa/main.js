angular.module('myApp', ['nvd3', 'angular.morris-chart'])
    .controller('MainCtrl', function($scope, $sce, chartOptions, chartService, $compile, $document, $anchorScroll){
    var self = this;
    chartService.getCharts().then(function(data){
            //var temp = $sce.trustAsHtml('bar.html');
            //$scope.activeTemplate = temp;
            //$compile($document.find("nvd3"));
            $scope.options = chartOptions;
            $scope.data = data;
            self.drawlineChart();
            self.renderDonut();
            //$scope.api.refreshWithTimeout(5);
        });

    this.drawlineChart = function(){
             Morris.Line({
                element: 'liveGraph',
                data: $scope.data.lineResult,
                xkey: 'x',
                ykeys: ['y', 'z'],
                labels: ['sin()', 'cos()'],
                parseTime: false,
                ymin: -1.0,
                ymax: 1.0,
                hideHover: true
            });
    }

    this.renderDonut = function(){
        Morris.Donut({
          element: 'donut',
          data: [
            {label: "Download Sales", value: 12},
            {label: "In-Store Sales", value: 30},
            {label: "Mail-Order Sales", value: 20}
          ]
        });

        Morris.Donut({
          element: 'donut1',
          data: $scope.data.donutResult,
          colors:['red','green', 'blue', 'yellow','pink']
        });
    }

    $scope.toggleSlideBar = function(){
        $("#wrapper").toggleClass("toggled");
        $scope.leftArrow = !$scope.leftArrow;
        $anchorScroll();
    }

    $("#accordion").accordion({
         collapsible: true,
         active: false
    });
    
    });
    // .directive("chartDirective", function() {
    //     return {
    //         restrict: 'A',
    //         scope: {
    //             options: "=options",
    //             data: "=data",
    //             api: "=api"
    //         },
    //         template: '<nvd3 options="options" data="data" api="api" class="with-3d-shadow with-transitions"></nvd3>',
    //         ink:function(scope,ele,attrs){
    //         ele.load(function(){
    //             scope.$apply(attrs.myFrame);
    //         });
    //     }
    //     }
    // });
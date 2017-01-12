app.controller('StartController', function($scope, $http, $location, $rootScope) {

  $scope.search = function() {
    var url = "/api/countries/?minimum_size=" + $scope.minimumSizedCountry.area +
                             "&maximum_size=" + $scope.maximumSizedCountry.area +
                             "&count=" + $scope.count;
    $http({method: 'GET', url: url}).then(
      function successCallback(response) {
        $rootScope.countries = response.data.countries;
        $rootScope.criteria = {
          "min": $scope.minimumSizedCountry.area,
          "max": $scope.maximumSizedCountry.area,
          "count": $scope.count,
          "shown": $scope.showField
        }
        if ($scope.countries.length > 0) {
          $location.path("/country");
        } else {
          $scope.message("No countries found. Adjust your criteria");
        }
      },
      function errorCallback(response) {
      });
  }

  $scope.refresh = function() {
    $scope.count = "6";
    $scope.showField = "capital";

    $http({method: 'GET', url: "/api/countries/?fields=sizes&sort=area"}).then(
      function successCallback(response) {
        $scope.countries = response.data.countries;
        $scope.minimumSizedCountry = $scope.countries[20];
        $scope.maximumSizedCountry = $scope.countries[200];
      },
      function errorCallback(response) {
      });
  }

  $scope.hideMessage = function() { delete $scope.message};

  $scope.refresh();
});

app.controller('CountryController', function($scope, $location, $rootScope) {

  $scope.initialize = function() {
    if ($rootScope.countries === undefined) {
      $scope.restart();
    } else {
      $scope.countries = $rootScope.countries;
      $scope.criteria = $rootScope.criteria;
      $scope.field = $scope.criteria.shown;
      $scope.successes = 0;
      $scope.tries = 0;
      $scope.next();
    }
  }

  $scope.next = function() {
    $scope.country = $scope.countries.shift(0);
    if ($scope.country.capital == "") {
      $scope.country.capital = "No capital specified";
    }
    if ($scope.country.subRegion == "") {
      delete $scope.country.subRegion;
    }
    showCountries($scope.countries, "Next: " + $scope.country.id);
    $scope.showAll = false;
    $scope.showRegion = false;
    $scope.showJSON = false;
  }

  $scope.success = function() {
    $scope.successes++;
    $scope.tries++;
    if ($scope.successes >= $scope.criteria.count) {
      $scope.allDone = true;
    } else {
      $scope.next();
    }
  }

  $scope.resort = function() {
    var id = $scope.country.id;
    while ($scope.countries.length!=1) {
      $scope.countries = shuffle($scope.countries);
      if ($scope.countries[0].id != id) {
        break;
      }
    }
  }

  $scope.failure = function() {
    $scope.countries.push($scope.country);
    $scope.resort();
    $scope.next();
    $scope.tries++;
  }

  $scope.restart = function() {
    $location.path("/");
  }

  $scope.initialize();
});

function shuffle(array) {
  var currentIndex = array.length, temporaryValue, randomIndex;

  // While there remain elements to shuffle...
  while (0 !== currentIndex) {

    // Pick a remaining element...
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex -= 1;

    // And swap it with the current element.
    temporaryValue = array[currentIndex];
    array[currentIndex] = array[randomIndex];
    array[randomIndex] = temporaryValue;
  }

  return array;
}

function showCountries(c,msg) {
  console.log(msg)
    for (var i in c) {
      console.log(c[i].id);
    }

}
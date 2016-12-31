
var app = angular.module("countryApp", ["ngRoute"]);

app.config(function($routeProvider) {
    $routeProvider
    .when("/", {
        templateUrl : "app/views/start/start.html",
        controller: "StartController"
    })
    .when("/country", {
        templateUrl : "/app/views/country/country.html",
        controller: "CountryController"
    })
    .otherwise({
        redirectTo: "/"
    });
});
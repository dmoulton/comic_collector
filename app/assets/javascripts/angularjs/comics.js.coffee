@app = angular.module('Comics', ['ngResource']).config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode(true)
  $routeProvider.when("/",
    templateUrl: '/partials/books.html'
  ).when("/books/:bookId",
    templateUrl:  '/partials/issues.html'
  ).otherwise("/")
]
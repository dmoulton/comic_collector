@app = angular.module('Comics', ['ngResource']).config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode(true)
  $routeProvider.when('/',
    controller:  'BooksCtrl'
    templateUrl: '/partials/books.html'
  )

  $routeProvider.when '/books/:bookId',
    controller:   'BooksCtrl'
    templateUrl:  '/partials/issues.html'

  $routeProvider.otherwise('/')
]
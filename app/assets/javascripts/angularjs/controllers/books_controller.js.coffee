@app.controller 'BooksCtrl', ["$scope", "$http", "$resource", "$location","$route","$routeParams", "$window", ($scope, $http, $resource, $location, $route, $routeParams, $window) ->
  Book = $resource("/books/:id", {id: "@id"}, {update: {method: "PUT"}})
  Issue = $resource("/books/:book_id/issues/:id", {book_id: "@book_id",id: "@id"}, {update: {method: "PUT"}})
  $scope.issueOrder = "number"

  loadBooks = ->
    $scope.books = Book.query () ->
      bookId = $routeParams.bookId
      if bookId and bookId > 0
        book = $scope.books.filter((b, i) ->
          b.id is parseInt(bookId)
        )
        $scope.showBook(book)

  $scope.showBook = (book) ->
    $scope.largeImage = book.cover_image_url
    $scope.selectedBook = book
    $location.path('/books/' + book.id)
    $scope.issues = Issue.query(book_id: book.id)
    $scope.newIssue = {}

  $scope.totalPrice = (issues) ->
    sum = 0
    issues = [] if issues is undefined
    for issue in issues
      sum += parseFloat(issue.price)
    sum

  $scope.saveIssue = () ->
    $scope.newIssue.book_id = $scope.selectedBook.id
    $scope.newIssue.number = parseInt($scope.newIssue.number)
    $scope.newIssue.price = parseFloat($scope.newIssue.price)
    $scope.issues.push $scope.newIssue
    Issue.save($scope.newIssue)
    $scope.newIssue = {}

  $scope.setLargeImage = (url) ->
    $scope.largeImage = url

  loadBooks()
]
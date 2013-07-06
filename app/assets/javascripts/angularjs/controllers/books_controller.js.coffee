@app.controller "BooksCtrl", ($scope, $resource, $location, $routeParams) ->
  Book  = $resource("/books/:id", {id: "@id"}, {update: {method: "PUT"}})
  Issue = $resource("/books/:book_id/issues/:id", {book_id: "@book_id",id: "@id"}, {update: {method: "PUT"}})
  $scope.issueOrder = "number"
  $scope.reversed = true

  loadBooks = ->
    $scope.books = Book.query () ->
      bookId = $routeParams.bookId
      if bookId > 0
        book = $scope.books.filter((b, i) ->
          b.id is parseInt(bookId)
        )[0]
        $scope.showBook(book)

  $scope.showBook = (book) ->
    $scope.largeImage   = book.cover_image_url
    $scope.selectedBook = book
    $location.path('/books/' + book.id) unless $location.path == '/books/' + book.id
    $scope.issues   = Issue.query(book_id: book.id)
    $scope.newIssue = {}

  $scope.totalPrice = (issues = []) ->
    sum = 0
    for issue in issues
      sum += parseFloat(issue.price)
    sum

  $scope.saveIssue = () ->
    $scope.newIssue.book_id = $scope.selectedBook.id
    $scope.newIssue.number  = parseInt($scope.newIssue.number)  #for proper sorting
    $scope.newIssue.price   = parseFloat($scope.newIssue.price) #for proper sorting
    $scope.issues.push $scope.newIssue
    Issue.save($scope.newIssue)
    $scope.newIssue = {}

  $scope.setLargeImage = (url) ->
    $scope.largeImage = url

  loadBooks()

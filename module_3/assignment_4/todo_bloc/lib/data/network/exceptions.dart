/// Rest API service exceptions.
class UserRegistrationError implements Exception {
  final String message;
  UserRegistrationError(this.message);
}

class UserLoginException implements Exception {
  final String message;
  UserLoginException(this.message);
}

class GetAllTodosException implements Exception {
  final String message;
  GetAllTodosException(this.message);
}

class UpdateTodoException implements Exception {
  final String message;
  UpdateTodoException(this.message);
}

class AddTodoException implements Exception {
  final String message;
  AddTodoException(this.message);
}

class DeleteTodoException implements Exception {
  final String message;
  DeleteTodoException(this.message);
}

class NotAuthorizedException implements Exception {}

/// Rest API service exceptions.
class UserRegistrationError implements Exception {
  final String message;
  UserRegistrationError(this.message);
}

class UserLoginError implements Exception {
  final String message;
  UserLoginError(this.message);
}

class GetAllTodosError implements Exception {
  final String message;
  GetAllTodosError(this.message);
}

class UpdateTodoError implements Exception {
  final String message;
  UpdateTodoError(this.message);
}

class AddTodoError implements Exception {
  final String message;
  AddTodoError(this.message);
}

class DeleteTodoError implements Exception {
  final String message;
  DeleteTodoError(this.message);
}

class NotAuthorizedError implements Exception {}

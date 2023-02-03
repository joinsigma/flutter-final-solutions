/// Rest API service exceptions.
class UserLoginError implements Exception {
  final String message;
  UserLoginError(this.message);
}

class UserRefreshSessionError implements Exception {}

class UserRegistrationError implements Exception {
  final String message;
  UserRegistrationError(this.message);
}

class GetAllTodosError implements Exception {
  final String message;
  GetAllTodosError(this.message);
}

class GetTodoError implements Exception {
  final String message;
  GetTodoError(this.message);
}

class AddTodoError implements Exception {
  final String message;
  AddTodoError(this.message);
}

class UpdateTodoError implements Exception {
  final String message;
  UpdateTodoError(this.message);
}

class DeleteTodoError implements Exception {
  final String message;
  DeleteTodoError(this.message);
}

class NotAuthorizedError implements Exception {}

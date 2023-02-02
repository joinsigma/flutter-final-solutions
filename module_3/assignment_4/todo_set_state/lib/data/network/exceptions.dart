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

class AddTodoError implements Exception {
  final String message;
  AddTodoError(this.message);
}

class NotAuthorizedError implements Exception {}

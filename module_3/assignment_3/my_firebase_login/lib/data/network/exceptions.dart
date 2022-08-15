/// Todo 6: Create exceptions for Rest API service

class UserLoginError implements Exception {
  final String errorMsg;
  UserLoginError(this.errorMsg);
}

class UserRegistrationError implements Exception {
  final String errorMsg;
  UserRegistrationError(this.errorMsg);
}

// Used to throw this whenever CRUD is performed by unauthenticated user
class AuthTokenNotFoundException implements Exception {
  final String errorMsg;
  AuthTokenNotFoundException(this.errorMsg);
}

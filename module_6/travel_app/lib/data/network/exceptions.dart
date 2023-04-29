/// Rest API service exceptions.
class UserRegistrationException implements Exception {
  final String message;
  UserRegistrationException(this.message);
}

class UserLoginException implements Exception {
  final String message;
  UserLoginException(this.message);
}

class ProfileImageUploadException implements Exception {}
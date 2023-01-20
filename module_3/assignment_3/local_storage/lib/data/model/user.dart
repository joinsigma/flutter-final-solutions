/// Todo 4: Create Firebase user model
class User {
  final String uid;
  final String email;
  final String refreshToken; // Firebase Auth refresh token
  final String authToken; // Firebase Auth ID Token
  final String expiresIn; // Number of seconds where ID Token expires

  User({
    required this.uid,
    required this.email,
    required this.refreshToken,
    required this.authToken,
    required this.expiresIn,
  });

  User.fromJson(Map<String, dynamic> json)
      : uid = json['localId'] as String,
        email = json['email'] as String,
        refreshToken = json['refreshToken'] as String,
        authToken = json['idToken'] as String,
        expiresIn = json['expiresIn'] as String;
}
class AuthDto {
  final String email;
  final String password;
  final String? googleIdToken;
  
  AuthDto({
    required this.email,
    required this.password,
    this.googleIdToken
  });


  // Convert a FileStorageRef object to a map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      if (googleIdToken != null) 'googleIdToken': googleIdToken,
    };
  }
}

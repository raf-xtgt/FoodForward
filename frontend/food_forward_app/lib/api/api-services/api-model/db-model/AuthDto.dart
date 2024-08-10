class AuthDto {
  final String email;
  final String password;
  final String? userId;
  
  AuthDto({
    required this.email,
    required this.password,
    this.userId
  });


  // Convert a FileStorageRef object to a map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      if (userId != null) 'userId': userId,
    };
  }
}

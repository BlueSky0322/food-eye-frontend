class UserLoginResponse {
  final String userId;
  final String userRole;

  UserLoginResponse({
    required this.userId,
    required this.userRole,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) {
    return UserLoginResponse(
      userId: json['userId'],
      userRole: json['userRole'],
    );
  }
}

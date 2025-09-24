class SignupRequest {
  final String message;
  final String token;
  final String refreshToken;
  final String name;
  final String email;
  final String phone;
  final String password;
  final bool isAccepted;
  final String deviceToken;
  SignupRequest({
    required this.message,
    required this.token,
    required this.refreshToken,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.isAccepted,
    required this.deviceToken,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) {
    return SignupRequest(
      message: json['message'],
      token: json['token'],
      refreshToken: json['refreshToken'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      isAccepted: json['isAccepted'],
      deviceToken: json['deviceToken'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'refreshToken': refreshToken,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'isAccepted': isAccepted,
      'deviceToken': deviceToken,
    };
  }
}

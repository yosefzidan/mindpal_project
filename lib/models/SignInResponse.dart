/// message : "success"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODIwNzdhZmZiNTYwNDMyNTQ5Y2M5MGYiLCJyb2xlIjoiZG9jdG9yIiwiaWF0IjoxNzQ3MjI3NjAyfQ.jiX2SnOWZkEZylCv9IgZYD8mcTF_6ixxf1rN_h67SBk"

class SignInRequest {
  SignInRequest({
    this.name,
    this.password,
    this.role,
    this.deviceToken,
  });

  String? name;
  String? password;
  String? role;
  String? deviceToken;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': password,
      'role': role,
      'deviceToken': deviceToken,
    };
  }
}

class SignInResponse {
  SignInResponse({
    this.message,
    this.token,
  });

  String? message;
  String? token;

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      message: json['message'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
    };
  }
}

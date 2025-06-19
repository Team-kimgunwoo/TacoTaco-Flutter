class SignInRequest {
  String email;
  String password;

  SignInRequest({
    this.email = '',
    this.password = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

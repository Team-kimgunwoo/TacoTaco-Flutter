class SignUpRequest {
  String email;
  String password1;
  String password2;
  String name;

  SignUpRequest({
    this.email = '',
    this.password1 = '',
    this.password2 = '',
    this.name = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password1,
      'name': name,
    };
  }
}

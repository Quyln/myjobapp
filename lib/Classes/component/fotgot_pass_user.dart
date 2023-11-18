class ForgotPassUser {
  String id;
  String email;

  ForgotPassUser({required this.id, required this.email});

  static Map<String, dynamic> toJson(ForgotPassUser data) {
    return {'id': data.id, 'email': data.email};
  }
}

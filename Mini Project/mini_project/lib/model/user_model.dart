class User {
  String? email;
  String? facebook;
  String? firstName;
  String? google;
  bool? isEmailVerified;
  String? phoneNumber;
  List<String>? role;

  User(
      {this.email,
      this.facebook,
      this.firstName,
      this.google,
      this.isEmailVerified,
      this.phoneNumber,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    facebook = json['facebook'];
    firstName = json['firstName'];
    google = json['google'];
    isEmailVerified = json['isEmailVerified'];
    phoneNumber = json['phoneNumber'];
    role = json['role'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['facebook'] = facebook;
    data['firstName'] = firstName;
    data['google'] = google;
    data['isEmailVerified'] = isEmailVerified;
    data['phoneNumber'] = phoneNumber;
    data['role'] = role;
    return data;
  }
}

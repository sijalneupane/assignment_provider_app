class SignupModel {
  String? contact;
  String? email;
  String? gender;
  String? name;
  String? password;
  String? role;
  String? username;

  SignupModel(
      {this.contact,
      this.email,
      this.gender,
      this.name,
      this.password,
      this.role,
      this.username});

  SignupModel.fromJson(Map<String, dynamic> json) {
    contact = json['contact'];
    email = json['email'];
    gender = json['gender'];
    name = json['name'];
    password = json['password'];
    role = json['role'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['name'] = this.name;
    data['password'] = this.password;
    data['role'] = this.role;
    data['username'] = this.username;
    return data;
  }
}

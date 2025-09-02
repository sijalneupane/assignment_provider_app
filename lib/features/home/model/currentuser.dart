class CurrentUser {
  int? id;
  String? username;
  String? email;
  String? name;
  String? gender;
  String? role;
  String? contact;

  CurrentUser(
      {this.id,
      this.username,
      this.email,
      this.name,
      this.gender,
      this.role,
      this.contact});

  CurrentUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    name = json['name'];
    gender = json['gender'];
    role = json['role'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['role'] = this.role;
    data['contact'] = this.contact;
    return data;
  }
}

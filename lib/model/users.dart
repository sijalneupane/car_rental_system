class Users {
  String? userId;
  String? name;
  String? email;
  String? password;
  String? profileImageUrl;

  Users(
      {this.userId,
      this.name,
      this.email,
      this.password,
      this.profileImageUrl});

  Users.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    profileImageUrl = json['profileImageUrl'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId ?? "";
    data['name'] = this.name ?? "Unknown ";
    data['email'] = this.email ?? "User";
    data['password'] = this.password;
    data['profileImageUrl'] = this.profileImageUrl ?? "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png";
    return data;
  }
}


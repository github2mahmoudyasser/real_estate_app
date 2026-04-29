


class LoginModel {
  final UserData? data;

  LoginModel({this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  final User? user;
  final String? token;
  final String? tokenType;

  UserData({this.user, this.token, this.tokenType});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      token: json['token'],
      tokenType: json['token_type'],
    );
  }
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? role;
  final String? location;
  final String? phone;
  final DateTime? createdAt;

  User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.location,
    this.phone,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      location: json['location'],
      phone: json['phone'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}
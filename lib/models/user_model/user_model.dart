class UserModel {
  final String expiresOn;
  final String token;
  final User user;
  final String userId;

  UserModel({
    required this.expiresOn,
    required this.token,
    required this.user,
    required this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      expiresOn: json['expiresOn'],
      token: json['token'],
      user: User.fromJson(json['user']),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expiresOn': expiresOn,
      'token': token,
      'user': user.toJson(),
      'userId': userId,
    };
  }
}

class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final List<String> role;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      role: List<String>.from(json['role']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'role': role,
    };
  }
}

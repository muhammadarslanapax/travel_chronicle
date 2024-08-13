
class UserModel {
  final String userId;
  final String userEmail;
  final String userName;
  final String userImg;
  final String? city;
  final String? country;
  final bool accountStatus;
  final bool premium;

  UserModel({
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.userImg,
    required this.accountStatus,
    this.country,
    this.city,
    required this.premium,
  });

  // Factory constructor for creating a new UserModel instance from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      userEmail: map['userEmail'],
      userName: map['userName'],
      userImg: map['userImg'],
      country: map['country'],
      city: map['city'],
      accountStatus: map['accountStatus'],
      premium : map["premium"]
    );
  }

  // Method for converting a UserModel instance to a map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'userName': userName,
      'country': country,
      'city': city,
      'userImg': userImg,
      'accountStatus': accountStatus,
      "premium":premium
    };
  }

  // Factory constructor for creating a new UserModel instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      userEmail: json['userEmail'],
      userName: json['userName'],
      city: json['city'],
      country: json['country'],
      userImg: json['userImg'],
      accountStatus: json['accountStatus'],
      premium:json["premium"]
    );
  }

  // Method for converting a UserModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'userName': userName,
      'userImg': userImg,
      'country': country,
      'city': city,
      'accountStatus': accountStatus,
      "premium":premium
    };
  }
}

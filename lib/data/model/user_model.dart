class UserModel {
  final String userId;
  final String userEmail;
  final String userName;
  final String userImg;
  final String? city;
  final String? country;
  final bool accountStatus;
  final bool cloudSubscription;
  final bool extraPhotoSubscription;
  final bool allSubscription;
  final bool exportPdfSubscription;
  final bool skinColorSubscription;
  final bool unlimitedTripSubscription;
  final bool unlockPassportSubscription;

  UserModel({
    required this.allSubscription,
    required this.exportPdfSubscription,
    required this.skinColorSubscription,
    required this.unlimitedTripSubscription,
    required this.unlockPassportSubscription,
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.userImg,
    required this.accountStatus,
    this.country,
    this.city,
    required this.cloudSubscription,
    required this.extraPhotoSubscription,
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
      cloudSubscription: map["cloudSubscription"],
      extraPhotoSubscription: map["extraPhotoSubscription"],
      allSubscription: map["allSubscription"],
      exportPdfSubscription: map["exportPdfSubscription"],
      skinColorSubscription: map["skinColorSubscription"],
      unlimitedTripSubscription: map["unlimitedTripSubscription"],
      unlockPassportSubscription: map["unlockPassportSubscription"],
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
      "cloudSubscription": cloudSubscription,
      "extraPhotoSubscription": extraPhotoSubscription,
      "allSubscription": allSubscription,
      "exportPdfSubscription": exportPdfSubscription,
      "skinColorSubscription": skinColorSubscription,
      "unlimitedTripSubscription": unlimitedTripSubscription,
      "unlockPassportSubscription": unlockPassportSubscription,
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
        cloudSubscription: json["cloudSubscription"],
        extraPhotoSubscription: json["extraPhotoSubscription"],
        allSubscription: json["allSubscription"],
        exportPdfSubscription: json["exportPdfSubscription"],
        skinColorSubscription: json["skinColorSubscription"],
        unlimitedTripSubscription: json["unlimitedTripSubscription"],
        unlockPassportSubscription: json["unlockPassportSubscription"]);
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
      "cloudSubscription": cloudSubscription,
      "extraPhotoSubscription": extraPhotoSubscription,
      "allSubscription": allSubscription,
      "exportPdfSubscription": exportPdfSubscription,
      "skinColorSubscription": skinColorSubscription,
      "unlimitedTripSubscription": unlimitedTripSubscription,
      "unlockPassportSubscription": unlockPassportSubscription,
    };
  }
}

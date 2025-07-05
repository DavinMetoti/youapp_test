import 'package:youapp/features/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required super.name,
    required super.birthday,
    required super.height,
    required super.weight,
    required super.interests,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      birthday: json['birthday'],
      height: json['height'],
      weight: json['weight'],
      interests: List<String>.from(json['interests']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthday': birthday,
      'height': height,
      'weight': weight,
      'interests': interests,
    };
  }

}

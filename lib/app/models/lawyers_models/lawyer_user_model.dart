import 'dart:convert';

import 'package:talktomylawyer/app/models/lawyers_models/law_categories_model.dart';

class LawyerModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? profilePic;
  String? numberOfExperience;
  String? lastEducation;
  String? barCouncilNumber;
  String? licence;
  String? nid;
  String? createdAt;
  String? updatedAt;
  List<CategoryModel>? categories;
  String? language;
  String? languages;
  String? consultationFee;
  String? biography;

  LawyerModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.profilePic,
    this.numberOfExperience,
    this.lastEducation,
    this.barCouncilNumber,
    this.licence,
    this.nid,
    this.createdAt,
    this.updatedAt,
    this.categories,
    this.language,
    this.languages,
    this.consultationFee,
    this.biography,
  });

  factory LawyerModel.fromMap(Map<String, dynamic> map) {
    return LawyerModel(
      id: map['id'] as int?,
      name: map['name'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      address: map['address'] as String?,
      profilePic: map['profile_pic'] as String?,
      numberOfExperience: map['number_of_experience'] as String?,
      lastEducation: map['last_education'] as String?,
      barCouncilNumber: map['bar_coucil_number'] as String?,
      licence: map['licence'] as String?,
      nid: map['nid'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      categories: (map['categories'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      language: map['language'] as String?,
      languages: map['languages'] as String?,
      consultationFee:
          map['cosulation_fee']?.toString() ??
          map['consultation_fee']?.toString(),
      biography: map['biography'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'profile_pic': profilePic,
      'number_of_experience': numberOfExperience,
      'last_education': lastEducation,
      'bar_coucil_number': barCouncilNumber,
      'licence': licence,
      'nid': nid,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'categories': categories?.map((e) => e.toMap()).toList(),
      'language': language,
      'languages': languages,
      'cosulation_fee': consultationFee,
      'biography': biography,
    };
  }

  String toJson() => json.encode(toMap());

  factory LawyerModel.fromJson(String source) =>
      LawyerModel.fromMap(json.decode(source));
}

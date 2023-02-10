import 'package:json_annotation/json_annotation.dart';
part 'profile_model.g.dart';

@JsonSerializable(explicitToJson: false)
class ProfileModel {
  int? status_code;
  String? message;
  String? errors;
  DataProfile? data;

  ProfileModel({this.status_code, this.message, this.errors, this.data});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}

@JsonSerializable(explicitToJson: false)
class DataProfile {
  int? id;
  int? position_id;
  String? position_name;
  String? name;
  String? email;
  String? phone;
  String? personal_email;
  int? genderId;
  String? gender;
  String? dob;
  String? avatar;
  String? address;
  String? about;
  String? citizen_id;
  String? last_online_at;
  String? join_company_at;
  String? up_official_at;
  String? last_company;
  int? total_posts;
  int? total_viewed;
  int? total_likes;
  int? total_amais;
  int? total_points;
  int? amai_votes;
  String? created_at;
  Socials? socials;
  Education? education;
  Bank? bank;
  Incognito? incognito;
  int? work_status;
  String? work_status_name;
  String? department;
  bool? have_lunch_menu;

  DataProfile(
      {this.id,
      this.position_id,
      this.position_name,
      this.name,
      this.email,
      this.phone,
      this.personal_email,
      this.genderId,
      this.gender,
      this.dob,
      this.avatar,
      this.address,
      this.about,
      this.citizen_id,
      this.last_online_at,
      this.join_company_at,
      this.up_official_at,
      this.last_company,
      this.total_posts,
      this.total_viewed,
      this.total_likes,
      this.total_amais,
      this.total_points,
      this.amai_votes,
      this.created_at,
      this.socials,
      this.education,
      this.bank,
      this.incognito,
      this.work_status,
      this.work_status_name,
      this.department,
      this.have_lunch_menu});

  factory DataProfile.fromJson(Map<String, dynamic> json) => _$DataProfileFromJson(json);
  Map<String, dynamic> toJson() => _$DataProfileToJson(this);
}

@JsonSerializable(explicitToJson: false)
class Socials {
  String? facebook_url;
  String? facebook_username;
  String? telegram_url;
  String? telegram_username;

  Socials({this.facebook_url, this.facebook_username, this.telegram_url, this.telegram_username});

  factory Socials.fromJson(Map<String, dynamic> json) => _$SocialsFromJson(json);
  Map<String, dynamic> toJson() => _$SocialsToJson(this);
}

@JsonSerializable(explicitToJson: false)
class Education {
  int? graded;
  String? graded_name;
  String? gpa;
  String? gpa_format;
  String? university_code;
  String? university_name;

  Education({this.graded, this.graded_name, this.gpa, this.gpa_format, this.university_code, this.university_name});
  factory Education.fromJson(Map<String, dynamic> json) => _$EducationFromJson(json);
  Map<String, dynamic> toJson() => _$EducationToJson(this);
}

@JsonSerializable()
class Bank {
  String? account_number;
  String? bank;
  String? bank_agency;
  String? name;
  String? short_name;

  Bank({this.account_number, this.bank, this.bank_agency, this.name, this.short_name});
  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);
  Map<String, dynamic> toJson() => _$BankToJson(this);
}

@JsonSerializable()
class Incognito {
  int? id;
  String? name;
  String? avatar;
  String? about;

  Incognito({this.id, this.name, this.avatar, this.about});

  factory Incognito.fromJson(Map<String, dynamic> json) => _$IncognitoFromJson(json);
  Map<String, dynamic> toJson() => _$IncognitoToJson(this);
}

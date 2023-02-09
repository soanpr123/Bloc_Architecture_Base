// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      status_code: json['status_code'] as int?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
      data: json['data'] == null
          ? null
          : DataProfile.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'status_code': instance.status_code,
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataProfile _$DataProfileFromJson(Map<String, dynamic> json) => DataProfile(
      id: json['id'] as int?,
      position_id: json['position_id'] as int?,
      position_name: json['position_name'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      personal_email: json['personal_email'] as String?,
      genderId: json['genderId'] as int?,
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      avatar: json['avatar'] as String?,
      address: json['address'] as String?,
      about: json['about'] as String?,
      citizen_id: json['citizen_id'] as String?,
      last_online_at: json['last_online_at'] as String?,
      join_company_at: json['join_company_at'] as String?,
      up_official_at: json['up_official_at'] as String?,
      last_company: json['last_company'] as String?,
      total_posts: json['total_posts'] as int?,
      total_viewed: json['total_viewed'] as int?,
      total_likes: json['total_likes'] as int?,
      total_amais: json['total_amais'] as int?,
      total_points: json['total_points'] as int?,
      amai_votes: json['amai_votes'] as int?,
      created_at: json['created_at'] as String?,
      socials: json['socials'] == null
          ? null
          : Socials.fromJson(json['socials'] as Map<String, dynamic>),
      education: json['education'] == null
          ? null
          : Education.fromJson(json['education'] as Map<String, dynamic>),
      bank: json['bank'] == null
          ? null
          : Bank.fromJson(json['bank'] as Map<String, dynamic>),
      incognito: json['incognito'] == null
          ? null
          : Incognito.fromJson(json['incognito'] as Map<String, dynamic>),
      work_status: json['work_status'] as int?,
      work_status_name: json['work_status_name'] as String?,
      department: json['department'] as String?,
      have_lunch_menu: json['have_lunch_menu'] as bool?,
    );

Map<String, dynamic> _$DataProfileToJson(DataProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position_id': instance.position_id,
      'position_name': instance.position_name,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'personal_email': instance.personal_email,
      'genderId': instance.genderId,
      'gender': instance.gender,
      'dob': instance.dob,
      'avatar': instance.avatar,
      'address': instance.address,
      'about': instance.about,
      'citizen_id': instance.citizen_id,
      'last_online_at': instance.last_online_at,
      'join_company_at': instance.join_company_at,
      'up_official_at': instance.up_official_at,
      'last_company': instance.last_company,
      'total_posts': instance.total_posts,
      'total_viewed': instance.total_viewed,
      'total_likes': instance.total_likes,
      'total_amais': instance.total_amais,
      'total_points': instance.total_points,
      'amai_votes': instance.amai_votes,
      'created_at': instance.created_at,
      'socials': instance.socials,
      'education': instance.education,
      'bank': instance.bank,
      'incognito': instance.incognito,
      'work_status': instance.work_status,
      'work_status_name': instance.work_status_name,
      'department': instance.department,
      'have_lunch_menu': instance.have_lunch_menu,
    };

Socials _$SocialsFromJson(Map<String, dynamic> json) => Socials(
      facebook_url: json['facebook_url'] as String?,
      facebook_username: json['facebook_username'] as String?,
      telegram_url: json['telegram_url'] as String?,
      telegram_username: json['telegram_username'] as String?,
    );

Map<String, dynamic> _$SocialsToJson(Socials instance) => <String, dynamic>{
      'facebook_url': instance.facebook_url,
      'facebook_username': instance.facebook_username,
      'telegram_url': instance.telegram_url,
      'telegram_username': instance.telegram_username,
    };

Education _$EducationFromJson(Map<String, dynamic> json) => Education(
      graded: json['graded'] as int?,
      graded_name: json['graded_name'] as String?,
      gpa: json['gpa'] as String?,
      gpa_format: json['gpa_format'] as String?,
      university_code: json['university_code'] as String?,
      university_name: json['university_name'] as String?,
    );

Map<String, dynamic> _$EducationToJson(Education instance) => <String, dynamic>{
      'graded': instance.graded,
      'graded_name': instance.graded_name,
      'gpa': instance.gpa,
      'gpa_format': instance.gpa_format,
      'university_code': instance.university_code,
      'university_name': instance.university_name,
    };

Bank _$BankFromJson(Map<String, dynamic> json) => Bank(
      account_number: json['account_number'] as String?,
      bank: json['bank'] as String?,
      bank_agency: json['bank_agency'] as String?,
      name: json['name'] as String?,
      short_name: json['short_name'] as String?,
    );

Map<String, dynamic> _$BankToJson(Bank instance) => <String, dynamic>{
      'account_number': instance.account_number,
      'bank': instance.bank,
      'bank_agency': instance.bank_agency,
      'name': instance.name,
      'short_name': instance.short_name,
    };

Incognito _$IncognitoFromJson(Map<String, dynamic> json) => Incognito(
      id: json['id'] as int?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      about: json['about'] as String?,
    );

Map<String, dynamic> _$IncognitoToJson(Incognito instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'about': instance.about,
    };

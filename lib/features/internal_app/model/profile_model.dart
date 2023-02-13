class ProfileModel {
  int? statusCode;
  String? message;
  String? errors;
  DataProfile? data;

  ProfileModel({this.statusCode, this.message, this.errors, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    errors = json['errors'];
    data = json['data'] != null ? DataProfile.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['message'] = message;
    data['errors'] = errors;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataProfile {
  int? id;
  int? positionId;
  String? positionName;
  String? name;
  String? email;
  String? phone;
  String? personalEmail;
  int? genderId;
  String? gender;
  String? dob;
  String? avatar;
  String? address;
  String? about;
  String? citizenId;
  String? lastOnlineAt;
  String? joinCompanyAt;
  String? upOfficialAt;
  String? lastCompany;
  int? totalPosts;
  int? totalViewed;
  int? totalLikes;
  int? totalAmais;
  int? totalPoints;
  int? amaiVotes;
  String? createdAt;
  Socials? socials;
  Education? education;
  Bank? bank;
  Incognito? incognito;
  int? workStatus;
  String? workStatusName;
  String? department;
  bool? haveLunchMenu;

  DataProfile(
      {this.id,
      this.positionId,
      this.positionName,
      this.name,
      this.email,
      this.phone,
      this.personalEmail,
      this.genderId,
      this.gender,
      this.dob,
      this.avatar,
      this.address,
      this.about,
      this.citizenId,
      this.lastOnlineAt,
      this.joinCompanyAt,
      this.upOfficialAt,
      this.lastCompany,
      this.totalPosts,
      this.totalViewed,
      this.totalLikes,
      this.totalAmais,
      this.totalPoints,
      this.amaiVotes,
      this.createdAt,
      this.socials,
      this.education,
      this.bank,
      this.incognito,
      this.workStatus,
      this.workStatusName,
      this.department,
      this.haveLunchMenu});

  DataProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    positionId = json['position_id'];
    positionName = json['position_name'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    personalEmail = json['personal_email'];
    genderId = json['gender_id'];
    gender = json['gender'];
    dob = json['dob'];
    avatar = json['avatar'];
    address = json['address'];
    about = json['about'];
    citizenId = json['citizen_id'];
    lastOnlineAt = json['last_online_at'];
    joinCompanyAt = json['join_company_at'];
    upOfficialAt = json['up_official_at'];
    lastCompany = json['last_company'];
    totalPosts = json['total_posts'];
    totalViewed = json['total_viewed'];
    totalLikes = json['total_likes'];
    totalAmais = json['total_amais'];
    totalPoints = json['total_points'];
    amaiVotes = json['amai_votes'];
    createdAt = json['created_at'];
    socials = json['socials'] != null ? Socials.fromJson(json['socials']) : null;
    education = json['education'] != null ? Education.fromJson(json['education']) : null;
    bank = json['bank'] != null ? Bank.fromJson(json['bank']) : null;
    incognito = json['incognito'] != null ? Incognito.fromJson(json['incognito']) : null;
    workStatus = json['work_status'];
    workStatusName = json['work_status_name'];
    department = json['department'];
    haveLunchMenu = json['have_lunch_menu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['position_id'] = positionId;
    data['position_name'] = positionName;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['personal_email'] = personalEmail;
    data['gender_id'] = genderId;
    data['gender'] = gender;
    data['dob'] = dob;
    data['avatar'] = avatar;
    data['address'] = address;
    data['about'] = about;
    data['citizen_id'] = citizenId;
    data['last_online_at'] = lastOnlineAt;
    data['join_company_at'] = joinCompanyAt;
    data['up_official_at'] = upOfficialAt;
    data['last_company'] = lastCompany;
    data['total_posts'] = totalPosts;
    data['total_viewed'] = totalViewed;
    data['total_likes'] = totalLikes;
    data['total_amais'] = totalAmais;
    data['total_points'] = totalPoints;
    data['amai_votes'] = amaiVotes;
    data['created_at'] = createdAt;
    if (socials != null) {
      data['socials'] = socials!.toJson();
    }
    if (education != null) {
      data['education'] = education!.toJson();
    }
    if (bank != null) {
      data['bank'] = bank!.toJson();
    }
    if (incognito != null) {
      data['incognito'] = incognito!.toJson();
    }
    data['work_status'] = workStatus;
    data['work_status_name'] = workStatusName;
    data['department'] = department;
    data['have_lunch_menu'] = haveLunchMenu;
    return data;
  }
}

class Socials {
  String? facebookUrl;
  String? facebookUsername;
  String? telegramUrl;
  String? telegramUsername;

  Socials({this.facebookUrl, this.facebookUsername, this.telegramUrl, this.telegramUsername});

  Socials.fromJson(Map<String, dynamic> json) {
    facebookUrl = json['facebook_url'];
    facebookUsername = json['facebook_username'];
    telegramUrl = json['telegram_url'];
    telegramUsername = json['telegram_username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['facebook_url'] = facebookUrl;
    data['facebook_username'] = facebookUsername;
    data['telegram_url'] = telegramUrl;
    data['telegram_username'] = telegramUsername;
    return data;
  }
}

class Education {
  int? graded;
  String? gradedName;
  String? gpa;
  String? gpaFormat;
  String? universityCode;
  String? universityName;

  Education({this.graded, this.gradedName, this.gpa, this.gpaFormat, this.universityCode, this.universityName});

  Education.fromJson(Map<String, dynamic> json) {
    graded = json['graded'];
    gradedName = json['graded_name'];
    gpa = json['gpa'];
    gpaFormat = json['gpa_format'];
    universityCode = json['university_code'];
    universityName = json['university_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['graded'] = graded;
    data['graded_name'] = gradedName;
    data['gpa'] = gpa;
    data['gpa_format'] = gpaFormat;
    data['university_code'] = universityCode;
    data['university_name'] = universityName;
    return data;
  }
}

class Bank {
  String? accountNumber;
  String? bank;
  String? bankAgency;
  String? name;
  String? shortName;

  Bank({this.accountNumber, this.bank, this.bankAgency, this.name, this.shortName});

  Bank.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    bank = json['bank'];
    bankAgency = json['bank_agency'];
    name = json['name'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_number'] = accountNumber;
    data['bank'] = bank;
    data['bank_agency'] = bankAgency;
    data['name'] = name;
    data['short_name'] = shortName;
    return data;
  }
}

class Incognito {
  int? id;
  String? name;
  String? avatar;
  String? about;

  Incognito({this.id, this.name, this.avatar, this.about});

  Incognito.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['avatar'] = avatar;
    data['about'] = about;
    return data;
  }
}

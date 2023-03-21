import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../model/profile_data.dart';

import 'bank_data_mapper.dart';
import 'base/base_data_mapper.dart';
import 'educate_data_mapper.dart';

import 'incognito_data_mapeper.dart';
import 'socials_data_mapper.dart';

@Injectable()
class UserDataMapper extends BaseDataMapper<ProfileData, Profile> {
  UserDataMapper(this._socialsDataMapper, this._bankDataMapper, this._educateDataMapper, this._incognitoDataMapper);

  final SocialsDataMapper _socialsDataMapper;
  final BankDataMapper _bankDataMapper;
  final EducateDataMapper _educateDataMapper;
  final IncognitoDataMapper _incognitoDataMapper;
  @override
  Profile mapToEntity(ProfileData? data) {
    return Profile(
      id: data?.id ?? -1,
      email: data?.email ?? '',
      positionId: data?.positionId ?? -1,
      positionName: data?.positionName,
      name: data?.name,
      phone: data?.phone,
      personalEmail: data?.personalEmail,
      genderId: data?.genderId,
      gender: data?.gender,
      dob: data?.dob,
      avatar: data?.avatar,
      address: data?.address,
      about: data?.about,
      citizenId: data?.citizenId,
      lastOnlineAt: data?.lastOnlineAt,
      joinCompanyAt: data?.joinCompanyAt,
      upOfficialAt: data?.upOfficialAt,
      lastCompany: data?.lastCompany,
      totalPosts: data?.totalPosts,
      totalViewed: data?.totalViewed,
      totalLikes: data?.totalLikes,
      totalAmais: data?.totalAmais,
      totalPoints: data?.totalPoints,
      amaiVotes: data?.amaiVotes,
      createdAt: data?.createdAt,
      socials: _socialsDataMapper.mapToEntity(data?.socials),
      bank: _bankDataMapper.mapToEntity(data?.bank),
      incognito: _incognitoDataMapper.mapToEntity(data?.incognito),
      education: _educateDataMapper.mapToEntity(data?.education),
      workStatus: data?.workStatus,
      workStatusName: data?.workStatusName,
      department: data?.department,
      haveLunchMenu: data?.haveLunchMenu,
      haveInternalAnnouncement: data?.haveInternalAnnouncement,
      currentLunchTotalPayment: data?.currentLunchTotalPayment,
    );
  }
}

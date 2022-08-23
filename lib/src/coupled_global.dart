import 'dart:convert';

import 'package:coupled/Chat/ChatBloc/chat_bloc.dart';
import 'package:coupled/Chat/Model/ChatModel.dart';
import 'package:coupled/Chat/Model/EventModel.dart';
import 'package:coupled/Chat/Model/message_model.dart';
import 'package:coupled/Chat/Model/online_users.dart';
import 'package:coupled/Chat/Model/sticker_model.dart';
import 'package:coupled/Home/Profile/CouplingScore/bloc/coupling_score_bloc.dart';
import 'package:coupled/Home/Profile/othersProfile/bloc/others_profile_bloc.dart';
import 'package:coupled/MatchMeter/bloc/mom_bloc.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/cms_model.dart';
import 'package:coupled/models/coupling_score.dart';
import 'package:coupled/models/match_o_meter_model.dart';
import 'package:coupled/models/photo_model.dart';

import 'package:coupled/models/profile.dart';
import 'package:coupled/models/tol_checkout_model.dart';
import 'package:coupled/models/tol_list_model.dart';
import 'package:coupled/models/tol_order_history.dart';
import 'package:laravel_echo2/laravel_echo2.dart';

class GlobalData {
  ///Base Settings
  static List<BaseSettings> baseSettings = [];

  ///USER
  static ProfileResponse myProfile = ProfileResponse(
      usersBasicDetails: UsersBasicDetails(),
      mom: Mom(),
      info: Info(maritalStatus: BaseSettings(options: [])),
      preference: Preference(complexion: BaseSettings(options: [])),
      officialDocuments: OfficialDocuments(),
      address: Address(),
      photoData: [],
      photos: [],
      family: Family(
          fatherOccupationStatus: BaseSettings(options: []),
          cast: BaseSettings(options: []),
          familyType: BaseSettings(options: []),
          familyValues: BaseSettings(options: []),
          gothram: BaseSettings(options: []),
          motherOccupationStatus: BaseSettings(options: []),
          religion: BaseSettings(options: []),
          subcast: BaseSettings(options: [])),
      educationJob: EducationJob(
          educationBranch: BaseSettings(options: []),
          experience: BaseSettings(options: []),
          highestEducation: BaseSettings(options: []),
          incomeRange: BaseSettings(options: []),
          industry: BaseSettings(options: []),
          profession: BaseSettings(options: [])),
      membership: Membership.fromMap({}),
      userCoupling: [],
      dp: Dp(
          photoName: '',
          imageType: BaseSettings(options: []),
          imageTaken: BaseSettings(options: []),
          userDetail: UserDetail(membership: Membership(paidMember: false))),
      blockMe: Mom(),
      reportMe: Mom(),
      freeCoupling: [],
      recomendCause: [],
      shortlistByMe: Mom(),
      shortlistMe: Mom(),
      photoModel: PhotoModel(),
      currentCsStatistics: CurrentCsStatistics(),
      siblings: []);
  static ProfileResponse othersProfile = ProfileResponse(
      usersBasicDetails: UsersBasicDetails(),
      mom: Mom(),
      info: Info(maritalStatus: BaseSettings(options: [])),
      preference: Preference(complexion: BaseSettings(options: [])),
      officialDocuments: OfficialDocuments(),
      address: Address(),
      photoData: [],
      photos: [],
      family: Family(
          fatherOccupationStatus: BaseSettings(options: []),
          cast: BaseSettings(options: []),
          familyType: BaseSettings(options: []),
          familyValues: BaseSettings(options: []),
          gothram: BaseSettings(options: []),
          motherOccupationStatus: BaseSettings(options: []),
          religion: BaseSettings(options: []),
          subcast: BaseSettings(options: [])),
      educationJob: EducationJob(
          educationBranch: BaseSettings(options: []),
          experience: BaseSettings(options: []),
          highestEducation: BaseSettings(options: []),
          incomeRange: BaseSettings(options: []),
          industry: BaseSettings(options: []),
          profession: BaseSettings(options: [])),
      membership: Membership.fromMap({}),
      userCoupling: [],
      dp: Dp(
          photoName: '',
          imageType: BaseSettings(options: []),
          imageTaken: BaseSettings(options: []),
          userDetail: UserDetail(membership: Membership(paidMember: false))),
      blockMe: Mom(),
      reportMe: Mom(),
      freeCoupling: [],
      recomendCause: [],
      shortlistByMe: Mom(),
      shortlistMe: Mom(),
      photoModel: PhotoModel(),
      currentCsStatistics: CurrentCsStatistics(),
      siblings: []);

  ///Coupling Question
  static Map<String, dynamic> couplingQuestion = {};

  ///Cms data
  static CmsModel cmsModel = CmsModel(response: []);

  ///fcm token
  static String fcmToken = '';

  ///mom bloc
  static OthersProfileBloc othersProfileBloc = OthersProfileBloc();

  ///mom bloc
  static MomBloc momBloc = MomBloc();

  ///specially abled
  static MatchOMeterModel speciallyAbled = MatchOMeterModel();
  static MatchOMeterModel matchmeter = MatchOMeterModel();

  ///coupling score
  static CouplingScoreModel couplingScoreModel = CouplingScoreModel(
      response: CouplingScoreModelResponse(
          mom: Mom(), physical: [], psychological: []));

  ///coupling score bloc
  static CouplingScoreBloc couplingScoreBloc = CouplingScoreBloc();
  getBaseSettingsType({required String baseType}) {
    BaseSettings value = baseSettings.singleWhere((f) {
      return f.value == baseType;
    });
    return value;
  }

  ///
  static List<Map> couplingAnswers = [];

  ///TOL
  static TolProductDatum selectedItem = TolProductDatum();
  static String tolTrackOrderNumber = '';
  static OnlineChatList onlineUsersList = OnlineChatList();
  static List onlineUsersMemCode = [];

  static int tolSelectedIndex = 0;
  static TolProductModel tolProducts = TolProductModel();
  static TolCheckOutItemModel tolCheckout = TolCheckOutItemModel();
  static TolOrderHistoryModel tolOrderHistory = TolOrderHistoryModel();
  static TrackOrderModel trackOrderModel = TrackOrderModel();
  static BaseSettings selectedCategory = BaseSettings(options: []);
  static BaseSettings selectedSort = BaseSettings(options: []);

  ///chat
  static MessageModel messageModel = MessageModel();
  static StickerModel stickerModel = StickerModel();
  static MessageModel sentMessage =
      MessageModel(response: ChatModelResponse.fromMap({}));
  static EventModel eventModel = EventModel();
  static ChatBloc chatBloc = ChatBloc();
  static ChatResponse? chatResponse = ChatResponse(
      mom: MomM(momHistory: []),
      partner: PartnerDetails(
          dp: Dp(
              photoName: '',
              imageType: BaseSettings(options: []),
              imageTaken: BaseSettings(options: []),
              userDetail:
                  UserDetail(membership: Membership(paidMember: false))),
          info: Info(maritalStatus: BaseSettings(options: [])),
          photos: []));
  static Echo echo = Echo({});
  static int recievemsg = 1;
  static List messages = [];
}

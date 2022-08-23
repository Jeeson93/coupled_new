import 'package:coupled/Chat/Model/message_model.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/common_response_model.dart';
import 'package:coupled/models/coupling_score.dart';
import 'package:coupled/models/match_o_meter_model.dart';
import 'package:coupled/models/notification_model.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/models/tol_checkout_model.dart';
import 'package:coupled/models/tol_list_model.dart';
import 'package:coupled/models/tol_order_history.dart';
import 'package:coupled/models/transaction_model.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:coupled/resources/base_setting_api_provider.dart';
import 'package:coupled/resources/chatliat_api_provider.dart';
import 'package:coupled/resources/coupling_score_api_provider.dart';
import 'package:coupled/resources/match_board_api_provider.dart';
import 'package:coupled/resources/match_maker_api_provider.dart';
import 'package:coupled/resources/match_o_meter_api_provider.dart';
import 'package:coupled/resources/notification_api_provider.dart';
import 'package:coupled/resources/plans_payment_api_provider.dart';
import 'package:coupled/resources/profile_api_provider.dart';
import 'package:coupled/resources/settings_and_cms_provider.dart';
import 'package:coupled/resources/share_profile_api.dart';
import 'package:coupled/resources/similar_profile_api_provider.dart';
import 'package:coupled/resources/tol_api_provider.dart';

class Repository {
  final baseSettingsApiProvider = BaseSettingsApiProvider();
  final similarProfileApiProvider = SimilarProfileApiProvider();
  final shareProfileApiProvider = ShareProfileApi();
  final profileApiProvider = ProfileApiProvider();
  final matchBoardApiProvider = MatchBoardApiProvider();
  final settingsAndCmsProvider = SettingsAndCmsProvider();
  final matchOMeterApiProvider = MatchOMeterApiProvider();
  final couplingScoreApiProvider = CouplingScoreApiProvider();
  final notificationApiProvider = NotificationApiProvider();
  final plansPaymentsApiProvider = PlansPaymentApiProvider();
  final getchatlist = ChatListApiProvider();
  final tolApiProvider = TolApiProvider();
  final matchMakerApiProvider = MatchMakerApiProvider();

  ///base settings
  Future<List<BaseSettings>> fetchBaseSettings() =>
      baseSettingsApiProvider.getBaseSettings();

  ///Share profile
  Future<CommonResponseModel> shareProfile(membershipCode) =>
      shareProfileApiProvider.shareProfile(membershipCode);

  ///User profile
  Future<ProfileResponse> fetchProfile(String otherUserId) =>
      profileApiProvider.getUserProfile(otherUserId);

  ///MatchBoard
  Future<UserShortInfoModel> getMatchBoardList(
          {required Map<String, String> params,
          path,
          int page = 1,
          int perPageCount = 100}) =>
      matchBoardApiProvider.matchBoardList(params, path);

  ///Similar Profile
  Future<UserShortInfoModel> similarProfile(membershipCode) =>
      similarProfileApiProvider.similarProfile(membershipCode);

  ///settings and CMS
  Future<CommonResponseModel> doAction(Map<String, dynamic> params, path) =>
      settingsAndCmsProvider.doAction(params, path);

  ///MOM
  Future<MatchOMeterModel> getMatchOMeterList(
          {Map<String, String>? params,
          path,
          int? page,
          int? perPageCount = 10}) =>
      matchOMeterApiProvider.matchOMeterList(params, path, page, perPageCount);

  ///Coupling Score
  Future<CouplingScoreModel> fetchCouplingScore(String otherUserId) =>
      couplingScoreApiProvider.getCouplingScore(otherUserId);

  ///MOM specially abled
  Future<Map<String, dynamic>> speciallyAbledAction(
          {required Map<String, String> params}) =>
      matchOMeterApiProvider.speciallyAbledAction(params);

  ///contact show
  Future<CommonResponseModel> getContactNo(String otherUserId) =>
      couplingScoreApiProvider.getContactNo(otherUserId);

  ///Get Search ID
  Future<UserShortInfoModel> getSearchByID(
          {required Map<String, dynamic> params}) =>
      matchBoardApiProvider.getSearchByID(params);

  ///Notifications
  Future<NotificationModel1> getNotifications(
          {path, required int page, required int perPageCount}) =>
      notificationApiProvider.notifications(path, page, perPageCount);

  ///get notification toggle
  Future<CommonResponseModel> getNotification({required int status}) =>
      notificationApiProvider.getNotification(status);

  ///plans and payment
  Future<MembershipPlansModel> fetchMembershipPlans() =>
      plansPaymentsApiProvider.getMembershipPlans();

  ///fetchPlansandPayment
  Future<MyPlansAndPaymentModel> fetchMyPlansAndPayment() =>
      plansPaymentsApiProvider.getMyPlansAndPayment();

  ///transaction history
  Future<TransactionModel> getTransactionHistory() =>
      plansPaymentsApiProvider.getTransactionHistory();
  //getChatlist
  Future<MessageModel> getchatlistpro({required String memberShipCode}) =>
      getchatlist.getchatList(memberShipCode);

  ///Tol
  Future<TolProductModel> getTolList() => tolApiProvider.getTolList();

  Future<TolCheckOutItemModel> tolCheckout() => tolApiProvider.tolCheckout();

  Future<TolOrderHistoryModel> tolGetHistory() =>
      tolApiProvider.tolGetHistory();

  Future<TrackOrderModel> tolTrackOrder() => tolApiProvider.tolTrackOrder();

  ///Get Advanced Search
  Future<UserShortInfoModel> getAdvanceSearch(String params) =>
      matchMakerApiProvider.getAdvanceSearch(params);
}

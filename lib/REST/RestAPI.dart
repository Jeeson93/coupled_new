import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/Utils/coupled_strings.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';

typedef CustomResponse = Function(Map<String, dynamic> response, String error);

class RestAPI {
  static String clientId = "2";

//  static String clientSecret = "9Uei7JezQFj15Vs5TyMfWflnOBKtfY6C17O1pnDY";
//
  static String clientSecret = "1IWvjOOvaoC7DIsQuep9opQ2dRlPeThAukV6vNCN";

  Future checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup(APis.superLink);

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<T> get<T>(String url, [String t = '']) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    print('Api Get, url $url');
    T responseJson;
    try {
      Response response = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });

      print("RESPONSE $t :: ${response.body}");
      responseJson = _returnResponse(response);
      print('provider_response====${responseJson}');
    } on RestException catch (e) {
      print('e....${e.toString()}');
      throw e;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');

    return responseJson;
  }

  Future<T> post<T>(String url, {params}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    print('Api Post, url $url  and ${json.encode(params)}');
    T responseJson;
    try {
      final response =
          await http.post(Uri.parse(url), body: json.encode(params), headers: {
        "Accept": "application/json",
        'Content-type': 'application/json',
        "Authorization": "Bearer $token"
      });
      print("POST RESPONSE : ${response.statusCode} ${response.body}");
      responseJson = _returnResponse(response);
      print("ho");
      if (response.body.contains("Account deactivate. Contact coupled care")) {
        String message = "Account deactivate. Contact coupled care";
        GlobalWidgets().showToast(
            msg: 'Account deactivated. Contact coupled for more info');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("accountdeactivate", message);
      } else {
        prefs.remove("accountdeactivate");
      }

//      throw Exception('Testing');
//      print("RESPONSEJSON : $responseJson");
    } on RestException catch (e) {
      print('Rest Exception');
      throw e;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    print('Api Put, url $url');
    var responseJson;
    try {
      final response = await http.put(Uri.parse(url), body: body, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
//    print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    print('Api delete, url $url');
    var apiResponse;
    try {
      final response = await http.delete(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }

  Future<T> multiPart<T>(String url,
      {required Map<String, dynamic> params}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken').toString();
    print('Api multipart, url $url $params');
    T responseJson;
    if (token != null) {
      try {
        print("MultipartFile call--------------");
        var uri = Uri.parse(url);
        print(uri);
        Map<String, String> headers = {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          "Content-Type": "multipart/form-data"
        };

        http.MultipartRequest request = http.MultipartRequest("POST", uri);

        request.headers.addAll(headers);
        print(params["fields"]);
        Map<String, dynamic>.from(params["fields"]);
        request.fields.addAll(Map<String, String>.from(params["fields"]));

        if (params['file'] != null || params['file'] != 'hi') {
          Map<String, dynamic> _file = params['file'];

          http.MultipartFile multipartFile;
          _file.entries.forEach((element) async {
            if (element.value != null && element.value != 1) {
              var stream =
                  http.ByteStream(Stream.castFrom(element.value.openRead()));

              var length = await (element.value as File).length();
              multipartFile = http.MultipartFile(element.key, stream, length,
                  filename: basename(element.value.path));
              print("VALUE : $length ${element.key}, ${element.value}");
              request.files.add(multipartFile);
            }
          });
          /*   for (var entry in _file.entries) {
            var stream = new http.ByteStream(Stream.castFrom(entry.value?.openRead()));
            var length = await (entry.value as File)?.length();
            multipartFile =
                new http.MultipartFile(entry.key, stream, length, filename: basename(entry.value?.path));
            print("VALUE : $length ${entry.key}, ${entry.value}");
            request.files.add(multipartFile);
          }*/
        }
        var streamResponse = await request.send();
        //Response response = jsonDecode(await streamResponse.stream.transform(utf8.decoder).join());

        var onData = await streamResponse.stream.transform(utf8.decoder).first;
        print("dynamicCallApi RESPONSE : $onData");
        responseJson = _returnResponse<Map>(json.decode(onData.toString()));
        return responseJson;
      } on SocketException {
        print('No Internet');
        throw FetchDataException('No Internet connection');
      }
    } else {
      throw Exception('Your Token has Expired!.Please signin again.');
    }
  }

  void shareProfile(String memberShipCode, {dynamic streamController}) {
    Repository().shareProfile(memberShipCode).then((onValue) {
      streamController != null ?? streamController.add(onValue.code.toString());
      Share.share((onValue.response?.msg).toString());
    });
  }
}

dynamic _returnResponse<T>(T response) {
  print('respose-------------- $T');
  if (response is http.Response) {
    //  print(response.body);
    print('statusCode------------- ${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        print("responseJson : $responseJson");

        return responseJson;
      case 404:
        //throw  FetchDataErrorException(json.decode(response.body));
        //throw BadRequestException(json.decode(response.body));

        throw json.decode(response.body);

      case 400:
        throw BadRequestException(json.decode(response.body));
      case 401:

      case 403:
        throw UnauthorisedException(json.decode(response.body));
      case 500:
        /* default:
        GlobalWidgets().showToast(msg: CoupledStrings.serverDown);*/
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  } else if (response is Map<String, dynamic>) {
    print("MAP :::");
    print(response);
    switch (response["code"]) {
      case 200:
        var responseJson = response["response"];
        print("responseJson : $responseJson");
        return responseJson;
      case 404:
        var response404 = json.decode(response["response"]);
        return response404;
      case 400:
        throw BadRequestException(response["response"]);
      case 401:
      case 403:
        throw UnauthorisedException(response["response"]);
      case 500:
      default:
        GlobalWidgets().showToast(msg: CoupledStrings.serverDown);
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response["code"]}');
    }
  } else if (response is String) {
    print(json.decode(response)['code']);
    switch (json.decode(response)['code']) {
      case 404:
        var response404 = json.decode(response)["response"]['msg'];
        throw BadRequestException(response404);
    }
  }
}

Future<List<Map>> getBaseSetting(bool isType, String params) async {
  // String token= await Preferences().getString('tokenId');

  Map<String, String> param;
  if (isType) {
    param = {'type': params};
  } else {
    param = {'id': params};
  }
  print("postData params : $params ");
  List<Map> baseSettingItem = [];
  try {
    final response = await RestAPI().post(
        Uri.encodeFull(
            isType ? APis.getBaseSettingsByType : APis.getBaseSettingsById),
        params: param);

//    print(response.body);
    Map body = json.decode(response.body);
    if (body['status'] == "success") {
      if (!isType) {
        Map data = body['data'];
        List sub = data['sub'];
        sub.forEach((singleItem) {
          baseSettingItem.add(BaseSettingRestApi().getBaseSetting(
              singleItem['base_settings_id'].toString(), singleItem['value']));
        });
      } else {
        List data = body['data'];
        data.forEach((item) {
          baseSettingItem.add(BaseSettingRestApi().getBaseSetting(
              item['base_settings_id'].toString(), item['value']));
        });
      }
    }
//      GlobalWidgets().printMsg(baseSettingItem);
  } on TimeoutException catch (error) {
    print('TimeoutException : $error');
  } on SocketException catch (error) {
    print('SocketException : $error');
  } on HttpException catch (error) {
    print('HttpException : $error');
  }

//  CustomWidgets().printMsg(data);

  return baseSettingItem;
}

Future getData(String url, {String authorization = ''}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  var data;
  try {
    http.Response response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });
//      GlobalWidgets().printMsg(json.decode(response.body));
    data = json.decode(response.body); /*JSON.decode(response.body);*/
  } on TimeoutException catch (error) {
    print('TimeoutException : $error');
  } on SocketException catch (error) {
    print('SocketException : $error');
  } on HttpException catch (error) {
    print('HttpException : $error');
  }
  return data;
}

class BaseSettingRestApi {
  String baseSettingsId, value;

  BaseSettingRestApi({this.baseSettingsId = '', this.value = ''});

  Map getBaseSetting(String baseSettingsId, String value) {
    return {"id": baseSettingsId, "name": value};
  }

  @override
  String toString() {
    return '{baseSettingsId: $baseSettingsId, value: $value}';
  }
}

///[MEDIA] get full size image without crop
///[THUMB] get cropped size image
enum ImageConversion { MEDIA, THUMB }

enum ImageFolder { PROFILE, DOCUMENT, TOL }

///sent
///receive
///accept_me
///accept_partner
///shortlist_me
///shortlist_partner
///reject_me
///reject_partner
///view_me
///view_partner
///block
///report
enum ActionType {
  SENT,
  RECEIVE,
  ACCEPT_ME,
  ACCEPT_PARTNER,
  SHORTLIST_ME,
  SHORTLIST_PARTNER,
  REJECT_ME,
  REJECT_PARTNER,
  VIEW_ME,
  VIEW_PARTNER,
  BLOCK,
  REPORT
}

class APis {
//  static const superLink = 'http://192.168.0.25:8000';

  //static const superLink = 'http://192.168.0.12:8000';

  static String razorPayKey = 'rzp_test_4kRxJ0mYYkj9Yx';

  // static String superLink = 'https://admin.kermadec.in';
  static String superLink = 'https://admin.coupled.in';

  //static String superLink = 'https://photorooster.com/coupled/public';
  static String socketIO = 'https://admin.coupled.in/:6001';

  static String facebookLogin = "$superLink/api/socialsignin";
  static String existingUser = "$superLink/api/existinguser";
  static String signUpOtp = "$superLink/api/signupappotp";
  static String signIn = "$superLink/api/signin";
  static String signInSocial = "$superLink/oauth/token";
  static String signUp = "$superLink/api/signupapp";
  static String baseSettings = "$superLink/api/basesettings";
  static String forgotOtp = "$superLink/api/forgotpasswordotp";
  static String forgotPassword = "$superLink/api/forgotpassword";
  static String register = "$superLink/api/";
  static String getPlace = "$superLink/api/countrystatecity";
  static String getCouplingQuestions = "$superLink/api/couplingquestions";
  static String getProfile = "$superLink/api/user";
  static String getCouplingScore = "$superLink/api/score/show";
  static String contactShow = "$superLink/api/contact/show";
  static String photoSection = "$superLink/api/appstepten";
  static String getBaseSettingsById = "$superLink/api/get-base-settings-by-id";
  static String getBaseSettingsByType = "$superLink/api/get-base-settings";
  static String getNotification = "$superLink/api/notifications";

  /// signout api
  static String signOut = "$superLink/api/signout";

  static String coupledLogo = '$superLink/admin-theme/images/favicon.png';

  ///plans and payments
  static String myPlansAndPayment = "$superLink/api/mypayments";
  static String myTransactionHistory = "$superLink/api/transaction";
  static String membershipPlans = "$superLink/api/payments";
  static String purchasePlans = "$superLink/api/purchase";

  ///settings and CMS
  static String settingsChangePw = "$superLink/api/change/password";
  static String settingsLogoutFromOther = "$superLink/api/logoutotherdevice";
  static String settingsVerifyPhone = "$superLink/api/change/mobile/verify";
  static String settingsConformPhone = "$superLink/api/change/mobile/confirm";
  static String settingsVerifyEmail = "$superLink/api/change/email/verify";
  static String settingsConformEmail = "$superLink/api/change/email/confirm";
  static String settingsDeleteAccount = "$superLink/api/delete/account";
  static String settingsHideAccount = "$superLink/api/hide/account";
  static String settingsActivateAccount = "$superLink/api/activate/account";
  static String cmsEnquiry = "$superLink/api/enquiry";

  ///CMS
  static String cmsAboutUs = "$superLink/about-us";
  static String cmsPrivacyPolicy = "https://coupled.in/privacy-policy";

  static String cmsRefundPolicy = "https://coupled.in/refund-policy/";
  static String cmsSuccessStories = "https://coupled.in/success-stories/";

  // static String cmsTerms = "$superLink/terms-of-use";
  static String cmsTerms = "https://coupled.in/terms-of-use";
  static String cmsContact = "$superLink/contact-us";
  static String cms = "$superLink/api/cms";

  ///MoM
  static String momListMain = "$superLink/api/matchometer";
  static String momSpecially = "$superLink/api/specially";
  static String momActions = "$superLink/api/";
  static String momClear = "$superLink/api/mom/clear";

  ///ShareProfile
  static String shareProfile = "$superLink/api/share/link";

  ///SimilarProfile
  static String similarProfile = "$superLink/api/similar/";

  ///MatchBoard
  static String matchBoard = "$superLink/api/matchboard?match_type=";

  ///MatchMaker
  static String postMatchMaker = "$superLink/api/matchmaker";
  static String getMatchMakerByType = "$superLink/api/matchmaker";

  ///AdvanceSearch
  static String getAdvanceSearch = "$superLink/api/advancesearch";
  static String getSearchById = "$superLink/api/search";

  ///NotificationByType
  static String notificationByType = "$superLink/api/notification";

  ///Chat
  static String chatUrl = "$superLink/api/chat";
  static String stickers = "$superLink/api/sticker";
  static String chatUrlLove = "$superLink/api/love";

  static String chatHistory = "$superLink/api/chathistory";
  static String stickerImagePath = "$superLink/media/sticker/";

  //static String

  ///tOL
  static String tolProduct = "$superLink/api/product";
  static String tolRequest = "$superLink/api/tokenofloverequest";
  static String tolAccept = "$superLink/api/tokenoflove";

  static String tolOrder = "$superLink/api/order";
  static String tolOrderUpdate = "$superLink/api/orders/update";

  ///user_online-status
  static String userOnlineStatus = '$superLink/api/status';

  ///[imageSize] will only need when [imageConversion] is thumb
  String imageApi(String? imageName,
      {int imageSize = 0,
      ImageConversion imageConversion = ImageConversion.MEDIA,
      ImageFolder imageFolder = ImageFolder.PROFILE}) {
    if (imageSize > 0 && imageConversion == ImageConversion.MEDIA)
      throw "Change $imageConversion to ImageConversion.THUMB when setting the size of image.";
    var conversion =
        imageConversion == ImageConversion.MEDIA ? "media" : "thumb";
    var folder = imageFolder == ImageFolder.PROFILE
        ? "profiles"
        : imageFolder == ImageFolder.TOL
            ? 'products'
            : "documents";
    return "$superLink/$conversion/$folder/$imageName/${imageSize > 0 ? imageSize : ''}";
  }
}

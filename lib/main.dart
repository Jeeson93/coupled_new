import 'dart:io';
import 'package:coupled/Chat/ChatBloc/chat_bloc.dart';
import 'package:coupled/Chat/Model/ChatModel.dart';
import 'package:coupled/Chat/chat_list_0.dart';
import 'package:coupled/Chat/chat_main_view_1.dart';
import 'package:coupled/Chat/chat_view_2.dart';
import 'package:coupled/Home/DashBoard/dashboard.dart';
import 'package:coupled/Home/MatchBoard/MatchBoardView.dart';
import 'package:coupled/Home/MatchBoard/bloc/match_board_bloc.dart';
import 'package:coupled/Home/Profile/CouplingScore/bloc/coupling_score_bloc.dart';
import 'package:coupled/Home/Profile/MyProfile/Profile.dart';
import 'package:coupled/Home/Profile/Recommendation/Recommendations.dart';
import 'package:coupled/Home/Profile/othersProfile/bloc/others_profile_bloc.dart';
import 'package:coupled/Home/Profile/profile_switch.dart';
import 'package:coupled/Home/main_board.dart';
import 'package:coupled/MatchMaker/helpers/advanced_search.dart';
import 'package:coupled/MatchMaker/match_maker_page.dart';
import 'package:coupled/MatchMeter/bloc/mom_bloc.dart';
import 'package:coupled/MatchMeter/view/specially_abled.dart';
import 'package:coupled/Notifications/Notifications.dart';
import 'package:coupled/PlansAndPayment/MembershipPlans/bloc/membership_plan_bloc.dart';
import 'package:coupled/PlansAndPayment/MembershipPlans/view/MembershipPlans.dart';
import 'package:coupled/PlansAndPayment/MyPlansandPayments/bloc/my_plans_and_payment_bloc.dart';
import 'package:coupled/PlansAndPayment/MyPlansandPayments/view/MyPlansAndPayment.dart';
import 'package:coupled/StartScreen/forgot_password.dart';
import 'package:coupled/StartScreen/sign_up_form.dart';
import 'package:coupled/StartScreen/start_main.dart';
import 'package:coupled/StartScreen/welcome_screen.dart';
import 'package:coupled/TOL/Bloc/tol_list_bloc_bloc.dart';
import 'package:coupled/TOL/tol_home_1.dart';
import 'package:coupled/TOL/tol_item_2.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/match_o_meter_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/models/questions.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:coupled/registration_new/controller/registration_redirection.dart';
import 'package:coupled/registration_new/reg_steps/Family/FamilyInfoA.dart';
import 'package:coupled/registration_new/reg_steps/Family/FamilyInfoB.dart';
import 'package:coupled/registration_new/reg_steps/MOEVerification.dart';
import 'package:coupled/registration_new/reg_steps/PersonalDetailSections/Section1.dart';
import 'package:coupled/registration_new/reg_steps/PersonalDetailSections/Section2.dart';
import 'package:coupled/registration_new/reg_steps/PersonalDetailSections/Section3.dart';
import 'package:coupled/registration_new/reg_steps/PersonalDetailSections/Section4.dart';
import 'package:coupled/registration_new/reg_steps/PersonalDetailSections/Section5.dart';
import 'package:coupled/registration_new/reg_steps/PersonalDetailSections/Section6.dart';
import 'package:coupled/registration_new/reg_steps/PersonalDetailSections/Section7.dart';
import 'package:coupled/registration_new/reg_steps/PersonalDetailSections/Section8.dart';
import 'package:coupled/registration_new/reg_steps/PhotoGraphs/AboutPicture.dart';
import 'package:coupled/registration_new/reg_steps/PhotoGraphs/PhotoA.dart';
import 'package:coupled/registration_new/reg_steps/Pro_Edu/Pro_EduA.dart';
import 'package:coupled/registration_new/reg_steps/Pro_Edu/Pro_EduB.dart';
import 'package:coupled/registration_new/reg_steps/Religion/ReligionA.dart';
import 'package:coupled/registration_new/reg_steps/SecondWelcomeScreen.dart';
import 'package:coupled/registration_new/reg_steps/TOL.dart';
import 'package:coupled/registration_new/reg_steps/coupling_questions/CouplingQuestion.dart';
import 'package:coupled/registration_new/reg_steps/coupling_questions/coupling_question.dart';
import 'package:coupled/resources/stream/profiledatastream.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:coupled/StartScreen/IntroSlider.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:ntp/ntp.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  DateTime _myTime;
  DateTime _ntpTime;

  /// Or you could get NTP current (It will call DateTime.now() and add NTP offset to it)
  _myTime = await NTP.now();

  /// Or get NTP offset (in milliseconds) and add it yourself
  final int offset = await NTP.getNtpOffset(localTime: DateTime.now());
  _ntpTime = _myTime.add(Duration(milliseconds: offset));
  print('My time: $_myTime');
  print('NTP time: $_ntpTime');
  print('Difference: ${_myTime.difference(_ntpTime).inMinutes}ms');
  if (_myTime.difference(_ntpTime).inMinutes > 6 ||
      _myTime.difference(_ntpTime).inMinutes < -6) {
    GlobalWidgets().showToast(msg: 'Please Turn on Automatic date & Time');
  } else {
    runApp(const MyAppInitial());
  }

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

//PushNotification...........................................................................
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}

NotificationAppLaunchDetails notificationAppLaunchDetails =
    const NotificationAppLaunchDetails(false, '');

class MyAppInitial extends StatefulWidget {
  const MyAppInitial({Key? key}) : super(key: key);

  @override
  State<MyAppInitial> createState() => _MyAppInitialState();
}

class _MyAppInitialState extends State<MyAppInitial> {
  late SharedPreferences prefs;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  ProfileBasicDataStream basesettingstream = ProfileBasicDataStream();
  int homeredirect = 0;
  //(1)AccessToken..........
  void onClose() async {
    //registrationReDirect(context);
    prefs = await SharedPreferences.getInstance();

    // print(
    //     'registrationstatus..................${GlobalData.myProfile.usersBasicDetails.registrationStatus.toString()}');
    if (GlobalData.myProfile.usersBasicDetails?.registrationStatus == 1 &&
        prefs.getString('accessToken') != null) {
      setState(() {
        homeredirect = 1;
      });
    } else {
      setState(() {
        homeredirect = 0;
      });
    }
  }

  //(2)Initialisebasicdata..........
  void initializeBasicData() async {
    GlobalData.baseSettings = await Repository().fetchBaseSettings();

    Repository().fetchProfile('').then((value) {
      onClose();
      try {
        GlobalData.myProfile = value;
        print(
            'streamdata.............${GlobalData.myProfile.usersBasicDetails!.registrationStatus}');
      } catch (e) {
        onClose();
        print('$e');
      }
    }, onError: (e) {
      setAccessToken('');
      onClose();
    });
  }

//(3)Firebase Notification.........................................................
  void initializeNotification() async {
    // needed if you intend to initialize in the `main` function
    WidgetsFlutterBinding.ensureInitialized();

    notificationAppLaunchDetails = (await flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails())!;

    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
    // of the `IOSFlutterLocalNotificationsPlugin` class
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
          didReceiveLocalNotificationSubject.add(ReceivedNotification(
              id: id, title: title!, body: body!, payload: payload!));
        });
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      // selectNotificationSubject.add(payload);
    });
  }

  //.....IOS Permission..Firebase...............
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  //Show Notification................
  Map _modifyNotificationJson(Map<String, dynamic> message) {
    message['data'] = Map.from(message ?? {});
    message['notification'] = message['aps']['alert'];
    return message;
  }

  Future<void> showNotification(message) async {
    print('message----------');
    print(message);

    final notification = message['notification'];

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, notification['title'],
        notification['body'], platformChannelSpecifics,
        payload: 'item x');
  }

  @override
  void initState() {
    // TODO: implement initState
    initializeBasicData();
    onClose();
    print('fcm----------------------------');
    initializeNotification();
    requestIOSPermissions();
    _firebaseMessaging.getToken().then((onValue) {
      GlobalData.fcmToken = onValue.toString();
      print('fcmToken----------------------------');
      print(onValue);
    });
    print('subScribeNotification------------------');
    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    basesettingstream = ProfileBasicDataStream();
    basesettingstream.getbasesettingtData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatBloc>(
          create: (context) => ChatBloc(),
        ),
        BlocProvider<MatchBoardBloc>(
          create: (BuildContext context) => MatchBoardBloc(),
        ),
        BlocProvider<CouplingScoreBloc>(
          create: (BuildContext context) => CouplingScoreBloc(),
        ),
        BlocProvider<OthersProfileBloc>(
            create: (BuildContext context) => OthersProfileBloc()),
        BlocProvider<MomBloc>(
          create: (BuildContext context) => MomBloc(),
        ),
        BlocProvider<MembershipPlanBloc>(
          create: (context) => MembershipPlanBloc(),
        ),
        BlocProvider<MyPlansAndPaymentBloc>(
          create: (context) => MyPlansAndPaymentBloc(),
        ),
        BlocProvider<TolListBlocBloc>(
          create: (context) => TolListBlocBloc(),
        ),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!);
        },
        home:
            (GlobalData.myProfile.usersBasicDetails?.registrationStatus == 1 &&
                    prefs.getString('accessToken') != null)
                ? MainBoard()
                : IntroSlider(),
        title: "Coupled",
        debugShowCheckedModeBanner: false,
        theme: CoupledTheme().coupledTheme(),
        routes: <String, WidgetBuilder>{
          ///registration steps
          SectionOne.route: (context) => SectionOne(),
          SectionTwo.route: (context) => SectionTwo(),
          SectionThree.route: (context) => SectionThree(),
          SectionFour.route: (context) => SectionFour(),
          SectionFive.route: (context) => SectionFive(),
          SectionSix.route: (context) => SectionSix(),
          SectionSeven.route: (context) => SectionSeven(),
          SectionEight.route: (context) => SectionEight(),
          TOL.route: (context) => TOL(),
          AboutPicture.route: (context) => AboutPicture(
                baseSettings: [],
                context: context,
                profileResponse: ProfileResponse(
                    usersBasicDetails: UsersBasicDetails(),
                    mom: Mom(),
                    info: Info(maritalStatus: BaseSettings(options: [])),
                    preference:
                        Preference(complexion: BaseSettings(options: [])),
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
                        userDetail: UserDetail(
                            membership: Membership(paidMember: false))),
                    blockMe: Mom(),
                    reportMe: Mom(),
                    freeCoupling: [],
                    recomendCause: [],
                    shortlistByMe: Mom(),
                    shortlistMe: Mom(),
                    photoModel: PhotoModel(),
                    currentCsStatistics: CurrentCsStatistics(),
                    siblings: []),
              ),
          PhotoA.route: (context) => PhotoA(),
          ProEduA.route: (context) => ProEduA(),
          ProEduB.route: (context) => ProEduB(),
          ReligionA.route: (context) => ReligionA(),
          FamilyInfoA.route: (context) => FamilyInfoA(),
          FamilyInfoB.route: (context) => FamilyInfoB(),
          SecondWelcomeScreen.route: (context) => SecondWelcomeScreen(),
          CouplingScoreQuestions.route: (context) => CouplingScoreQuestions(),
          MOEVerification.route: (context) => MOEVerification(),
          SingleQuesModal.route: (context) => SingleQuesModal(
                questions: QResponse(
                    answers: [], subQuestion: null, userAnswer: UserAnswer()),
              ),
          //Start Screen
          IntroSlider.route: (context) => IntroSlider(),
          WelcomeScreen.route: (context) => WelcomeScreen(),
          Dashboard.route: (context) => Dashboard(),

          '/chatView': (BuildContext context) => ChatView(
                chatResponse: ChatResponse(
                    mom: MomM(),
                    partner: PartnerDetails(
                        dp: Dp(
                            photoName: '',
                            imageType: BaseSettings(options: []),
                            imageTaken: BaseSettings(options: []),
                            userDetail: UserDetail(
                                membership: Membership(paidMember: false))),
                        info: Info(maritalStatus: BaseSettings(options: [])),
                        photos: [])),
                membershipCode: '',
              ),
          '/chatList': (BuildContext context) => ChatList(),
          '/chatViewMain': (BuildContext context) => ChatViewMain(
                chatResponse: ChatResponse(
                    mom: MomM(),
                    partner: PartnerDetails(
                        dp: Dp(
                            photoName: '',
                            imageType: BaseSettings(options: []),
                            imageTaken: BaseSettings(options: []),
                            userDetail: UserDetail(
                                membership: Membership(paidMember: false))),
                        info: Info(maritalStatus: BaseSettings(options: [])),
                        photos: [])),
              ),
          '/introSlider': (BuildContext context) => IntroSlider(),
          '/startMain': (BuildContext context) => StartMain(),
          "/mainBoard": (BuildContext context) => MainBoard(),
          '/coupleUpPage': (BuildContext context) => SignUpForm(),
          '/profileSwitch': (BuildContext context) => ProfileSwitch(
                memberShipCode: '',
                userShortInfoModel: UserShortInfoModel(
                    response: UserShortInfoResponse.fromJson({})),
              ),
          '/notification': (BuildContext context) => Notifications(),
          '/matchMaker': (BuildContext context) => MatchMakerPage(),
          '/advancedSearch': (BuildContext context) => AdvancedSearch(),

          '/membershipPlans': (BuildContext context) => MembershipPlans(),
          '/myPlanPayments': (BuildContext context) => MyPlansAndPayment(),
          '/recommendation': (BuildContext context) => Recommendations(
                profileResponse: ProfileResponse(
                    usersBasicDetails: UsersBasicDetails(),
                    mom: Mom(),
                    info: Info(maritalStatus: BaseSettings(options: [])),
                    preference:
                        Preference(complexion: BaseSettings(options: [])),
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
                        userDetail: UserDetail(
                            membership: Membership(paidMember: false))),
                    blockMe: Mom(),
                    reportMe: Mom(),
                    freeCoupling: [],
                    recomendCause: [],
                    shortlistByMe: Mom(),
                    shortlistMe: Mom(),
                    photoModel: PhotoModel(),
                    currentCsStatistics: CurrentCsStatistics(),
                    siblings: []),
              ),
          '/gerneralMatches': (BuildContext context) => MatchBoardView(),
          '/tolitem': (BuildContext context) => TolItem(),
          '/tolHome': (BuildContext context) => TOLHome(),
          '/specially_request': (BuildContext context) => SpeciallyAbledList(),
          '/myprofile': (BuildContext context) => Profile(),
          '/forgotOtp': (BuildContext context) => ForgotPassword(),
//        '/registerPage': (BuildContext context) =>  CustomerRegister(),
          '/coupleUpPage': (BuildContext context) => SignUpForm(),
        },
      ),
    );
  }
}

// class MyWidget extends StatefulWidget {
//   const MyWidget({Key? key}) : super(key: key);

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }

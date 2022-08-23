import 'package:coupled/Home/Profile/Recommendation/bloc/recommend_bloc.dart';

import 'package:coupled/MatchMeter/view/mom_card.dart';

import 'package:coupled/Utils/coupled_strings.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/page_with_tabs.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/match_o_meter_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Recommendations extends StatefulWidget {
  final ProfileResponse profileResponse;

  const Recommendations({Key? key, required this.profileResponse})
      : super(key: key);

  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations>
    with SingleTickerProviderStateMixin {
  bool state = false;
  RecommendBloc recommendBloc = RecommendBloc();
  late TabController _tabController;
  late Recommendations recommendations;

  @override
  void didChangeDependencies() {
    recommendations =
        ModalRoute.of(context)!.settings.arguments as Recommendations ??
            ProfileResponse(
                usersBasicDetails: UsersBasicDetails(),
                mom: Mom(),
                info: Info(maritalStatus: BaseSettings(options: [])),
                preference: Preference(
                  complexion: BaseSettings(options: []),
                ),
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
                    userDetail:
                        UserDetail(membership: Membership(paidMember: false))),
                blockMe: Mom(),
                reportMe: Mom(),
                freeCoupling: [],
                recomendCause: [],
                shortlistByMe: Mom(),
                shortlistMe: Mom(),
                photoModel: PhotoModel(),
                currentCsStatistics: CurrentCsStatistics(),
                siblings: []) as Recommendations;

    super.didChangeDependencies();
  }

  dynamic response = MoMResponse(data: []);
  @override
  void initState() {
    super.initState();
    recommendBloc = RecommendBloc();
    recommendBloc.add(LoadRecommendation('given'));

    _tabController = TabController(vsync: this, length: 2);

    _tabController.animation!.addListener(() {
      state = _tabController.animation!.value > .5;
    });

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _tabController.index == 0
            ? recommendBloc.add(LoadRecommendation('given'))
            : recommendBloc.add(LoadRecommendation('received'));
      }
    });
  }

  List<Widget> dataList(Pager pager, MoMResponse? response) {
    List<Widget> list = [];

    if (response == null)
      return [
        Container(
            height: 80,
            child: Center(child: GlobalWidgets().showCircleProgress()))
      ];

    if (response.path == null)
      return [
        Container(
            height: 80,
            child: Center(
                child: TextView(
              'No profile recommendations',
              color: Colors.white,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
              size: 12,
            )))
      ];
    response.data?.forEach(
      (f) {
        list.add(
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: MomCard(
              page: pager,
              data: f,
              matchMeterModel:
                  MatchOMeterModel(response: MoMResponse(data: [f])),
              partner: _tabController.index == 0,
            ),
          ),
        );
      },
    );

    return list;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoupledTheme().backgroundColor,
      appBar: AppBar(
        backgroundColor: CoupledTheme().backgroundColor,
        title: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextView(
                "Recommendations",
                size: 22,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
              ),
            ],
          ),
        ),
      ),
      body: BlocListener(
        bloc: recommendBloc,
        listener: (context, RecommendState state) {
          print('state---------------------$state');
          if (state is RecommendationLoaded) {
            setState(() {
              response = state.momData.response;
            });
          } else if (state is RecommendErrorState) {
            setState(() {
              response = MoMResponse(data: []);
            });
          } else {
            setState(() {
              response = null;
            });
          }
        },
        child: PageWithTabs(
          tabController: _tabController,
          tabName: ["Given", "Received"],
          tabData: [
            dataList(Pager.RECOMMENDATIONS, response),
            dataList(Pager.RECOMMENDATIONS, response)
          ],
          hint: CoupledStrings.recommendationNote,
          isCountVisible: true,
          dividerVisibility: true,
          isHintVisible: _tabController.index == 0,
          tab1Count: recommendations.profileResponse.recommendGiven.toString(),
          tab2Count:
              recommendations.profileResponse.recommendReceived.toString(),
        ),
      ),
    );
  }
}

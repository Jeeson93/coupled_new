import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:coupled/PlansAndPayment/MembershipPlans/bloc/bloc.dart';
import 'package:coupled/PlansAndPayment/MembershipPlans/bloc/membership_plan_bloc.dart';
import 'package:coupled/PlansAndPayment/MembershipPlans/view/PlanDetailsPage.dart';
import 'package:coupled/PlansAndPayment/MyPlansandPayments/view/MyPlansAndPayment.dart';

import 'package:coupled/Utils/coupled_strings.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MembershipPlans extends StatefulWidget {
  final int index;

  const MembershipPlans({Key? key, this.index = 0}) : super(key: key);

  @override
  _MembershipPlansState createState() => _MembershipPlansState();
}

class _MembershipPlansState extends State<MembershipPlans>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<Tab> myTabTitleList = [];
  List<PlanDetailsPage> myTabList = [];
  int bgImageCount = 2;
  TabController? _tabController;
  List<String> cardBgImages = [
    "assets/PlansAndPayment/Silver.png",
    "assets/PlansAndPayment/Gold.png",
    "assets/PlansAndPayment/Diamond.png",
    "assets/PlansAndPayment/Platinum.png",
  ];

  CouplingScoreStatistics statistics = CouplingScoreStatistics();
  String currentPlanName = 'Free';
  List<Widget> planFeaturesList = [];
  MembershipPlanBloc plansAndPaymentBloc = MembershipPlanBloc();

  @override
  void initState() {
    plansAndPaymentBloc = BlocProvider.of<MembershipPlanBloc>(context);
    plansAndPaymentBloc.add(LoadMembershipPlans());

    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  "Membership Plans",
                  size: 22,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 6),
                  child: Column(
                    children: <Widget>[
                      TextView(
                        'Free',
                        size: 16,
                        color: CoupledTheme().primaryPinkDark,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                      TextView(
                        "Member",
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                        size: 12,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: BlocBuilder(
          bloc: plansAndPaymentBloc,
          builder: (context, MembershipPlanState state) {
            if (state is LoadedPlansAndPayment) {
              setData(state.plansAndPayment);
              return DefaultTabController(
                length: state.plansAndPayment.response!.plans!.length,
                child: Scaffold(
                  backgroundColor: CoupledTheme().backgroundColor,
                  appBar: TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      isScrollable: true,
                      indicator: BubbleTabIndicator(
                        indicatorColor: CoupledTheme().ashSelectedColor,
                        indicatorHeight: 30,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                        padding: EdgeInsets.only(left: 50.0),
                      ),
                      tabs: myTabTitleList),
                  body: TabBarView(children: myTabList),
                ),
              );
            } else if (state is PlansAndPaymentErrorState) {
              return GlobalWidgets().errorState(message: state.errorMessage);
            } else {
              return GlobalWidgets().showCircleProgress();
            }
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;

  getBgImage() {
    bgImageCount++;
    if (bgImageCount == 4) bgImageCount = 0;
    return cardBgImages[bgImageCount];
  }

  void setData(MembershipPlansModel plansAndPayment) {
    // currentPlanName = plansAndPayment[1].purchaseplan.planName;
    myTabTitleList.clear();
    myTabList.clear();
    plansAndPayment.response!.plans!.forEach(
      (f) {
        List<PlanFeatures> planFeatures = [];
        List<Widget> planFeatureCards = [];

        myTabTitleList.add(Tab(
          child: TextView(
            '${f.planName} Plan',
            color: Colors.white,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            textScaleFactor: .8,
            size: 12,
          ),
        ));
        myTabList.add(
          PlanDetailsPage(
            statistics: plansAndPayment.response!.statistics,
            topList: f.topups,
            plan: f,
            profileResponse: GlobalData.myProfile,
            backgroundImg: getBgImage(),
            featuresItemsList: planFeatureCards,
          ),
        );

        /**
         * ----14 plan features---
         *
         *
          "Search Profiles",
          "View Profiles",
          "Send Unlimited Interests",
          'Coupling Score - Visibility',
          "Send Personalized message with Interests",
          "Instant Chat (with Stickers and Emojis)",
          'Coupling Score - Statistics Eligibility',
          "Token of Love - Eligibility",
          'Recommend Profile',
          "Share profile",
          "Verified Badge",
          "Profile Highlighter",
          "Recommended Match of Day - Mail/ App Alerts",
          "Prominent Display in search",*/

        List planFeatureAvailability = [
          f.searchProfile,
          f.viewProfile,
          f.sendInterests,
          f.csMatch,
          f.messages,
          f.instantChat,
          f.csStatistics,
          f.tokenOfLove,
          f.recommend,
          f.whatsappShare,
          f.verificationBadge,
          f.profileHighlight,
          f.mailAlerts,
          f.linkedinValidity,
        ];

        CoupledStrings.planFeatureList.asMap().forEach((i, element) {
          planFeatures.add(
            PlanFeatures(element, planFeatureAvailability[i]),
          );
        });

        planFeatures.sort((a, b) => b.availability.compareTo(a.availability));

        planFeatures.forEach((element) {
          planFeatureCards
              .add(buildPlanDetails(element.value, element.availability));
        });
      },
    );
  }
}

import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/expansion_tile_custom.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:date_format/date_format.dart';
import 'package:coupled/PlansAndPayment/MembershipPlans/view/paymentBottomSheet.dart';
import 'package:coupled/PlansAndPayment/MyPlansandPayments/bloc/bloc.dart';
import 'package:coupled/PlansAndPayment/MyPlansandPayments/bloc/my_plans_and_payment_bloc.dart';
import 'package:coupled/PlansAndPayment/MyPlansandPayments/view/MyPlansHelper.dart';
import 'package:coupled/PlansAndPayment/MyPlansandPayments/view/TopUpPlanListItem2.dart';
import 'package:coupled/PlansAndPayment/MyPlansandPayments/view/planFeaturesCard.dart';
import 'package:coupled/PlansAndPayment/MyPlansandPayments/view/transaction_history.dart';

import 'package:coupled/Utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPlansAndPayment extends StatefulWidget {
  @override
  _MyPlansAndPaymentState createState() => _MyPlansAndPaymentState();
}

class _MyPlansAndPaymentState extends State<MyPlansAndPayment>
    with SingleTickerProviderStateMixin {
  late AnimationController turnAnimation;
  late List<PlanTopup> topList;
  MyPlansAndPaymentModel myPlansAndPaymentModel = MyPlansAndPaymentModel(
      response: MyPlansAndPaymentModelResponse(
          activePlan: Plan(topups: []),
          activeStatistic: Statistic(),
          activeTopup: Topup(),
          statistics: CouplingScoreStatistics(),
          upcomingStatistic: Statistic(),
          upcomingTopup: Topup()));
  PlanTopup? selectedTopUp =
      PlanTopup(plan: Plan(topups: []), topup: ResponseTopup(topup: []));
  Plan plan = Plan(topups: []);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<State> _topUpExpansion = GlobalKey();
  List<Widget> planFeatureCards = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print('btnTopUp-------------');
    print(btnTopUp);
    print(isTopUpSelected);

    super.didChangeDependencies();
  }

  MyPlansAndPaymentBloc myPlansAndPaymentBloc = MyPlansAndPaymentBloc();

  @override
  void initState() {
    myPlansAndPaymentBloc = BlocProvider.of<MyPlansAndPaymentBloc>(context);
    myPlansAndPaymentBloc.add(LoadMyPlans());

    turnAnimation = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 75),
        reverseDuration: Duration(milliseconds: 75));
    super.initState();
  }

  GlobalKey toolKey = GlobalKey();
  GlobalKey toolKey1 = GlobalKey();
  GlobalKey toolKey2 = GlobalKey();
  bool btnTopUp = false;
  bool isTopUpSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoupledTheme().backgroundColor,
      body: BlocBuilder(
        bloc: myPlansAndPaymentBloc,
        builder: (context, MyPlansAndPaymentState state) {
          print('state--------------------$state');
          if (state is LoadedMyPlans) {
            addData(state);
            print('plan.expiredAt------------');
            // print(plan?.expiredAt);
            // print(plan?.expiredAt.isAfter(DateTime.now()));
            // print(DateTime.now().isAfter(plan.expiredAt));
            return Scaffold(
              key: _scaffoldKey,
              backgroundColor: CoupledTheme().backgroundColor,
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextView(
                      "My Plans and Payment",
                      size: 18,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      overflow: TextOverflow.visible,
                      textScaleFactor: .8,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextView(
                          plan.planName ?? '',
                          size: 16,
                          color: CoupledTheme().primaryPinkDark,
                          decoration: TextDecoration.none,
                          overflow: TextOverflow.visible,
                          textScaleFactor: .8,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                        ),
                        TextView(
                          "Member",
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          overflow: TextOverflow.visible,
                          textScaleFactor: .8,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                ],
                backgroundColor: CoupledTheme().backgroundColor,
              ),
              body: Builder(builder: (context) {
                return SingleChildScrollView(
                  // reverse: true,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        ///balance and validity info
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: CoupledTheme().myPlanCardBackgroundColor,
                            ),
                            child: ExpansionTileCustom(
                              initiallyExpanded: true,
                              title: TextView(
                                "Balance & Validity Info",
                                size: 18,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                overflow: TextOverflow.visible,
                                textScaleFactor: 1,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.left,
                              ),
                              backgroundColor: Color(0xFF35374C),
                              leading: SizedBox(),
                              trailing: SizedBox(),
                              onExpansionChanged: (bool value) {},
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Opacity(
                                    opacity:
                                        DateTime.now().isAfter(plan.expiredAt!)
                                            ? 0.5
                                            : 1,
                                    child: Card(
                                      color: CoupledTheme().backgroundColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 3,
                                                child: ProgressBarCard(
                                                  availableCredit:
                                                      plan.currentProfilesCount !=
                                                              null
                                                          ? plan
                                                              .currentProfilesCount
                                                          : 0,
                                                  totalCredit:
                                                      plan.profilesCount != null
                                                          ? plan.profilesCount
                                                          : 0,
                                                  title:
                                                      'Contact & Chat Credits',
                                                ),
                                              ),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: ProgressBarCard(
                                                  availableCredit:
                                                      plan.currentCsStatistics !=
                                                              null
                                                          ? plan
                                                              .currentCsStatistics
                                                          : 0,
                                                  totalCredit:
                                                      plan.csStatistics != null
                                                          ? plan.csStatistics
                                                          : 0,
                                                  title:
                                                      'Coupling Score Credits',
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8, top: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      TextView(
                                                        '₹${plan.amount}',
                                                        size: 22,
                                                        color: CoupledTheme()
                                                            .primaryBlue,
                                                        decoration:
                                                            TextDecoration.none,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        textScaleFactor: .8,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextView(
                                                        'Credit \n Start date',
                                                        size: 14,
                                                        textAlign:
                                                            TextAlign.end,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.white,
                                                        decoration:
                                                            TextDecoration.none,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        textScaleFactor: .8,
                                                        maxLines: 2,
                                                      ),
                                                      TextView(
                                                        '${formatDate(plan.createdAt ?? DateTime.now(), [
                                                              dd,
                                                              '.',
                                                              mm,
                                                              '.',
                                                              yy
                                                            ])}',
                                                        size: 12,
                                                        color: Colors.white,
                                                        decoration:
                                                            TextDecoration.none,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        textScaleFactor: .8,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextView(
                                                        'Credit\nExpiry date',
                                                        textAlign:
                                                            TextAlign.end,
                                                        size: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.white,
                                                        decoration:
                                                            TextDecoration.none,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        textScaleFactor: .8,
                                                        maxLines: 2,
                                                      ),
                                                      TextView(
                                                        '${formatDate(plan.expiredAt ?? DateTime.now(), [
                                                              dd,
                                                              '.',
                                                              mm,
                                                              '.',
                                                              yy
                                                            ])}',
                                                        size: 12,
                                                        color: Colors.white,
                                                        textAlign:
                                                            TextAlign.center,
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        textScaleFactor: .8,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TransactionHistory(),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: TextView(
                                            'Transaction History',
                                            size: 14,
                                            color: CoupledTheme().primaryBlue,
                                            decoration:
                                                TextDecoration.underline,
                                            textAlign: TextAlign.center,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.visible,
                                            textScaleFactor: .8,
                                          ),
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),

                        ///other active plans
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: CoupledTheme().myPlanCardBackgroundColor,
                            ),
                            child: ExpansionTileCustom(
                              title: TextView(
                                "Other Active Plan",
                                size: 18,
                                color: Colors.white,
                                textAlign: TextAlign.left,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.visible,
                                textScaleFactor: .8,
                              ),
                              backgroundColor: Color(0xFF35374C),
                              leading: SizedBox(),
                              onExpansionChanged: (bool value) {},
                              trailing: SizedBox(),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: TextView(
                                                  "Recommendation Credits ${myPlansAndPaymentModel.response?.activeTopup?.bonusCurrentProfiles ?? 0}/${myPlansAndPaymentModel.response?.activeTopup?.bonusProfiles ?? 0} ",
                                                  color: Colors.white,
                                                  textAlign: TextAlign.center,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  textScaleFactor: .8,
                                                  size: 12,
                                                ),
                                              ),
                                              WidgetSpan(
                                                child: TooltipTheme(
                                                  data: TooltipThemeData(
                                                      textStyle: TextStyle(
                                                          color: Colors.white)),
                                                  child: Tooltip(
                                                    key: toolKey2,
                                                    message: CoupledStrings
                                                        .recommendation,
                                                    excludeFromSemantics: true,
                                                    preferBelow: false,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8,
                                                            horizontal: 8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        final dynamic tooltip =
                                                            toolKey2
                                                                .currentState;
                                                        tooltip
                                                            .ensureTooltipVisible();
                                                      },
                                                      child: Container(
                                                        height: 15,
                                                        width: 15,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: CoupledTheme()
                                                                  .primaryBlue),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(1.0),
                                                              child:
                                                                  Image.asset(
                                                                "assets/PlansAndPayment/information-variant.png",
                                                                height: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 5,
                                            child: Opacity(
                                              opacity: myPlansAndPaymentModel
                                                          .response
                                                          ?.activeTopup ==
                                                      null
                                                  ? 0.5
                                                  : 1,
                                              child: Card(
                                                color: CoupledTheme()
                                                    .backgroundColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ProgressBarCard(
                                                    availableCredit:
                                                        myPlansAndPaymentModel
                                                                .response
                                                                ?.activeTopup
                                                                ?.currentProfiles ??
                                                            0,
                                                    totalCredit:
                                                        myPlansAndPaymentModel
                                                                .response
                                                                ?.activeTopup
                                                                ?.profiles ??
                                                            10,
                                                    title:
                                                        'Contact & Chat Credits',
                                                    otherPlanVisible: true,
                                                    totalAmount:
                                                        '₹ ${myPlansAndPaymentModel.response?.activeTopup?.amount ?? '---'}',
                                                    startDate:
                                                        myPlansAndPaymentModel
                                                            .response
                                                            ?.activeTopup
                                                            ?.activeAt,
                                                    expireDate:
                                                        myPlansAndPaymentModel
                                                            .response
                                                            ?.activeTopup
                                                            ?.expiredAt,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Opacity(
                                              opacity: myPlansAndPaymentModel
                                                          .response
                                                          ?.activeStatistic ==
                                                      null
                                                  ? 0.5
                                                  : 1,
                                              child: Card(
                                                color: CoupledTheme()
                                                    .backgroundColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ProgressBarCard(
                                                    title:
                                                        'Coupling Score Credits',
                                                    otherPlanVisible: true,
                                                    isInfinity: true,
                                                    totalAmount:
                                                        '₹ ${myPlansAndPaymentModel.response?.activeStatistic.activationFee ?? '---'}',
                                                    startDate:
                                                        myPlansAndPaymentModel
                                                            .response
                                                            ?.activeStatistic
                                                            .activeAt,
                                                    expireDate: myPlansAndPaymentModel
                                                                .response
                                                                ?.activeStatistic
                                                                .couplingScorePlanOption ==
                                                            'life-time-validity'
                                                        ? 'lifetime'
                                                        : myPlansAndPaymentModel
                                                            .response
                                                            ?.activeStatistic
                                                            .expiredAt,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ListView(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: [
                                          Opacity(
                                            opacity: myPlansAndPaymentModel
                                                        .response
                                                        ?.upcomingTopup ==
                                                    null
                                                ? 0.5
                                                : 1,
                                            child: Card(
                                              color: CoupledTheme()
                                                  .backgroundColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        TextView(
                                                          'Top Up ₹${myPlansAndPaymentModel.response?.upcomingTopup.amount ?? '0'}',
                                                          size: 18,
                                                          color: Colors.white,
                                                          textAlign:
                                                              TextAlign.center,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          overflow: TextOverflow
                                                              .visible,
                                                          textScaleFactor: .9,
                                                        ),
                                                        TextView(
                                                            'Contact & Chat Credit',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            textAlign: TextAlign
                                                                .center,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            textScaleFactor: .9,
                                                            size: 12),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            TextView(
                                                              'Top up date : ${myPlansAndPaymentModel.response?.upcomingTopup.createdAt != null ? formatDate(myPlansAndPaymentModel.response?.upcomingTopup.createdAt, [
                                                                      dd,
                                                                      '.',
                                                                      mm,
                                                                      '.',
                                                                      yy
                                                                    ]) : 'NA'}',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              textScaleFactor:
                                                                  .8,
                                                              size: 12,
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            TextView(
                                                              'Validity : ${myPlansAndPaymentModel.response?.upcomingTopup.validity ?? '0'} Days',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              textScaleFactor:
                                                                  .8,
                                                              size: 12,
                                                            ),
                                                          ],
                                                        ),
                                                        TextView(
                                                          '${myPlansAndPaymentModel.response?.upcomingTopup.profiles ?? '0'}',
                                                          size: 22,
                                                          color: CoupledTheme()
                                                              .primaryBlue,
                                                          textAlign:
                                                              TextAlign.center,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          overflow: TextOverflow
                                                              .visible,
                                                          textScaleFactor: .8,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Opacity(
                                            opacity: myPlansAndPaymentModel
                                                        .response
                                                        ?.upcomingStatistic ==
                                                    null
                                                ? 0.5
                                                : 1,
                                            child: Card(
                                              color: CoupledTheme()
                                                  .backgroundColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        TextView(
                                                          'Coupling Score ₹${myPlansAndPaymentModel.response?.upcomingStatistic.activationFee ?? '0'}',
                                                          size: 18,
                                                          color: Colors.white,
                                                          textAlign:
                                                              TextAlign.left,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          overflow: TextOverflow
                                                              .visible,
                                                          textScaleFactor: .8,
                                                        ),
                                                        TextView(
                                                          'Coupling Score\nCredits',
                                                          size: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          textAlign:
                                                              TextAlign.center,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          overflow: TextOverflow
                                                              .visible,
                                                          textScaleFactor: .8,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            TextView(
                                                              'Top up date : ${myPlansAndPaymentModel.response?.upcomingStatistic?.createdAt != null ? formatDate(myPlansAndPaymentModel.response?.upcomingStatistic?.createdAt, [
                                                                      dd,
                                                                      '.',
                                                                      mm,
                                                                      '.',
                                                                      yy
                                                                    ]) : 'NA'}',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              textScaleFactor:
                                                                  .8,
                                                              size: 12,
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            TextView(
                                                              'Validity : ${myPlansAndPaymentModel.response?.upcomingStatistic.validity ?? '0'} Days',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              textScaleFactor:
                                                                  .8,
                                                              size: 12,
                                                            ),
                                                          ],
                                                        ),
                                                        TextView(
                                                          'Unlimited',
                                                          size: 18,
                                                          color: Colors.white,
                                                          textAlign:
                                                              TextAlign.center,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          overflow: TextOverflow
                                                              .visible,
                                                          textScaleFactor: .8,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ///top up plans
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: CoupledTheme().myPlanCardBackgroundColor,
                            ),
                            child: ExpansionTileCustom(
                              key: _topUpExpansion,
                              title: TextView(
                                "Top Up Plans",
                                size: 18,
                                color: Colors.white,
                                textAlign: TextAlign.left,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.visible,
                                textScaleFactor: .8,
                              ),
                              backgroundColor: Color(0xFF35374C),
                              leading: SizedBox(),
                              onExpansionChanged: (bool value) {},
                              trailing: SizedBox(),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: 35,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: TextView(
                                                "Top Up Plans (Rs)",
                                                textAlign: TextAlign.left,
                                                size: 15,
                                                color: Colors.white,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.visible,
                                                textScaleFactor: .8,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: TextView(
                                                "Validity (Days)",
                                                textAlign: TextAlign.center,
                                                size: 15,
                                                color: Colors.white,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.visible,
                                                textScaleFactor: .8,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: TextView(
                                                "Contact Credits",
                                                textAlign: TextAlign.center,
                                                size: 15,
                                                color: Colors.white,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.visible,
                                                textScaleFactor: .8,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: plan.plans != null
                                              ? plan.plans?.topups?.length
                                              : 0,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return TopUpPlanListItem2(
                                              topUpPlans:
                                                  plan.plans?.topups?[index],
                                              state: index,
                                              value: plan.plans?.topups?[index]
                                                  .isChecked,
                                              onChange: (value) {
                                                setState(
                                                  () {
                                                    plan.plans?.topups
                                                        ?.forEach((f) {
                                                      f.isChecked = false;
                                                    });
                                                    plan.plans?.topups?[index]
                                                        .isChecked = value;
                                                    isTopUpSelected = value!;
                                                    selectedTopUp = plan
                                                        .plans?.topups?[index];

                                                    ///to enable top up button need to satisfying following conditions
                                                    ///1.upcoming topUp must be null
                                                    ///2.active plan contactCredit <= 5 OR 5 days before/after the date expires
                                                    ///3.if have an existing active topUp plan, apply No2
                                                    print(
                                                        'Check..${myPlansAndPaymentModel.response!.activeTopup!.expiredAt!.isBefore(
                                                      DateTime.now().add(
                                                        Duration(days: 5),
                                                      ),
                                                    )}');
                                                    if (myPlansAndPaymentModel
                                                            .response !=
                                                        null) {
                                                      btnTopUp =
                                                          (isTopUpSelected &&
                                                              (myPlansAndPaymentModel
                                                                      .response
                                                                      ?.upcomingTopup ==
                                                                  null) &&
                                                              //.......................(1)..................................//
                                                              ((myPlansAndPaymentModel
                                                                          .response
                                                                          ?.activePlan
                                                                          .currentProfilesCount <=
                                                                      5) ||
                                                                  (myPlansAndPaymentModel
                                                                      .response!
                                                                      .activePlan
                                                                      .expiredAt!
                                                                      .isBefore(
                                                                    DateTime.now()
                                                                        .add(
                                                                      Duration(
                                                                          days:
                                                                              5),
                                                                    ),
                                                                  ))) &&
                                                              //............................(2)........................................//
                                                              (((myPlansAndPaymentModel
                                                                          .response
                                                                          ?.activeTopup
                                                                          ?.currentProfiles <=
                                                                      5)) ||
                                                                  (myPlansAndPaymentModel
                                                                      .response!
                                                                      .activeTopup!
                                                                      .expiredAt!
                                                                      .isBefore(
                                                                    DateTime.now()
                                                                        .add(
                                                                      Duration(
                                                                          days:
                                                                              5),
                                                                    ),
                                                                  ))));
                                                    }
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: CustomButton(
                                          disabledReasonMsg:
                                              CoupledStrings.topUpEligibility,
                                          onPressed: () {
                                            PaymentBottomSheet()
                                                .paymentBottomSheet(
                                              context: context,
                                              topUpPlan: selectedTopUp,
                                              couplingScore:
                                                  myPlansAndPaymentModel
                                                      .response!.statistics,
                                              profileResponse:
                                                  GlobalData.myProfile,
                                            );
                                          },
                                          enabled: btnTopUp,
                                          borderRadius:
                                              BorderRadius.circular(2.0),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: TextView(
                                              "Top Up",
                                              size: 16,
                                              color: Colors.white,
                                              textAlign: TextAlign.left,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.visible,
                                              textScaleFactor: .8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ///coupling score activation
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: CoupledTheme().myPlanCardBackgroundColor,
                            ),
                            child: ExpansionTileCustom(
                              onExpansionChanged: (value) {
                                print(value);
                              },
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: TextView(
                                              'Coupling Score Activation ',
                                              size: 15,
                                              color: Colors.white,
                                              textAlign: TextAlign.left,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.visible,
                                              textScaleFactor: .8,
                                            ),
                                          ),
                                          WidgetSpan(
                                            child: TooltipTheme(
                                              data: TooltipThemeData(
                                                  textStyle: TextStyle(
                                                      color: Colors.black)),
                                              child: Tooltip(
                                                key: toolKey1,
                                                message: CoupledStrings
                                                    .couplingScoreActivation,
                                                excludeFromSemantics: true,
                                                preferBelow: false,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 8),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    final dynamic tooltip =
                                                        toolKey1.currentState;
                                                    tooltip
                                                        .ensureTooltipVisible();
                                                  },
                                                  child: Container(
                                                    height: 16,
                                                    width: 16,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: CoupledTheme()
                                                              .primaryBlue),
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(1.0),
                                                          child: Image.asset(
                                                            "assets/PlansAndPayment/information-variant.png",
                                                            height: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  TextView(
                                    '(Introductory offer price)',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    textAlign: TextAlign.left,
                                    decoration: TextDecoration.none,
                                    overflow: TextOverflow.visible,
                                    textScaleFactor: .8,
                                    size: 12,
                                  ),
                                ],
                              ),
                              backgroundColor: Color(0xFF35374C),
                              leading: SizedBox(),
                              trailing: SizedBox(),
                              children: <Widget>[
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      bottom: 16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      //children: planDetails
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: TextView(
                                                  "Amount",
                                                  color: Colors.white,
                                                  textAlign: TextAlign.left,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  textScaleFactor: .8,
                                                  size: 12,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: TextView(
                                                  myPlansAndPaymentModel
                                                      .response
                                                      ?.statistics
                                                      .activationFee,
                                                  size: 15,
                                                  color: Colors.white,
                                                  textAlign: TextAlign.left,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  textScaleFactor: .8,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: TextView(
                                                  "Validity",
                                                  color: Colors.white,
                                                  textAlign: TextAlign.left,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  textScaleFactor: .8,
                                                  size: 12,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: TextView(
                                                  "${myPlansAndPaymentModel.response?.statistics.validity} Days",
                                                  size: 15,
                                                  color: Colors.white,
                                                  textAlign: TextAlign.left,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  textScaleFactor: .8,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: TextView(
                                                  "Views",
                                                  color: Colors.white,
                                                  textAlign: TextAlign.left,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  textScaleFactor: .8,
                                                  size: 12,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: TextView(
                                                  "NA*",
                                                  size: 15,
                                                  color: Colors.white,
                                                  textAlign: TextAlign.left,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  textScaleFactor: .8,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: TextView(
                                            "*Once viewed would always be open to view again",
                                            size: 12,
                                            color: Colors.white,
                                            textAlign: TextAlign.left,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.visible,
                                            textScaleFactor: .8,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Align(
                                            alignment: Alignment.centerRight,

                                            ///to enable Coupling Score button satisfying following conditions
                                            ///1.upcoming coupling score must be null
                                            ///2.active plan coupling score <= 5 OR 5 days before/after the date expires
                                            ///3.if have an existing coupling score, apply No2
                                            ///4.check for lifetime validity
                                            child: CustomButton(
                                              disabledReasonMsg: CoupledStrings
                                                  .couplingScoreEligibility,
                                              enabled: ((myPlansAndPaymentModel
                                                          .response
                                                          ?.activeStatistic
                                                          .couplingScorePlanOption !=
                                                      'life-time-validity') &&
                                                  (myPlansAndPaymentModel
                                                          .response
                                                          ?.upcomingStatistic ==
                                                      null) &&
                                                  ((myPlansAndPaymentModel
                                                              .response
                                                              ?.activePlan
                                                              .csStatistics <=
                                                          5) ||
                                                      (myPlansAndPaymentModel
                                                          .response!
                                                          .activePlan
                                                          .expiredAt!
                                                          .isBefore(
                                                        DateTime.now().add(
                                                          Duration(days: 5),
                                                        ),
                                                      ))) &&
                                                  (myPlansAndPaymentModel
                                                              .response
                                                              ?.activeStatistic !=
                                                          null
                                                      ? myPlansAndPaymentModel
                                                          .response
                                                          ?.activeStatistic
                                                          .expiredAt
                                                          .isBefore(
                                                          DateTime.now().add(
                                                            Duration(days: 5),
                                                          ),
                                                        )
                                                      : true)),
                                              borderRadius:
                                                  BorderRadius.circular(2.0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                child: TextView(
                                                  "Activate",
                                                  size: 16,
                                                  color: Colors.white,
                                                  textAlign: TextAlign.left,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  textScaleFactor: .8,
                                                ),
                                              ),
                                              onPressed: () {
                                                PaymentBottomSheet()
                                                    .paymentBottomSheet(
                                                  context: context,
                                                  isCouplingPlan: true,
                                                  couplingScore:
                                                      myPlansAndPaymentModel
                                                          .response!.statistics,
                                                  profileResponse:
                                                      GlobalData.myProfile,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ///membership plan details
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: CoupledTheme().myPlanCardBackgroundColor,
                            ),
                            child: ExpansionTileCustom(
                              onExpansionChanged: (value) {},
                              title: TextView(
                                "Membership Plan Details",
                                size: 18,
                                color: Colors.white,
                                textAlign: TextAlign.left,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.visible,
                                textScaleFactor: .8,
                              ),
                              backgroundColor: Color(0xFF35374C),
                              leading: SizedBox(),
                              trailing: SizedBox(),
                              children: <Widget>[
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, bottom: 16),
                                    child: PlanDetailsCard(
                                        color:
                                            CoupledTheme().backgroundHighlight,
                                        planDetails: planFeatureCards),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          } else if (state is MyPlansErrorState) {
            return GlobalWidgets().errorState(message: state.errorMessage);
          } else {
            return GlobalWidgets().showCircleProgress();
          }
        },
      ),
    );
  }

  List<PlanFeatures> planFeatures = [];

  void addData(LoadedMyPlans state) {
    myPlansAndPaymentModel = state.plansAndPayment;
    plan = myPlansAndPaymentModel.response!.activePlan;
    planFeatureCards.clear();
    planFeatures.clear();

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
      plan.searchProfile,
      plan.viewProfile,
      plan.sendInterests,
      plan.csMatch,
      plan.messages,
      plan.instantChat,
      plan.csStatistics,
      plan.tokenOfLove,
      plan.recommend,
      plan.whatsappShare,
      plan.verificationBadge,
      plan.profileHighlight,
      plan.mailAlerts,
      plan.linkedinValidity,
    ];

    CoupledStrings.planFeatureList.asMap().forEach((i, element) {
      planFeatures.add(
        PlanFeatures(
            element,
            planFeatureAvailability[i] == null
                ? 0
                : planFeatureAvailability[i]),
      );
    });

    //  planFeatures.sort((a, b) => b.availability.compareTo(a.availability));

    planFeatures.forEach((element) {
      planFeatureCards
          .add(buildPlanDetails(element.value, element.availability));
    });
  }
}

class PlanFeatures {
  String value;
  int availability;

  PlanFeatures(this.value, this.availability);

  @override
  String toString() {
    return 'PlanFeatures{value: $value, availability: $availability}';
  }
}

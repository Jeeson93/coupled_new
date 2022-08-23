import 'package:coupled/PlansAndPayment/MembershipPlans/view/TopUpPlanListItem.dart';
import 'package:coupled/PlansAndPayment/MembershipPlans/view/paymentBottomSheet.dart';
import 'package:coupled/PlansAndPayment/MyPlansandPayments/view/planFeaturesCard.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanDetailsPage extends StatefulWidget {
  final dynamic backgroundImg;
  final dynamic featuresItemsList;
  final dynamic topList;
  final dynamic statistics;
  final dynamic profileResponse;
  final dynamic plan;

  PlanDetailsPage(
      {this.backgroundImg = "",
      this.statistics,
      this.featuresItemsList,
      this.topList,
      this.profileResponse,
      this.plan});

  @override
  _PlanDetailsPageState createState() => _PlanDetailsPageState();
}

class _PlanDetailsPageState extends State<PlanDetailsPage> {
  List<Widget> topUpItemsList = [];
  final GlobalKey toolKey = GlobalKey();
  final GlobalKey toolKey1 = GlobalKey();
  int i = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.plan.amount == '0'
        ? SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: PlanCards(
                      offerCard: <Widget>[
                        buildOfferCard(widget.plan.profilesCount.toString(),
                            "Contact Views & Chat Credit"),
                        buildOfferCard(widget.plan.csStatistics.toString(),
                            "Coupling Score Predictions Credit"),
                      ],
                      planName: "${widget.plan.planName} Member",
                      backgroundImg: "assets/PlansAndPayment/Free-Plan.png",
                      planPrice: widget.plan.amount,
                      headerSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: PlanDetailsCard(
                      color: CoupledTheme().planCardBackground,
                      planDetails: widget.featuresItemsList),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: CoupledTheme().planCardBackground,
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            //children: planDetails
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, bottom: 5, left: 16, right: 16),
                                child: Container(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: TextView(
                                            'Coupling Score Activation',
                                            size: 15,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                            color: Colors.white,
                                          ),
                                        ),
                                        WidgetSpan(
                                            child: TextView(
                                                ' (Introductory offer price) ',
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.visible,
                                                textAlign: TextAlign.center,
                                                textScaleFactor: .8,
                                                color: Colors.white,
                                                size: 12)),
                                        WidgetSpan(
                                          child: TooltipTheme(
                                            data: TooltipThemeData(
                                                textStyle: TextStyle(
                                                    color: Colors.black)),
                                            child: Tooltip(
                                              key: toolKey1,
                                              message:
                                                  "Activating Coupling Score Stats would allow you "
                                                  "to see match predictions for each of the 16 Qs & As "
                                                  "for a partner. Check your compatibility with unlimited"
                                                  " partners and initiate the proposal with confidence.",
                                              excludeFromSemantics: true,
                                              preferBelow: false,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 8),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
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
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 16, right: 16),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: TextView("Validity",
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.center,
                                          textScaleFactor: .8,
                                          color: Colors.white,
                                          size: 12),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: TextView(
                                        "${widget.statistics.validity} Days",
                                        size: 15,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.center,
                                        textScaleFactor: .8,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 16, right: 16),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: TextView(
                                        "Views",
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.center,
                                        textScaleFactor: .8,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: TextView(
                                        "NA*",
                                        size: 15,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.center,
                                        textScaleFactor: .8,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 1, left: 16, right: 16),
                                child: TextView(
                                  "*Once viewed would always be open to view again",
                                  size: 14,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 1, left: 16, right: 16),
                                child: TextView(
                                  GlobalData.myProfile.currentCsStatistics
                                              ?.expiredAt !=
                                          null
                                      ? "* Your current topup is expire on " +
                                          DateFormat.yMd().format(GlobalData
                                              .myProfile
                                              .currentCsStatistics
                                              ?.expiredAt)
                                      : GlobalData.myProfile.currentCsStatistics
                                                  ?.couplingScorePlanOption !=
                                              null
                                          ? '* Life time validity'
                                          : '',
                                  //GlobalData.myProfile?.currentCsStatistics?.expiredAt?.toString()??'',
                                  size: 14,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 80,
                                    width: 400,
                                    child: CustomPaint(
                                      painter: CurvePainter(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 35),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        TextView(
                                          "RS:${widget.statistics.activationFee}",
                                          size: 18,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.center,
                                          textScaleFactor: .8,
                                        ),
                                        CustomButton(
                                            enabled: GlobalData
                                                        .myProfile
                                                        .currentCsStatistics
                                                        ?.expiredAt ==
                                                    null &&
                                                GlobalData
                                                        .myProfile
                                                        .currentCsStatistics
                                                        ?.couplingScorePlanOption ==
                                                    null,
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
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.visible,
                                                textAlign: TextAlign.center,
                                                textScaleFactor: .8,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () {
                                              PaymentBottomSheet()
                                                  .paymentBottomSheet(
                                                      context: context,
                                                      isCouplingPlan: true,
                                                      profileResponse: widget
                                                          .profileResponse,
                                                      couplingScore:
                                                          widget.statistics,
                                                      topUpPlan: null);
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 210,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: PlanCards(
                          offerCard: <Widget>[
                            buildOfferCard(widget.plan.profilesCount.toString(),
                                "Contact Views & Chat Credit"),
                            buildOfferCard(widget.plan.validity,
                                "Days Expiry Of  Contact/Chat Credits"),
                            buildOfferCard(widget.plan.csStatistics.toString(),
                                "Free Coupling Score Predictions Credit"),
                          ],
                          cardColor: CoupledTheme().inactiveColor,
                          planName: "${widget.plan.planName} Membership",
                          planPrice: widget.plan.amount,
                          backgroundImg: widget.backgroundImg,
                          headerSize: 18.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 20),
                      child: PlanDetailsCard(
                        color: CoupledTheme().planCardBackground,
                        planDetails: widget.featuresItemsList,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            topUpBottomSheet(context);
                          },
                          child: TextView(
                            "Top Up Plans",
                            size: 15,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: CustomButton(
                      borderRadius: BorderRadius.circular(0),
                      width: MediaQuery.of(context).size.width,
                      // color: CoupledTheme().primaryPink,
                      child: Center(
                        heightFactor: 1.8,
                        child: TextView(
                          "Become ${widget.plan.planName} Member",
                          size: 20,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        PaymentBottomSheet().paymentBottomSheet(
                            context: context,
                            plan: widget.plan,
                            couplingScore: widget.statistics,
                            profileResponse: widget.profileResponse);
                      })),
            ],
          );
  }

  void topUpBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 35,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: TextView(
                            "Top Up Plans (Rs)",
                            color: Colors.black,
                            textAlign: TextAlign.center,
                            size: 15,
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
                            color: Colors.black,
                            textAlign: TextAlign.center,
                            size: 15,
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
                            color: Colors.black,
                            textAlign: TextAlign.center,
                            size: 15,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                            textScaleFactor: .8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.topList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              print(widget.topList[index].topup);
                            },
                            child: TopUpPlanListItem(
                              topUpPlans: widget.topList[index],
                              state: index,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.24);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.27,
        size.width * 0.5, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.78, size.height * 0.3,
        size.width * 1.0, size.height * 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

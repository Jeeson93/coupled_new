import 'package:coupled/PlansAndPayment/PaymentGateWay/PaymentGateWay.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentBottomSheet {
  void paymentBottomSheet(
      {context,
      required CouplingScoreStatistics couplingScore,
      dynamic plan,
      required ProfileResponse profileResponse,
      dynamic topUpPlan,
      bool isCouplingPlan = false}) {
    final GlobalKey toolKey = GlobalKey();
    bool _isChecked = false;
    showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        context: context,
        builder: (builder) {
          int planPrice = plan != null ? int.parse(plan.amount) : 0;
          int topUpPrice =
              topUpPlan != null ? int.parse(topUpPlan.topup.amount) : 0;
          int couplingScorePrice = couplingScore != null
              ? int.parse(couplingScore.activationFee)
              : 0;
          int total = (planPrice + topUpPrice + couplingScorePrice);
          return StatefulBuilder(
            builder: (context, state) {
              return Container(
                height: isCouplingPlan ? 180 : 280,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextView(
                          "Payment Details",
                          color: Colors.black,
                          size: 18,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: TextView(
                                isCouplingPlan
                                    ? 'Coupling Score Activation'
                                    : plan != null
                                        ? ' ${plan.planName} Membership'
                                        : 'Top Up',
                                color: Colors.black,
                                size: 14,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextView(
                              isCouplingPlan
                                  ? "Rs: ${couplingScore.activationFee}"
                                  : "Rs: ${plan != null ? plan.amount : topUpPlan.topup.amount}",
                              color: CoupledTheme().primaryPinkDark,
                              size: 18,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              textScaleFactor: .8,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Visibility(
                        visible: !isCouplingPlan,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 8,
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      CustomCheckBox(
                                        value: _isChecked,
                                        onChanged: (value) {
                                          state(
                                            () {
                                              _isChecked = value!;
                                            },
                                          );
                                        },
                                        secondary: SizedBox(),
//                                            text: widget.plan,
                                      ),
                                      TextView(
                                        "Activate Coupling Score Predictions ",
                                        color: Colors.black,
                                        size: 14,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.center,
                                        textScaleFactor: .8,
                                      ),
                                      TooltipTheme(
                                        data: TooltipThemeData(
                                            textStyle:
                                                TextStyle(color: Colors.black)),
                                        child: Tooltip(
                                          key: toolKey,
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
                                                  toolKey.currentState;
                                              tooltip.ensureTooltipVisible();
                                            },
                                            child: Icon(
                                              Icons.info,
                                              color: CoupledTheme().primaryBlue,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextView(
                                    "Rs: ${couplingScore.activationFee}",
                                    color: CoupledTheme().primaryPinkDark,
                                    size: 18,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: .8,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 28),
                              child: TextView(
                                "(${couplingScore.validity} Days validity)",
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                                size: 12,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: TextView(
                                      "Total",
                                      color: CoupledTheme().primaryPinkDark,
                                      size: 20,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextView(
                                    _isChecked
                                        ? "Rs: ${total.toString()}"
                                        : "Rs: ${plan != null ? plan.amount : topUpPlan != null ? topUpPlan.topup.amount : 0}",
                                    color: CoupledTheme().primaryPinkDark,
                                    size: 18,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: .8,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => PaymentGateWay(
                                  plan: plan,
                                  profileResponse: profileResponse,
                                  couplingScore: isCouplingPlan
                                      ? couplingScore
                                      : _isChecked
                                          ? couplingScore
                                          : null,
                                  topUpPlan: topUpPlan,
                                ),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(2.0),
                          gradient: LinearGradient(colors: [
                            CoupledTheme().primaryPinkDark,
                            CoupledTheme().primaryPink
                          ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: TextView(
                              "Proceed",
                              size: 16,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              textScaleFactor: .8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}

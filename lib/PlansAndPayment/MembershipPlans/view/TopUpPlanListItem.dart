import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:flutter/material.dart';

class TopUpPlanListItem extends StatelessWidget {
  final int state;
  final PlanTopup topUpPlans;

  TopUpPlanListItem({this.state = 0, required this.topUpPlans});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      color: state % 2 == 0
          ? CoupledTheme().ashSelectedColor
          : CoupledTheme().ashUnSelectedColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: TextView(
                topUpPlans.topup!.amount.toString(),
                color: Colors.black,
                textAlign: TextAlign.center,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.visible,
                textScaleFactor: .8,
                size: 12,
              )),
          Expanded(
              flex: 1,
              child: TextView(topUpPlans.topup!.validity.toString(),
                  color: Colors.black,
                  textAlign: TextAlign.center,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible,
                  textScaleFactor: .8,
                  size: 12)),
          Expanded(
              flex: 1,
              child: TextView(topUpPlans.profiles.toString(),
                  color: Colors.black,
                  textAlign: TextAlign.center,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible,
                  textScaleFactor: .8,
                  size: 12)),
        ],
      ),
    );
  }
}

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:flutter/material.dart';

class TopUpPlanListItem2 extends StatefulWidget {
  final int state;
  final PlanTopup? topUpPlans;
  final ValueChanged<bool?> onChange;
  final bool value;

  TopUpPlanListItem2(
      {required this.topUpPlans,
      this.state = 0,
      this.value = false,
      required this.onChange});

  @override
  _TopUpPlanListItem2State createState() => _TopUpPlanListItem2State();
}

class _TopUpPlanListItem2State extends State<TopUpPlanListItem2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      color: widget.state % 2 == 0
          ? CoupledTheme().ashSelectedColor
          : CoupledTheme().backgroundHighlight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomCheckBox(
                  value: widget.value,
                  onChanged: widget.onChange,
                  text: widget.topUpPlans?.topup?.amount.toString() ?? '0',
                  secondary: SizedBox(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: TextView(
              widget.topUpPlans?.topup?.validity.toString() ?? '00',
              textAlign: TextAlign.center,
              color: Colors.white,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              textScaleFactor: .8,
              size: 12,
            ),
          ),
          Expanded(
            flex: 1,
            child: TextView(
              widget.topUpPlans?.profiles.toString() ?? '00',
              textAlign: TextAlign.center,
              color: Colors.white,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              textScaleFactor: .8,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }
}

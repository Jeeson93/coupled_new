import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:date_format/date_format.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:flutter/material.dart';

///my plans progress card widget
class ProgressBarCard extends StatelessWidget {
  final int availableCredit;
  final int totalCredit;
  final String title;
  final String totalAmount;
  final double opacity;
  final dynamic startDate;
  final dynamic expireDate;
  final bool otherPlanVisible;
  final bool isInfinity;

  ProgressBarCard(
      {this.availableCredit = 1,
      this.totalCredit = 1,
      this.title = '',
      this.totalAmount = '',
      this.startDate,
      this.expireDate,
      this.otherPlanVisible = false,
      this.isInfinity = false,
      this.opacity = 1});

  final GlobalKey toolKey1 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Stack(
              alignment: Alignment(0, 0),
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.22,
                  width: MediaQuery.of(context).size.width * 0.22,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.21),
                      color: CoupledTheme().backgroundColor,
                    ),
                    child: CircularProgressIndicator(
                      strokeWidth: 4.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          CoupledTheme().primaryPink),
                      backgroundColor: CoupledTheme().cardBackgroundColor,
                      value: totalCredit != 0
                          ? (((availableCredit * 100) / totalCredit) / 100)
                          : 0,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    TextView(
                      isInfinity ? "∞" : availableCredit.toString(),
                      color: CoupledTheme().primaryBlue,
                      size: 24,
                      textAlign: TextAlign.center,
                      decoration: TextDecoration.none,
                      overflow: TextOverflow.visible,
                      fontWeight: FontWeight.normal,
                      textScaleFactor: .8,
                    ),
                    RichText(
                        text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: TextView(
                          isInfinity ? "Unlimited" : 'out of ',
                          color: Colors.white,
                          size: 12,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                          overflow: TextOverflow.visible,
                          textScaleFactor: .8,
                        )),
                        WidgetSpan(
                            child: TextView(
                          !isInfinity ? '$totalCredit' : '',
                          color: Colors.white,
                          size: 12,
                          textAlign: TextAlign.center,
                          decoration: TextDecoration.none,
                          overflow: TextOverflow.visible,
                          fontWeight: FontWeight.normal,
                          textScaleFactor: .8,
                        )),
                      ],
                    )),

                    /* TextView(
                      isInfinity ? "Unlimited" : 'out of $totalCredit',
                      color: Colors.white,
                      size: 12,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.normal,
                    ),*/
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
              child: Column(
            children: <Widget>[
              TextView(
                title,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
                overflow: TextOverflow.visible,
                color: Colors.white,
                textScaleFactor: .8,
                size: 12,
                maxLines: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Visibility(
                visible: otherPlanVisible,
                child: TextView(
                  totalAmount,
                  textAlign: TextAlign.center,
                  size: 22,
                  color: CoupledTheme().primaryBlue,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                  overflow: TextOverflow.visible,
                  textScaleFactor: .9,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Visibility(
                visible: otherPlanVisible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextView(
                      "Start date\n${startDate != null ? formatDate(startDate, [
                              dd,
                              '.',
                              mm,
                              '.',
                              yy
                            ]) : 'NA'}",
                      fontWeight: FontWeight.normal,
                      size: 12,
                      decoration: TextDecoration.none,
                      overflow: TextOverflow.visible,
                      color: Colors.white,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                      maxLines: 2,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: TextView(
                              expireDate == 'lifetime'
                                  ? 'Lifetime '
                                  : "Expiry date\n${expireDate != null ? formatDate(expireDate, [
                                          dd,
                                          '.',
                                          mm,
                                          '.',
                                          yy
                                        ]) : 'NA'}",
                              fontWeight: FontWeight.normal,
                              size: 12,
                              decoration: TextDecoration.none,
                              overflow: TextOverflow.visible,
                              color: Colors.white,
                              textAlign: TextAlign.center,
                              textScaleFactor: .8,
                              maxLines: 2,
                            ),
                          ),
                          WidgetSpan(
                            child: TooltipTheme(
                              data: TooltipThemeData(
                                  textStyle: TextStyle(
                                color: Colors.white,
                              )),
                              child: Tooltip(
                                key: toolKey1,
                                message: CoupledStrings.lifeTimeValidity,
                                excludeFromSemantics: true,
                                preferBelow: false,
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    final dynamic tooltip =
                                        toolKey1.currentState;
                                    tooltip.ensureTooltipVisible();
                                  },
                                  child: expireDate == 'lifetime'
                                      ? Container(
                                          height: 15,
                                          width: 15,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    CoupledTheme().primaryBlue),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Image.asset(
                                                  "assets/PlansAndPayment/information-variant.png",
                                                  height: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}

import 'package:coupled/MatchMaker/match_maker_provider.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/match_maker_model.dart';
import 'package:flutter/material.dart';

class CouplingScore extends StatefulWidget {
  const CouplingScore({Key? key}) : super(key: key);

  @override
  _CouplingScoreState createState() => _CouplingScoreState();
}

class _CouplingScoreState extends State<CouplingScore> {
  // double scoreMax = 0.0, scoreMin = 0.0;
  bool isChecked = false;
  dynamic matchMakerModel;

  @override
  void didChangeDependencies() {
    matchMakerModel = MatchMakerProvider.of(context)!.matchMakerModel;
    if (matchMakerModel != null) {
      isChecked = true;
      print("scoreMax : ${matchMakerModel.maxScore} "
          "scoreMin : ${matchMakerModel.minScore}");
      // scoreMax = matchMakerModel.maxScore?.floorToDouble();
      // scoreMin = matchMakerModel.minScore?.floorToDouble();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: CoupledTheme()
          .coupledTheme2()
          .copyWith(unselectedWidgetColor: Colors.white),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomCheckBox(
                    value: true,
                    text: "Score",
                    textSize: 18.0,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    secondary: SizedBox(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    child: TextView(
                        "${matchMakerModel.minScore == 0 ? 80 : matchMakerModel.minScore} - ${matchMakerModel.maxScore == 0 ? 100 : matchMakerModel.maxScore} %",
                        size: 18.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              RangeSlider(
                values: RangeValues(
                    matchMakerModel.minScore.floorToDouble() == 0.0
                        ? 80.0
                        : matchMakerModel.minScore.floorToDouble(),
                    matchMakerModel.maxScore.floorToDouble() == 0.0
                        ? 100.0
                        : matchMakerModel.maxScore.floorToDouble()),
                min: 0.0,
                max: 100.0,
                activeColor: Colors.white,
                inactiveColor: CoupledTheme().primaryPinkDark,
                labels: RangeLabels(
                    "${matchMakerModel.minScore == 0 ? 80 : matchMakerModel.minScore}",
                    "${matchMakerModel.maxScore == 0 ? 100 : matchMakerModel.maxScore}"),
                onChanged: (_value) {
                  setState(
                    () {
                      isChecked = true;
                      matchMakerModel.minScore = _value.start.round();
                      matchMakerModel.maxScore = _value.end.round();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

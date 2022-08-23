import 'package:coupled/MatchMaker/match_maker_page.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/match_maker_model.dart';
import 'package:flutter/material.dart';

class ActivenessOnSite extends StatefulWidget {
  final MatchMakerModel matchMakerModel;

  ActivenessOnSite({required this.matchMakerModel});

  @override
  _ActivenessOnSiteState createState() => _ActivenessOnSiteState();
}

class _ActivenessOnSiteState extends State<ActivenessOnSite> {
  List<WrapItem> items = [
    WrapItem(isSelected: false, title: "Active now"),
    WrapItem(isSelected: false, title: "Within - 3 Days"),
    WrapItem(isSelected: false, title: "Within - 7 Days"),
    WrapItem(isSelected: false, title: "Within - 30 Days"),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: CoupledTheme()
          .coupledTheme2()
          .copyWith(unselectedWidgetColor: Colors.white),
      child: Scaffold(
        backgroundColor: CoupledTheme().backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemExtent: 50.0,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return CustomCheckBox(
                        value: items[index].isSelected,
                        text: items[index].title,
                        textSize: 14.0,
                        onChanged: (value) {
                          setState(() {
                            for (int i = 0; i < items.length; i++) {
                              items[i].isSelected = false;
                            }

                            ///ToDo activeness
                            print("ITEMS ::: ${items[index]}");
                            widget.matchMakerModel.active = 3;
                            items[index].isSelected = true;
                            print("ACTIVE :: ${widget.matchMakerModel.active}");
                          });
                        },
                        secondary: SizedBox(),
                      );
                    }),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

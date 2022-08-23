import 'package:coupled/Utils/coupled_strings.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:flutter/material.dart';

class AboutNewCoupled extends StatefulWidget {
  @override
  _AboutNewCoupledState createState() => _AboutNewCoupledState();
}

class _AboutNewCoupledState extends State<AboutNewCoupled> {
  late UniqueKey keyTile;
  bool isExpanded = false;

  void expandTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      isExpanded = false;
      keyTile = UniqueKey();
    });
  }

  @override
  void initState() {
    super.initState();
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
                "About Coupled",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 3,
            ),
            Card(
              color: CoupledTheme().planCardBackground,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.white..withOpacity(0.8),
                    accentColor: Colors.white..withOpacity(0.8),
                  ),
                  child: ExpansionTile(
                    key: keyTile,
                    initiallyExpanded: isExpanded,
                    childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
                    title: TextView(
                      "About Us",
                      size: 21,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    ),
                    children: [
                      TextView(
                        CoupledStrings.cmsAboutUs,
                        size: 15,
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
            ),
            SizedBox(
              height: 3,
            ),
            Card(
              color: CoupledTheme().planCardBackground,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.white..withOpacity(0.8),
                    accentColor: Colors.white..withOpacity(0.8),
                  ),
                  child: ExpansionTile(
                    key: keyTile,
                    initiallyExpanded: isExpanded,
                    childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
                    title: TextView(
                      "Refund Policy",
                      size: 21,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    ),
                    children: [
                      TextView(
                        CoupledStrings.cmsrefund,
                        size: 15,
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
            )
          ],
        ),
      ),
    );
  }
}

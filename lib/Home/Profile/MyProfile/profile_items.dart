import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileItems extends StatefulWidget {
  final String img, title;
  final bool editIcon;
  final Widget card;
  final GestureTapCallback onTap;

  ProfileItems({
    this.img = "",
    required this.card,
    this.editIcon = true,
    this.title = "",
    required this.onTap,
  });

  @override
  _ProfileItemsState createState() => _ProfileItemsState();
}

class _ProfileItemsState extends State<ProfileItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        defaultColumnWidth: FractionColumnWidth(.27),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        columnWidths: {
          0: FractionColumnWidth(0.07),
          1: FractionColumnWidth(0.83),
          2: FractionColumnWidth(widget.editIcon ? 0.1 : 0.00)
        },
        children: [
          TableRow(
            children: <Widget>[
              TableCell(
                child: Visibility(
                    visible: widget.img.length <= 0 ? false : true,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Image.asset(widget.img,
                          height: CoupledTheme().smallIcon),
                    )),
              ),
              TableCell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                      visible: widget.title.length <= 0 ? false : true,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, left: 5),
                        child: TextView(
                          widget.title,
                          size: 16,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    widget.card,
                  ],
                ),
              ),
              Visibility(
                visible: widget.editIcon ? true : false,
                child: TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: GestureDetector(
                      onTap: widget.onTap,
                      child: Image.asset("assets/Profile/Edit-.png",
                          height: CoupledTheme().smallIcon),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:flutter/material.dart';

class SubCatModal extends StatefulWidget {
  final dynamic buildWidget;
  final dynamic listItem;
  final bool multipleChoice;
  final dynamic onValueChange;
  SubCatModal(
      {Key? key,
      this.buildWidget,
      this.listItem,
      this.onValueChange,
      this.multipleChoice = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SubCatModalState();
}

class _SubCatModalState extends State<SubCatModal> {
  List<BaseSettings> duplicateItems = <BaseSettings>[];
  bool onSearch = false;
  TextEditingController editingController = TextEditingController();

  List selectedItems = [];

  void filterSearchResults(String query) {
    List<BaseSettings> dummySearchList = <BaseSettings>[];
    dummySearchList.addAll(widget.listItem);
    if (query.isNotEmpty) {
      List<BaseSettings> dummyListData = <BaseSettings>[];
      dummySearchList.forEach((item) {
//        if (item.subItem.length > 0) {
        item.options!.forEach((subItem) {
          if (subItem.value.toLowerCase().contains(query.toLowerCase())) {
            dummyListData
                .add(BaseSettings(value: item.value, options: [subItem]));
          }
        });
        /* } else {
          if (item.title.toLowerCase().contains(query.toLowerCase())) {
            dummyListData.add(item);
          }
        }*/
      });
      setState(() {
        duplicateItems.clear();
        duplicateItems.addAll(dummyListData);
      });
    } else {
      setState(() {
        duplicateItems.clear();
        duplicateItems.addAll(widget.listItem);
      });
    }
    print("duplicateItems ${duplicateItems.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        /* Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  flex: 1,
                  child: Icon(Icons.search, size: 20.0, color: Colors.black)),
              Flexible(
                flex: 3,
                child: EditText(
                  hint: "Search",
                  textColor: Colors.black,
                  hintColor: Colors.black,
                  textAlign: TextAlign.start,
                  border: true,
                  customBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  onChange: (value) {
                    filterSearchResults(value);
                    onSearch = value.isNotEmpty;
                  },
                  controller: editingController,
                ),
              ),
            ],
          ),
        ),*/
        !onSearch
            ? widget.buildWidget
            : ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: duplicateItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Column(
                      children: List.generate(
                          duplicateItems[index].options!.length, (generator) {
                        return Row(
                          children: <Widget>[
                            Container(
                                child: InkWell(
                              onTap: () {
                                setState(() {
                                  widget.onValueChange(duplicateItems[index]);
                                  Navigator.pop(context);
                                });
                              },
                              child: TextView(
                                duplicateItems[index].options![generator].value,
                                size: 16.0,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                              ),
                            ) /*CustomCheckBox(
                                value: duplicateItems[index]
                                    .subItem[generator]
                                    .isSelected,
                                text: duplicateItems[index]
                                    .subItem[generator]
                                    .title,
                                textColor: Colors.black,
                                onChanged: (isSelected) {
                                  setState(() {
                                    if (!widget.multipleChoice) {
                                      duplicateItems.forEach((item) {
                                        item.subItem.forEach((subItem) {
                                          subItem.isSelected = false;
                                        });
                                      });
                                      selectedItems =  List<BaseSettings>();
//    widget.getPreviousItems( List<BaseSettings>());
                                    }
                                    duplicateItems[index]
                                        .subItem[generator]
                                        .isSelected = isSelected;

                                    if (isSelected) {
                                      selectedItems.add(duplicateItems[index]);
                                    } else {
                                      selectedItems
                                          .remove(duplicateItems[index]);
                                    }
                                    print(
                                        "selectedItems length : ${selectedItems.length}");
//    widget.getPreviousItems(selectedItems);
                                    widget.onValueChange(selectedItems);
                                  });
                                },
                              ),*/
                                ),
                          ],
                        );
                      }),
                    ),
                  );
                },
              ),
      ],
    );
  }
}

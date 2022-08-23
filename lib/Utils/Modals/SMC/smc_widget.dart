import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:flutter/material.dart';

class SMCWidget<T> extends StatefulWidget {
  final title;

  ///It will divide the children according to parent name.
  ///default is false.
  ///To set parent name give the name in [Item.code]
  final bool parentTitle;
  final List<Item> items;
  final bool multipleChoice;
  final Widget errorWidget;
  final Function(bool isChecked, dynamic item) selectedItem;

  ///SMCList = Single Multiple Choice List.
  SMCWidget({
    Key? key,
    this.title,
    this.items = const <Item>[],
    required this.selectedItem,
    this.multipleChoice = false,
    required this.errorWidget,
    this.parentTitle = false,
  }) : super(key: key);

  @override
  _SMCWidgetState createState() => _SMCWidgetState();
}

class _SMCWidgetState extends State<SMCWidget> {
  PageController pageController = PageController(initialPage: 1);
  TextEditingController editingController = TextEditingController();
  List<Item> duplicateItems = [];
  List<ExpansionItem> expansionItems = [];

  void filterSearchResults(String query) {
    List<Item> dummySearchList = <Item>[];
    dummySearchList.addAll(widget.items);
    if (query.isNotEmpty) {
      List<Item> dummyListData = <Item>[];
      dummySearchList.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        duplicateItems.clear();
        duplicateItems.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        duplicateItems.clear();
        duplicateItems.addAll(widget.items);
        print("items $duplicateItems");
      });
    }
  }

  @override
  void initState() {
    duplicateItems.addAll(widget.items);
    expansionItems =
        (widget.parentTitle ? expansionListItems(duplicateItems) : []);
    editingController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String parentName = "";
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 10.0, bottom: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextView(
              widget.title,
              color: Colors.black,
              textAlign: TextAlign.start,
              size: 18.0,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
              textScaleFactor: .8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                      flex: 1,
                      child:
                          Icon(Icons.search, size: 20.0, color: Colors.black)),
                  Flexible(
                    flex: 3,
                    child: SizedBox(
                      height: 38,
                      child: EditText(
                        hint: "Search",
                        textColor: Colors.black,
                        hintColor: Colors.black,
                        textAlign: TextAlign.start,
                        border: true,
                        customBorder: UnderlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                        onChange: (value) {
                          filterSearchResults(value);
                        },
                        controller: editingController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView(
              shrinkWrap: true,
              children: List<Widget>.generate(duplicateItems.length, (index) {
                Widget title = Container();
                if (parentName != duplicateItems[index].code) {
                  parentName = duplicateItems[index].code;
                  title = ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                    title: TextView(
                      parentName,
                      size: 18.0,
                      color: Colors.blue,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .9,
                    ),
                  );
                }
                return ListTile(
                  dense: true,
                  title: widget.parentTitle ? title : null,
                  contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  subtitle: CustomCheckBox(
                    disableTheme: true,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    text: duplicateItems[index].name,
                    textColor: Colors.black,
                    value: duplicateItems[index].isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (!widget.multipleChoice) {
                          print("DUPLICATE : $duplicateItems");
                          duplicateItems
                              .singleWhere((item) => item.isSelected == true,
                                  orElse: () => Item())
                              .isSelected = false;
                          widget.items
                              .singleWhere((item) => item.isSelected == true,
                                  orElse: () => Item())
                              .isSelected = false;
                        }
                        widget.selectedItem(value!, duplicateItems[index]);
                      });
                    },
                    secondary: SizedBox(),
                  ),
                );
              }),
            )),
          ],
        ),
      ),
    );
  }

  List<ExpansionItem> expansionListItems(List<Item> duplicateItems) {
    String parentName = "";
    List<ExpansionItem> expansionItems = [];
    int i = 0;
    List.generate(duplicateItems.length, (index) {
      if (parentName != duplicateItems[index].code) {
        parentName = duplicateItems[index].code;
        expansionItems.add(
            ExpansionItem(duplicateItems[index].code, [duplicateItems[index]]));
        i = parentName.isEmpty ? 0 : i++;
      } else {
        expansionItems[i].childItem.add(duplicateItems[index]);
      }
    });
    return expansionItems;
  }
}

class ExpansionItem {
  String parentTitle;
  List<Item> childItem;

  ExpansionItem(this.parentTitle, this.childItem);
}

class Item {
  String id, code, name, type;
  var parentId;

  bool isSelected = false;

  ///Any extra data you want to get when tapped on children
  dynamic extras;

  Item(
      {this.id = '',
      this.code = '',
      this.parentId = '',
      this.name = '',
      this.type = '',
      this.extras});

  List<Item> convertToItem(
      {required List<BaseSettings>? baseSettings, dynamic parentName}) {
    List<Item> items = [];
    baseSettings!.forEach((f) {
      if (f.value.toLowerCase() != "no caste")
        items.add(Item(
            id: f.id.toString(),
            code: parentName != null ? parentName.name : f.others,
            name: f.value,
            parentId: parentName != null ? parentName.id : '0'));
    });
    return items;
  }

  @override
  String toString() {
    return 'Item{id: $id, code: $code, name: $name, type: $type, parentId: $parentId, isSelected: $isSelected, extras: $extras}';
  }
}

///This is what i work in expansion list.. it takes time to expand the [ExpansionTile] if the list is too long
/*
    ListView.builder(
                    itemCount: expansionItems != null ? expansionItems.length : duplicateItems.length,
                    itemBuilder: (context, index) {
                      return expansionItems != null
                          ? ExpansionTile(
                              title: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                                title: TextView(
                                  expansionItems[index].parentTitle,
                                  size: 18.0,
                                  color: Colors.blue,
                                ),
                              ),
                              children: List<Widget>.generate(expansionItems[index].childItem.length, (i) {
                                return ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                                  subtitle: CustomCheckBox(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    text: expansionItems[index].childItem[i].name,
                                    textColor: Colors.black,
                                    value: expansionItems[index].childItem[i].isSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        if (!widget.multipleChoice) {
                                          print("DUPLICATE : ${expansionItems[index].childItem}");
                                          expansionItems[index]
                                              .childItem
                                              .singleWhere((item) => item.isSelected == true,
                                                  orElse: () => null)
                                              ?.isSelected = false;
                                          widget.items
                                              .singleWhere((item) => item.isSelected == true,
                                                  orElse: () => null)
                                              ?.isSelected = false;
                                        }
                                        widget.selectedItem(value, expansionItems[index].childItem[i]);
                                      });
                                    },
                                  ),
                                );
                              }),
                            )
                          : ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                              subtitle: CustomCheckBox(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                text: duplicateItems[index].name,
                                textColor: Colors.black,
                                value: duplicateItems[index].isSelected,
                                onChanged: (value) {
                                  setState(() {
                                    if (!widget.multipleChoice) {
                                      print("DUPLICATE : $duplicateItems");
                                      duplicateItems
                                          .singleWhere((item) => item.isSelected == true, orElse: () => null)
                                          ?.isSelected = false;
                                      widget.items
                                          .singleWhere((item) => item.isSelected == true, orElse: () => null)
                                          ?.isSelected = false;
                                    }
                                    widget.selectedItem(value, duplicateItems[index]);
                                  });
                                },
                              ),
                            );
                    },
                    shrinkWrap: true,
                  ),*/

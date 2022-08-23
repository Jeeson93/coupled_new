import 'package:coupled/TOL/Bloc/tol_list_bloc_bloc.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/tol_list_model.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

buildAppbar(BuildContext context) {
  return AppBar(
    backgroundColor: CoupledTheme().backgroundColor,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              'Token of Love',
              size: 20,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
              color: Colors.white,
            ),
            /* TextView(
              '${GlobalData?.chatResponse?.partner?.name ?? ''}',
              size: 14,
              color: CoupledTheme().primaryPink,
            ),*/
          ],
        ),
      ],
    ),
  );
}

///tol home sort category bar
Widget topBar(BuildContext context, TolListBlocBloc tolListBlocBloc) {
  BaseSettings productCategory =
      GlobalData().getBaseSettingsType(baseType: 'product_category');
  BaseSettings productSort =
      GlobalData().getBaseSettingsType(baseType: 'tol_product_sort');
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: GestureDetector(
            onTap: () {
              getCategoryBottomSheet(context, productCategory, tolListBlocBloc);
            },
            child: Container(
              height: 35,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white60)),
              child: Center(
                child: TextView(
                  GlobalData.selectedCategory.value,
                  color: GlobalData.selectedCategory.value != 'Category'
                      ? CoupledTheme().primaryBlue
                      : Colors.white,
                  size: 16,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
              height: 35,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.white60),
                      right: BorderSide(color: Colors.white60),
                      bottom: BorderSide(color: Colors.white60))),
              child: GestureDetector(
                onTap: () {
                  getSortBottomSheet(context, productSort, tolListBlocBloc);
                },
                child: Center(
                    child: TextView(
                  GlobalData.selectedSort.value,
                  color: GlobalData.selectedSort.value != 'Sort'
                      ? CoupledTheme().primaryBlue
                      : Colors.white,
                  size: 16,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                )),
              )),
        ),
      ],
    ),
  );
}

///tol sort by category bottom sheet
void getCategoryBottomSheet(
  BuildContext context,
  BaseSettings productCategory,
  TolListBlocBloc tolListBlocBloc,
) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (builder) {
        return Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    GlobalData.selectedCategory =
                        BaseSettings(value: 'Category', options: []);
                    productCategory.options!.forEach((element1) => element1
                        .options!
                        .forEach((element) => element.isSelected = false));
                    tolListBlocBloc.add(TolListLoadEvent());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: TextView(
                      'Clear All',
                      color: Colors.black,
                      size: 16,
                      decoration: TextDecoration.underline,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    ),
                  ),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productCategory.options!.length,
                    itemBuilder: (context, index) {
                      List<Widget> subItems = [];
                      productCategory.options![index].options!.forEach((f) {
                        subItems.add(Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: GestureDetector(
                              onTap: () {
                                productCategory.options!.forEach((element1) =>
                                    element1.options!.forEach((element) =>
                                        element.isSelected = false));
                                Navigator.of(context).pop();
                                f.isSelected = true;
                                GlobalData.selectedCategory =
                                    productCategory.options![index];
                                tolListBlocBloc.add(TolListLoadEvent());
                              },
                              child: Container(
                                height: 35,
                                child: TextView(
                                  f.value,
                                  textAlign: TextAlign.left,
                                  color: f.isSelected
                                      ? CoupledTheme().primaryBlue
                                      : Colors.black,
                                  size: 18,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  textScaleFactor: .8,
                                ),
                              ),
                            ),
                          ),
                        ));
                      });
                      return ExpansionTile(
                        title: TextView(
                          productCategory.options![index].value,
                          color: Colors.black,
                          size: 20,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                        ),
                        children: subItems,
                      );
                    }),
              ],
            ),
          ),
        );
      });
}

///tol sort by price bottom sheet
void getSortBottomSheet(BuildContext context, BaseSettings productSort,
    TolListBlocBloc tolListBlocBloc) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (builder) {
        return Container(
          child: ListView.builder(
              itemCount: productSort.options!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    productSort.options!
                        .forEach((element) => element.isSelected = false);
                    productSort.options![index].isSelected = true;
                    Navigator.of(context).pop();
                    GlobalData.selectedSort = productSort.options![index];
                    tolListBlocBloc.add(TolListLoadEvent());
                  },
                  title: TextView(
                    productSort.options![index].value,
                    color: productSort.options![index].isSelected
                        ? CoupledTheme().primaryBlue
                        : Colors.black,
                    size: 20,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                );
              }),
        );
      });
}

///add remove button

class QuantityButton extends StatefulWidget {
  final int index;

  const QuantityButton({Key? key, this.index = 0}) : super(key: key);

  @override
  _QuantityButtonState createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  TolProductDatum item = TolProductDatum();
  TolListBlocBloc tolListBlocBloc = TolListBlocBloc();

  @override
  void initState() {
    tolListBlocBloc = BlocProvider.of<TolListBlocBloc>(context);
    item = widget.index != null
        ? GlobalData?.tolProducts.response!.data![widget.index]
        : GlobalData.selectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CustomButton(
          enabled: item.quantity != 1,
          width: 25.0,
          height: 25.0,
          child: Icon(
            Icons.remove,
            color: Colors.white,
            size: 16,
          ),
          onPressed: () {
            tolListBlocBloc.add(TolChangeNotify());
            setState(() {
              if (item.quantity > 1 &&
                  item.stock >= item.quantity &&
                  3 >= item.quantity) item.quantity--;
            });
          },
          borderRadius: BorderRadius.circular(100),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
            height: 28,
            width: 35,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white60),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: TextView(
              '${item.quantity}',
              maxLines: 1,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
              color: Colors.white,
              overflow: TextOverflow.visible,
              size: 12,
            ))),
        SizedBox(
          width: 5,
        ),
        CustomButton(
          enabled: item.quantity != 3,
          width: 25.0,
          height: 25.0,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 16,
          ),
          onPressed: () {
            tolListBlocBloc.add(TolChangeNotify());
            setState(() {
              if (item.quantity >= 1 &&
                  item.stock > item.quantity &&
                  3 > item.quantity) item.quantity++;
            });
          },
          borderRadius: BorderRadius.circular(100),
        ),
      ],
    );
  }
}

///TOL ITEM
getDescription(
    {bool isList = false,
    String title = '',
    String description = '',
    List<String> features = const <String>[]}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: 10,
      ),
      TextView(
        title,
        color: CoupledTheme().primaryBlue,
        size: 18,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.left,
        textScaleFactor: .8,
      ),
      SizedBox(
        height: 5,
      ),
      isList
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: features.length,
              itemBuilder: (context, index) => TextView(
                    '• ${features[index]}',
                    maxLines: 100,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.left,
                    textScaleFactor: .8,
                    color: Colors.white,
                    overflow: TextOverflow.visible,
                    size: 14,
                    lineSpacing: 1.5,
                  ))
          : TextView(
              description,
              maxLines: 100,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.left,
              textScaleFactor: .8,
              color: Colors.white,
              overflow: TextOverflow.visible,
              size: 14,
            ),
      SizedBox(
        height: 5,
      ),
    ],
  );
}

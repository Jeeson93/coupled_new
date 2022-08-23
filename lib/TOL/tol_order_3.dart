import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/TOL/Bloc/tol_list_bloc_bloc.dart';
import 'package:coupled/TOL/tol_helpers.dart';
import 'package:coupled/TOL/tol_track_item_4.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/tol_order_history.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TolOrders extends StatefulWidget {
  @override
  _TolOrdersState createState() => _TolOrdersState();
}

class _TolOrdersState extends State<TolOrders> {
  TolListBlocBloc tolListBlocBloc = TolListBlocBloc();

  @override
  void initState() {
    tolListBlocBloc = BlocProvider.of<TolListBlocBloc>(context);
    tolListBlocBloc.add(TolListLoadHistory());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppbar(context),
        backgroundColor: CoupledTheme().backgroundColor,
        body: BlocBuilder(
          bloc: tolListBlocBloc,
          builder: (context, state) {
            if (state is InitialTolListBlocState)
              return Center(child: GlobalWidgets().showCircleProgress());
            if (state is TolErrorState)
              return Center(
                  child:
                      GlobalWidgets().errorState(message: state.errorMessage));

            return Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        GlobalData.tolOrderHistory.response?.data!.length ?? 0,
                    itemBuilder: (context, index) {
                      return trackItem(
                          GlobalData.tolOrderHistory.response!.data![index],
                          context);
                    }));
          },
        ));
  }
}

trackItem(TolOrderHistoryDatum item, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    child: Card(
      color: CoupledTheme().planCardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextView(
                    item.item!.product!.name,
                    color: CoupledTheme().primaryBlue,
                    size: 22,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextView(
                    '${CoupledStrings.INR} ${item.price}',
                    color: CoupledTheme().primaryPink,
                    size: 24,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      /*  Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: CoupledTheme().greenOnline,
                            shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 5,
                      ),*/
                      RichText(
                          text: TextSpan(children: [
                        WidgetSpan(
                            child: TextView(
                          '${item.histories![item.histories!.length - 1].orderStatus} ',
                          size: 18,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                          color: Colors.white,
                        )),
                        WidgetSpan(
                            child: TextView(
                          '(${formatDate(item.histories![item.histories!.length - 1].updatedAt, [
                                dd,
                                '.',
                                mm,
                                '.',
                                yyyy
                              ])})',
                          size: 14,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                          color: Colors.white,
                        ))
                      ])),
                    ],
                  ),
                ],
              )),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 90,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        clipBehavior: Clip.antiAlias,
                        elevation: 3.0,
                        child: Stack(
                          children: <Widget>[
                            FadeInImage.assetNetwork(
                              width: MediaQuery.of(context).size.width,
                              height:
                                  (72 * MediaQuery.of(context).size.height) /
                                      100,
                              fit: BoxFit.cover,
                              placeholder: 'assets/no_image.jpg',
                              image: APis().imageApi(
                                  item.item!.product!.image!.imageName,
                                  imageFolder: ImageFolder.TOL),
                            ),
                          ],
                        )),
                  ),
                  CustomButton(
                      height: 24.0,
                      width: 60.0,
                      borderRadius: BorderRadius.circular(0),
                      child: TextView(
                        'Track',
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                        color: Colors.white,
                        overflow: TextOverflow.visible,
                        size: 12,
                      ),
                      onPressed: () {
                        GlobalData.tolTrackOrderNumber = item.orderNumber;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TolTrackItem(
                                price: item.item!.price,
                                quantity: item.item!.quantity,
                                tax: item.tax,
                                shippingfee: item.shippingFee,
                                totalprice: item.item!.totalPrice),
                          ),
                        );
                      })
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

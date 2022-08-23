import 'package:coupled/PlansAndPayment/PaymentGateWay/PaymentGateWay.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/TOL/Bloc/tol_list_bloc_bloc.dart';
import 'package:coupled/TOL/tol_helpers.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/tol_list_model.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TolCheckOut extends StatefulWidget {
  @override
  _TolCheckOutState createState() => _TolCheckOutState();
}

class _TolCheckOutState extends State<TolCheckOut> {
  TolProductDatum item = TolProductDatum();
  var msgController = TextEditingController();
  TolListBlocBloc tolListBlocBloc = TolListBlocBloc();

  @override
  void initState() {
    tolListBlocBloc = BlocProvider.of(context);
    tolListBlocBloc.add(TolChangeNotify());
    item = GlobalData.selectedItem;
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
            if (state is TolChangeNotifyState) {
              print('TolGlobal.selectedItem--------$state');
              print(GlobalData.selectedItem);
            }
            if (state is TolErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: TextView(
                  state.errorMessage,
                  maxLines: 1,
                  decoration: TextDecoration.none,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                  overflow: TextOverflow.visible,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  size: 12,
                )));
              });
            }
            if (state is OrderCheckOutState) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentGateWay(
                              tolCheckOutItemModel: GlobalData.tolCheckout,
                            )));
              });
            }
            return Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextView(
                                      GlobalData.selectedItem.name,
                                      color: CoupledTheme().primaryBlue,
                                      size: 17,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      decoration: TextDecoration.none,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextView(
                                      GlobalData.selectedItem.productCode ?? '',
                                      size: 16,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      decoration: TextDecoration.none,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextView(
                                      '${CoupledStrings.INR} ${GlobalData.selectedItem.price}',
                                      color: CoupledTheme().primaryPink,
                                      size: 24,
                                      maxLines: 1,
                                      decoration: TextDecoration.none,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                      overflow: TextOverflow.visible,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    QuantityButton(),
                                  ],
                                )),
                              ),
                              Container(
                                width: 100,
                                height: 115,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    clipBehavior: Clip.antiAlias,
                                    elevation: 3.0,
                                    child: Stack(
                                      children: <Widget>[
                                        FadeInImage.assetNetwork(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: (72 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height) /
                                              100,
                                          fit: BoxFit.cover,
                                          placeholder: 'assets/no_image.jpg',
                                          image: APis().imageApi(
                                              GlobalData.selectedItem.image
                                                  ?.imageName,
                                              imageFolder: ImageFolder.TOL),
                                        ),
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.white38,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GetPriceSplit(),
                        Divider(
                          height: 1,
                          color: Colors.white38,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              TextView(
                                'Message',
                                color: CoupledTheme().primaryBlue,
                                size: 22,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                decoration: TextDecoration.none,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                                fontWeight: FontWeight.normal,
                              ),
                              TextView(
                                msgController.text.length < 320
                                    ? "${msgController.text.length}/320"
                                    : "320/320",
                                size: 16,
                                maxLines: 1,
                                decoration: TextDecoration.none,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                                overflow: TextOverflow.visible,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: EditTextBordered(
                            hint: "",
                            textInputAction: TextInputAction.newline,
                            controller: msgController,
                            maxLength: 320,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            onChange: (value) {
                              setState(() {
                                if (msgController.text.length > 320) {
                                  msgController.text = value;
                                } else {
                                  GlobalData.selectedItem.message =
                                      msgController.text;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    width: MediaQuery.of(context).size.width.toDouble(),
                    height: 45.0,
                    onPressed: () {
                      tolListBlocBloc.add(OrderCheckOut());
                    },
                    borderRadius: BorderRadius.circular(0),
                    gradient: LinearGradient(colors: [
                      CoupledTheme().primaryPinkDark,
                      CoupledTheme().primaryPink
                    ]),
                    child: TextView(
                      "Proceed",
                      size: 16,
                      maxLines: 1,
                      decoration: TextDecoration.none,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                      overflow: TextOverflow.visible,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}

///tol price split
class GetPriceSplit extends StatefulWidget {
  const GetPriceSplit({
    Key? key,
  }) : super(key: key);

  @override
  _GetPriceSplitState createState() => _GetPriceSplitState();
}

class _GetPriceSplitState extends State<GetPriceSplit> {
  TolProductDatum item = TolProductDatum();

  @override
  Widget build(BuildContext context) {
    setState(() {
      item = GlobalData.selectedItem;
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextView(
            'Price Details',
            color: CoupledTheme().primaryBlue,
            size: 22,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            decoration: TextDecoration.none,
            textAlign: TextAlign.center,
            textScaleFactor: .8,
            fontWeight: FontWeight.normal,
          ),
        ),

        SizedBox(
          height: 2,
        ),
        getTextWithPrice('Price ', (item.price * item.quantity).toDouble(),
            stock: '(${item.quantity} Qty)'),
//        getTextWithPrice('Tax', ((item.price * item.quantity)*item.tax) ~/100),
        getTextWithPrice('Tax', (item.tax * item.quantity).toDouble()),
        getTextWithPrice(
            'Shipping Fee', (item.shippingFee * item.quantity).toDouble()),
        getTextWithPrice('Total Amount', (item.totalPrice * item.quantity),
            isSum: true),
      ],
    );
  }

  ///tol price split builder
  getTextWithPrice(String title, double price,
      {bool isSum = false, String stock = ''}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RichText(
              text: TextSpan(children: [
            WidgetSpan(
                child: TextView(
              title,
              color: title == 'Total Amount'
                  ? CoupledTheme().primaryPink
                  : Colors.white,
              size: isSum ? 22 : 20,
              fontWeight: isSum ? FontWeight.bold : FontWeight.normal,
              maxLines: 1,
              decoration: TextDecoration.none,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
              overflow: TextOverflow.visible,
            )),
            WidgetSpan(
                child: TextView(
              stock,
              color: Colors.white,
              size: isSum ? 22 : 20,
              fontWeight: isSum ? FontWeight.bold : FontWeight.normal,
              maxLines: 1,
              decoration: TextDecoration.none,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
              overflow: TextOverflow.visible,
            ))
          ])),
          TextView(
            '${CoupledStrings.INR} ${price.toStringAsFixed(2)}',
            color: title == 'Total Amount'
                ? CoupledTheme().primaryPink
                : Colors.white,
            size: isSum ? 22 : 20,
            fontWeight: isSum ? FontWeight.bold : FontWeight.normal,
            maxLines: 1,
            decoration: TextDecoration.none,
            textAlign: TextAlign.center,
            textScaleFactor: .8,
            overflow: TextOverflow.visible,
          )
        ],
      ),
    );
  }
}

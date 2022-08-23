import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/TOL/Bloc/tol_list_bloc_bloc.dart';
import 'package:coupled/TOL/stepper.dart';
import 'package:coupled/TOL/tol_helpers.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TolTrackItem extends StatefulWidget {
  final String productId;
  final int price, shippingfee;
  final dynamic quantity;
  final double tax, totalprice;

  const TolTrackItem(
      {Key? key,
      this.productId = '',
      this.price = 0,
      this.quantity,
      this.shippingfee = 0,
      this.tax = 0.0,
      this.totalprice = 0.0})
      : super(key: key);

  @override
  _TolTrackItemState createState() => _TolTrackItemState();
}

class _TolTrackItemState extends State<TolTrackItem> {
  List<StepTol> steps = [];

  TolListBlocBloc tolListBlocBloc = TolListBlocBloc();
  int currentStep = 0;

  @override
  void initState() {
    getrefreshstate();
    // getrefreshstate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoupledTheme().backgroundColor,
      appBar: buildAppbar(context),
      body: StatefulBuilder(
        builder: (context, snapshot) => BlocBuilder(
            bloc: tolListBlocBloc,
            builder: (context, state) {
              print("state----------------$state");
              print(GlobalData.trackOrderModel.response?.histories?.length);

              if (GlobalData.trackOrderModel.response?.histories?.length !=
                  null)
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  if (GlobalData.trackOrderModel.response?.histories?.length !=
                      null)
                    currentStep =
                        GlobalData.trackOrderModel.response!.histories!.length -
                            1;
                });

              if (state is InitialTolListBlocState)
                return Center(child: GlobalWidgets().showCircleProgress());
              if (state is TolErrorState)
                return Center(
                    child: GlobalWidgets()
                        .errorState(message: state.errorMessage));
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      trackItem(context),
                      Divider(
                        height: 1,
                        color: Colors.white38,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
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
                              textAlign: TextAlign.start,
                              decoration: TextDecoration.none,
                              textScaleFactor: .8,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          widget.quantity != null
                              ? getTextWithPrices('Price ',
                                  (widget.price * widget.quantity).toDouble(),
                                  stock: '(${widget.quantity} Qty)')
                              : getTextWithPrices(
                                  'Price ',
                                  (widget.price).toDouble(),
                                ),
                          getTextWithPrices('Tax', (widget.tax).toDouble()),
                          getTextWithPrices(
                              'Shipping Fee', (widget.shippingfee).toDouble()),
                          widget.quantity != null
                              ? getTextWithPrices(
                                  'Total Amount',
                                  ((widget.price * widget.quantity) +
                                          widget.tax +
                                          (widget.shippingfee))
                                      .toDouble(),
                                  isSum: true)
                              : getTextWithPrices(
                                  'Total Amount',
                                  ((widget.price) +
                                          widget.tax +
                                          (widget.shippingfee))
                                      .toDouble(),
                                  isSum: true),
                          SizedBox(
                            height: 2,
                          ),
                        ],
                      ),

                      ///old code
                      //GetPriceSplit(),

                      Divider(
                        height: 1,
                        color: Colors.white38,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GlobalData?.trackOrderModel.response?.message != null
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextView(
                                'Your message to ${GlobalData.trackOrderModel.response != null ? GlobalData.trackOrderModel.response?.partner?.name : 'partner'}',
                                color: CoupledTheme().primaryBlue,
                                size: 22,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                decoration: TextDecoration.none,
                                textScaleFactor: .8,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextView(
                          GlobalData?.trackOrderModel.response?.message ?? '',
                          size: 14,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          decoration: TextDecoration.none,
                          textScaleFactor: .8,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      ///TODO
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextView(
                          'Tracking History',
                          color: CoupledTheme().primaryBlue,
                          size: 22,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          decoration: TextDecoration.none,
                          textScaleFactor: .8,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      StatefulBuilder(
                        builder: (context, snapshot) => StepperTol(
                          physics: NeverScrollableScrollPhysics(),
                          currentStep: currentStep,
                          onStepTapped: (int) {
                            print("step::$int");
                            setState(() {
                              currentStep = int;
                            });
                          },
                          steps: List<StepTol>.generate(
                              GlobalData
                                  .trackOrderModel.response!.histories!.length,
                              (index) => getStep(
                                  GlobalData?.trackOrderModel.response
                                          ?.histories![index].orderStatus ??
                                      '',
                                  DateFormat('dd-MM-yyyy,  kk:mm:a').format(
                                      GlobalData?.trackOrderModel.response
                                          ?.histories![index].createdAt
                                          .add(
                                              Duration(hours: 5, minutes: 30))),
                                  GlobalData?.trackOrderModel.response
                                          ?.histories![index].message ??
                                      '')),
                          controlsBuilder:
                              (BuildContext context, ControlsDetails details) {
                            return SizedBox();
                          },
                          onStepCancel: () {},
                          onStepContinue: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  getrefreshstate() {
    setState(() {
      tolListBlocBloc = BlocProvider.of<TolListBlocBloc>(context);
      tolListBlocBloc.add(TolLoadTracking());
    });
  }

  getTextWithPrices(String title, double price,
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
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              decoration: TextDecoration.none,
              textScaleFactor: .8,
            )),
            WidgetSpan(
                child: TextView(
              stock,
              color: Colors.white,
              size: isSum ? 22 : 20,
              fontWeight: isSum ? FontWeight.bold : FontWeight.normal,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              decoration: TextDecoration.none,
              textScaleFactor: .8,
            ))
          ])),
          TextView(
            '${CoupledStrings.INR} ${price.toStringAsFixed(2)}',
            color: title == 'Total Amount'
                ? CoupledTheme().primaryPink
                : Colors.white,
            size: isSum ? 22 : 20,
            fontWeight: isSum ? FontWeight.bold : FontWeight.normal,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            decoration: TextDecoration.none,
            textScaleFactor: .8,
          )
        ],
      ),
    );
  }
}

getStep(
  String title,
  String date,
  String description,
) {
  return StepTol(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextView(
            title,
            size: 20,
            color: CoupledTheme().primaryPink,
            fontWeight: FontWeight.normal,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            decoration: TextDecoration.none,
            textScaleFactor: .8,
          ),
          SizedBox(
            height: 4,
          ),
          TextView(
            date,
            fontWeight: FontWeight.normal,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            decoration: TextDecoration.none,
            textScaleFactor: .8,
            color: Colors.white,
            size: 12,
          ),
          /*TextView(
            description,
            fontWeight: FontWeight.normal,
          ),*/
          SizedBox(
            height: 4,
          ),
        ],
      ),
      content: TextView(
        description,
        fontWeight: FontWeight.normal,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        decoration: TextDecoration.none,
        textScaleFactor: .8,
        color: Colors.white,
        size: 12,
      ),
      subtitle: SizedBox());
}

trackItem(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Container(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextView(
                'Order ID - ${GlobalData?.trackOrderModel.response?.orderNumber ?? ""}',
                size: 14,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              TextView(
                GlobalData?.trackOrderModel.response?.item?.product?.name ?? '',
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
                'Product ID - ${GlobalData?.trackOrderModel.response?.item?.product?.productCode ?? ""}',
                size: 14,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              TextView(
                '${CoupledStrings.INR} ${GlobalData?.trackOrderModel.response?.item?.price ?? ""}',
                color: CoupledTheme().primaryPink,
                size: 24,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          )),
        ),
        Expanded(
          flex: 3,
          child: Container(
            width: 100,
            height: 115,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                clipBehavior: Clip.antiAlias,
                elevation: 3.0,
                child: Stack(
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                      width: MediaQuery.of(context).size.width,
                      height: (72 * MediaQuery.of(context).size.height) / 100,
                      fit: BoxFit.cover,
                      placeholder: 'assets/no_image.jpg',
                      image: APis().imageApi(
                          GlobalData?.trackOrderModel.response?.item?.product
                                  ?.image?.imageName ??
                              "",
                          imageFolder: ImageFolder.TOL),
                    ),
                  ],
                )),
          ),
        )
      ],
    ),
  );
}

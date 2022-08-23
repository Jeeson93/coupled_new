import 'package:coupled/Home/main_board.dart';
import 'package:coupled/PlansAndPayment/MyPlansandPayments/view/MyPlansAndPayment.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/TOL/tol_track_item_4.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/models/tol_checkout_model.dart';
import 'package:coupled/models/tol_list_model.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentGateWay extends StatefulWidget {
  final ProfileResponse? profileResponse;
  final Plan? plan;
  final PlanTopup? topUpPlan;
  final CouplingScoreStatistics? couplingScore;
  final TolCheckOutItemModel? tolCheckOutItemModel;

  const PaymentGateWay(
      {Key? key,
      this.plan,
      this.topUpPlan,
      this.couplingScore,
      this.profileResponse,
      this.tolCheckOutItemModel})
      : super(key: key);

  @override
  _PaymentGateWayState createState() => _PaymentGateWayState();
}

class _PaymentGateWayState extends State<PaymentGateWay> {
  Razorpay _razorPay = Razorpay();
  int totalPrice = 0;
  TolProductDatum item = TolProductDatum();
  @override
  void initState() {
    _razorPay = Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    double tolProductPrice =
        widget.tolCheckOutItemModel?.response?.data?.order?.totalPrice ?? 0;
    int planPrice = widget.plan != null ? int.parse(widget.plan!.amount) : 0;
    int topUpPrice = widget.topUpPlan != null
        ? int.parse(widget.topUpPlan!.topup!.amount.toString())
        : 0;
    int couplingScorePrice = widget.couplingScore != null
        ? int.parse(widget.couplingScore!.activationFee)
        : 0;

    totalPrice =
        ((planPrice + topUpPrice + couplingScorePrice + tolProductPrice) * 100)
            .toInt();
    item = GlobalData.selectedItem;
    openCheckout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: CoupledTheme().backgroundColor,
        appBar: AppBar(
          title: TextView(
            'Payment',
            color: Colors.white,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            size: 12,
            textScaleFactor: .8,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Image.asset(
                  'assets/logo/logo_pink.png',
                  height: 80,
                ),
              ),
              TextView(
                'Please Wait...',
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                size: 12,
                textScaleFactor: .8,
              )
            ],
          ),
        ),
      ),
    );
  }

  void openCheckout() async {
    var options = {
      'key': APis.razorPayKey,
      'amount': totalPrice,
      'name': 'Coupled',
      // 'image': APis.coupledLogo,
      'description': 'The Datemony App',
      'prefill': {
        'name': '${GlobalData.myProfile.name} ${GlobalData.myProfile.lastName}',
        'contact': GlobalData.myProfile.userPhone.toString(),
        'email': GlobalData.myProfile.userEmail.toString() == ''
            ? ''
            : GlobalData.myProfile.userEmail
      },
      'external': {
        'wallets': ['paytm']
      },
      'theme': {'color': '#bc1b87'}
    };

    try {
      _razorPay.open(options);
    } catch (e) {
      print('$e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //    GlobalWidgets().showToast(msg: "SUCCESS: " + response.paymentId);
    GlobalWidgets().showToast(msg: "SUCCESS");

    var param = {
      "transaction_id": response.paymentId,
      "purchase_plan": widget.plan != null ? widget.plan!.toMap() : null,
      "purchase_topup":
          widget.topUpPlan != null ? widget.topUpPlan!.toMap() : null,
      "purchase_statistics":
          widget.couplingScore != null ? widget.couplingScore!.toMap() : null,
    };
    var tolOrderParam = {
      "payment_id": response.paymentId,
      "order_number":
          widget.tolCheckOutItemModel?.response?.data?.order?.orderNumber ?? "",
    };
    try {
      RestAPI()
          .post(
              widget.tolCheckOutItemModel == null
                  ? APis.purchasePlans
                  : APis.tolOrderUpdate,
              params:
                  widget.tolCheckOutItemModel == null ? param : tolOrderParam)
          .then((value) {
        print('payment response----------');
        print(value);
        Repository().fetchProfile('').then(
          (value) {
            try {
              GlobalData.myProfile = value;
            } catch (e) {
              print('$e');
            }
          },
        );

        GlobalData.tolTrackOrderNumber =
            widget.tolCheckOutItemModel?.response?.data?.order?.orderNumber ??
                "";

        /*   WidgetsBinding.instance.addPostFrameCallback((_) async {

        });*/
        print('widget.couplingScore${widget.couplingScore}');
        print('widget.plan${widget.plan}');
        print('widget.tolCheckOutItemModel${widget.tolCheckOutItemModel}');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                (widget.couplingScore != null && widget.plan == null)
                    ? MainBoard()
                    : widget.tolCheckOutItemModel == null
                        ? MyPlansAndPayment()
                        : TolTrackItem(
                            price: widget.tolCheckOutItemModel!.response!.data!
                                .order!.price
                                .toInt(),
                            productId: widget.tolCheckOutItemModel!.response!
                                .data!.order!.partnerId
                                .toString(),
                            quantity: null,
                            shippingfee: widget.tolCheckOutItemModel?.response
                                ?.data?.order?.shippingFee,
                            tax: widget.tolCheckOutItemModel?.response?.data
                                ?.order?.tax,
                            totalprice: widget.tolCheckOutItemModel?.response
                                ?.data?.order?.totalPrice,
                          ),
          ),
        );
      }, onError: ((e) {
        print('payment error response----------');
        print('$e');
        GlobalWidgets().showToast(msg: e.toString());
      }));
    } on RestException catch (e) {
      print('payment error response----------');
      print('$e');
      GlobalWidgets().showToast(msg: e.message);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    /* GlobalWidgets().showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message);*/
    GlobalWidgets().showToast(msg: response.message);
    print(response);
    Navigator.pop(context, true);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response);
    GlobalWidgets()
        .showToast(msg: "EXTERNAL_WALLET: " + response.walletName.toString());
  }
}

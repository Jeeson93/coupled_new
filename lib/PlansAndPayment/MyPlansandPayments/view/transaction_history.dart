import 'package:coupled/PlansAndPayment/MyPlansandPayments/bloc/bloc.dart';
import 'package:coupled/PlansAndPayment/MyPlansandPayments/bloc/my_plans_and_payment_bloc.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/transaction_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionHistory extends StatefulWidget {
  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  MyPlansAndPaymentBloc myPlansAndPaymentBloc = MyPlansAndPaymentBloc();
  Widget childView = Container();
  TransactionModel transactionModel = TransactionModel(response: []);

  @override
  void initState() {
    myPlansAndPaymentBloc = MyPlansAndPaymentBloc();
    myPlansAndPaymentBloc.add(LoadTransactionHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoupledTheme().backgroundColor,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(2.0),
          child: TextView(
            'Transaction History',
            size: 22,
            textAlign: TextAlign.center,
            color: Colors.white,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.visible,
            textScaleFactor: .8,
          ),
        ),
        backgroundColor: CoupledTheme().backgroundColor,
      ),
      body: BlocBuilder(
        bloc: myPlansAndPaymentBloc,
        builder: (context, state) {
          print('state------$state');
          print(state);
          if (state is InitialMyPlansAndPaymentState) {
            childView = GlobalWidgets().showCircleProgress();
          }

          if (state is MyPlansErrorState)
            childView = GlobalWidgets().showCircleProgress();
          if (state is TransactionHistoryLoaded) {
            transactionModel = state.transactionModel;
            childView = Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: ListView.builder(
                  itemCount: transactionModel.response.length,
                  itemBuilder: (context, index) => Card(
                    color: CoupledTheme().tabColor3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: transactionModel
                                .response[index].transactionDetails.length,
                            itemBuilder: (context, index1) {
                              TransactionDetail transactionDetail =
                                  transactionModel.response[index]
                                      .transactionDetails[index1];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextView(
                                    transactionDetail.type == 'purchase_plan'
                                        ? transactionDetail
                                                .purchasable?.planName ??
                                            ''
                                        : transactionDetail.type ==
                                                'purchase_topup'
                                            ? 'Top Up'
                                            : 'Coupling Score',
                                    size: 18,
                                    textAlign: TextAlign.center,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.visible,
                                    textScaleFactor: .8,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),

                                  ///unit
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      TextView(
                                        'Product Price',
                                        size: 15,
                                        textAlign: TextAlign.center,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                        overflow: TextOverflow.visible,
                                        textScaleFactor: .8,
                                      ),
                                      TextView(
                                        '₹ ${(transactionDetail.purchasable.amount ?? transactionDetail.purchasable.activationFee ?? 0) - ((transactionDetail.purchasable.amount ?? transactionDetail.purchasable.activationFee ?? 0) * 18 / 100)}',
                                        fontWeight: FontWeight.normal,
                                        size: 16,
                                        textAlign: TextAlign.center,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        overflow: TextOverflow.visible,
                                        textScaleFactor: .8,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),

                                  ///gst
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      TextView(
                                        'GST',
                                        size: 15,
                                        textAlign: TextAlign.center,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                        overflow: TextOverflow.visible,
                                        textScaleFactor: .8,
                                      ),
                                      TextView(
                                        '₹ ${((transactionDetail.purchasable.amount ?? transactionDetail.purchasable.activationFee ?? 0) * 18 / 100)}',
                                        fontWeight: FontWeight.normal,
                                        size: 16,
                                        textAlign: TextAlign.center,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        overflow: TextOverflow.visible,
                                        textScaleFactor: .8,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),

                                  ///total
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      TextView(
                                        'Total',
                                        size: 18,
                                        textAlign: TextAlign.center,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                        overflow: TextOverflow.visible,
                                        textScaleFactor: .8,
                                      ),
                                      TextView(
                                        '₹ ${transactionDetail.purchasable?.amount ?? transactionDetail.purchasable.activationFee ?? ''}',
                                        fontWeight: FontWeight.normal,
                                        size: 18,
                                        textAlign: TextAlign.center,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        overflow: TextOverflow.visible,
                                        textScaleFactor: .8,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextView(
                            '${formatDate(transactionModel.response[index].createdAt ?? DateTime.now(), [
                                  dd,
                                  ' ',
                                  M,
                                  ' ',
                                  yyyy
                                ])}',
                            textAlign: TextAlign.center,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.visible,
                            size: 12,
                            textScaleFactor: .8,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            color: CoupledTheme().tabColor1,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              TextView(
                                'Payment mode',
                                textAlign: TextAlign.center,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.visible,
                                size: 12,
                                textScaleFactor: .8,
                              ),
                              TextView(
                                transactionModel.response[index].method ?? '',
                                textAlign: TextAlign.center,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.visible,
                                size: 12,
                                textScaleFactor: .8,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              TextView(
                                'Reference number',
                                textAlign: TextAlign.center,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.visible,
                                size: 12,
                                textScaleFactor: .8,
                              ),
                              TextView(
                                transactionModel
                                        .response[index].transactionId ??
                                    '',
                                textAlign: TextAlign.center,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.visible,
                                size: 12,
                                textScaleFactor: .8,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return childView;
        },
      ),
    );
  }
}

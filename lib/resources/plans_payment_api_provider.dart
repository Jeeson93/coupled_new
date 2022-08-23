

import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/models/transaction_model.dart';

class PlansPaymentApiProvider {
  Future<MembershipPlansModel> getMembershipPlans() async {
    try {
      Map<String, dynamic> res = await RestAPI().get(APis.membershipPlans);
      return MembershipPlansModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }

  Future<MyPlansAndPaymentModel> getMyPlansAndPayment() async {
    try {
      Map<String, dynamic> res = await RestAPI().get(APis.myPlansAndPayment);
      return MyPlansAndPaymentModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }

  Future<TransactionModel> getTransactionHistory() async {
    try {
      Map<String, dynamic> res = await RestAPI().get(APis.myTransactionHistory);
      return TransactionModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}

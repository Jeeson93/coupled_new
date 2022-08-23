import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/models/tol_checkout_model.dart';
import 'package:coupled/models/tol_list_model.dart';
import 'package:coupled/models/tol_order_history.dart';
import 'package:coupled/src/coupled_global.dart';

class TolApiProvider {
  Future<TolProductModel> getTolList() async {
    try {
      var res = await RestAPI().get(
        "${APis.tolProduct}?sort=${GlobalData.selectedSort.others ?? ''}&category_id=${GlobalData.selectedCategory.id ?? ''}",
      );
      return TolProductModel.fromMap(res);
    } on RestException catch (e) {
      throw e.message;
    }
  }

  Future<TolCheckOutItemModel> tolCheckout() async {
    try {
      var res = await RestAPI().post("${APis.tolOrder}", params: {
        'product_code': GlobalData.selectedItem.productCode,
        'quantity': GlobalData.selectedItem.quantity,
        'message': GlobalData.selectedItem.message,
        'partner_id': GlobalData.chatResponse?.partner?.id,
      });
      return TolCheckOutItemModel.fromMap(res);
    } on RestException catch (e) {
      throw e.message;
    }
  }

  Future<TolOrderHistoryModel> tolGetHistory() async {
    try {
      var res = await RestAPI().get("${APis.tolOrder}");
      return TolOrderHistoryModel.fromMap(res);
    } on RestException catch (e) {
      throw e;
    }
  }

  Future<TrackOrderModel> tolTrackOrder() async {
    print('TollTrack4${APis.tolOrder}${GlobalData.tolTrackOrderNumber}');
    try {
      var res = await RestAPI()
          .get("${APis.tolOrder}/${GlobalData.tolTrackOrderNumber}");

      return TrackOrderModel.fromMap(res);
    } on RestException catch (e) {
      throw e;
    }
  }
}

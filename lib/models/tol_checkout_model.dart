// To parse this JSON data, do
//
//     final tolCheckOutItemModel = tolCheckOutItemModelFromMap(jsonString);

import 'dart:convert';

TolCheckOutItemModel tolCheckOutItemModelFromMap(String str) =>
    TolCheckOutItemModel.fromMap(json.decode(str));

String tolCheckOutItemModelToMap(TolCheckOutItemModel data) =>
    json.encode(data.toMap());

class TolCheckOutItemModel {
  TolCheckOutItemModel({
    this.status,
    this.response,
    this.code,
  });

  dynamic status;
  TolCheckOutItem? response;
  dynamic code;

  factory TolCheckOutItemModel.fromMap(Map<String, dynamic> json) =>
      TolCheckOutItemModel(
        status: json["status"] == null ? null : json["status"],
        response: json["response"] == null
            ? null
            : TolCheckOutItem.fromMap(json["response"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response!.toMap(),
        "code": code == null ? null : code,
      };
}

class TolCheckOutItem {
  TolCheckOutItem({
    this.data,
    this.msg,
  });

  Data? data;
  dynamic msg;

  factory TolCheckOutItem.fromMap(Map<String, dynamic> json) => TolCheckOutItem(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        msg: json["msg"] == null ? null : json["msg"],
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
        "msg": msg == null ? null : msg,
      };
}

class Data {
  Data({
    this.order,
  });

  Order? order;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        order: json["order"] == null ? null : Order.fromMap(json["order"]),
      );

  Map<String, dynamic> toMap() => {
        "order": order == null ? null : order!.toMap(),
      };
}

class Order {
  Order({
    this.userId,
    this.partnerId,
    this.price,
    this.tax,
    this.shippingFee,
    this.totalPrice,
    this.orderNumber,
    this.status,
    this.message,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  dynamic userId;
  dynamic partnerId;
  dynamic price;
  dynamic tax;
  dynamic shippingFee;
  dynamic totalPrice;
  String? orderNumber;
  dynamic status;
  dynamic message;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic id;

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        userId: json["user_id"] == null ? null : json["user_id"],
        partnerId: json["partner_id"] == null ? null : json["partner_id"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        tax: json["tax"] == null ? null : json["tax"].toDouble(),
        shippingFee: json["shipping_fee"] == null ? null : json["shipping_fee"],
        totalPrice:
            json["total_price"] == null ? null : json["total_price"].toDouble(),
        orderNumber: json["order_number"] == null ? null : json["order_number"],
        status: json["status"] == null ? null : json["status"],
        message: json["message"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId == null ? null : userId,
        "partner_id": partnerId == null ? null : partnerId,
        "price": price == null ? null : price,
        "tax": tax == null ? null : tax,
        "shipping_fee": shippingFee == null ? null : shippingFee,
        "total_price": totalPrice == null ? null : totalPrice,
        "order_number": orderNumber == null ? null : orderNumber,
        "status": status == null ? null : status,
        "message": message,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "id": id == null ? null : id,
      };
}

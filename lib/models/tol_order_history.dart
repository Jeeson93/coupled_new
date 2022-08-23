import 'dart:convert';

import 'package:coupled/models/tol_list_model.dart';

import 'profile.dart'; // To parse this JSON data, do TolOrderHistoryModel

tolOrderHistoryModelFromMap(String str) =>
    TolOrderHistoryModel.fromMap(json.decode(str));

String tolOrderHistoryModelToMap(TolOrderHistoryModel data) =>
    json.encode(data.toMap());

class TolOrderHistoryModel {
  TolOrderHistoryModel({
    this.status = '',
    this.response,
    this.code = 0,
  });

  String status;
  TolOrderHistory? response;
  int code;

  factory TolOrderHistoryModel.fromMap(Map<String, dynamic> json) =>
      TolOrderHistoryModel(
        status: json["status"] == '' ? '' : json["status"],
        response: json["response"] == null
            ? null
            : TolOrderHistory.fromMap(json["response"]),
        code: json["code"] == 0 ? 0 : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == '' ? '' : status,
        "response": response == null ? {} : response!.toMap(),
        "code": code == 0 ? 0 : code,
      };
}

class TolOrderHistory {
  TolOrderHistory({
    this.currentPage = 1,
    this.data,
    this.firstPageUrl = '',
    this.from = 0,
    this.lastPage = 0,
    this.lastPageUrl = '',
    this.nextPageUrl,
    this.path = '',
    this.perPage = 0,
    this.prevPageUrl,
    this.to = 0,
    this.total = 0,
  });

  dynamic currentPage;
  List<TolOrderHistoryDatum>? data;
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  dynamic nextPageUrl;
  dynamic path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;

  factory TolOrderHistory.fromMap(Map<String, dynamic> json) => TolOrderHistory(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? []
            : List<TolOrderHistoryDatum>.from(
                json["data"].map((x) => TolOrderHistoryDatum.fromMap(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class TolOrderHistoryDatum {
  TolOrderHistoryDatum({
    this.id = 0,
    this.userId = 0,
    this.partnerId = 0,
    this.price = 0,
    this.tax = 0.0,
    this.shippingFee = 0,
    this.totalPrice = 0.0,
    this.orderNumber = '',
    this.status = '',
    this.message = '',
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.item,
    this.user,
    this.partner,
    this.address,
    this.histories = const <History>[],
  });

  dynamic id;
  dynamic userId;
  dynamic partnerId;
  dynamic price;
  dynamic tax;
  dynamic shippingFee;
  dynamic totalPrice;
  dynamic orderNumber;
  dynamic status;
  dynamic message;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  Item? item;
  Partner? user;
  Partner? partner;
  Address? address;
  List<History>? histories;

  factory TolOrderHistoryDatum.fromMap(Map<String, dynamic> json) =>
      TolOrderHistoryDatum(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        partnerId: json["partner_id"] == null ? null : json["partner_id"],
        price: json["price"] == null ? null : json["price"],
        tax: json["tax"] == null ? null : json["tax"].toDouble(),
        shippingFee: json["shipping_fee"] == null ? null : json["shipping_fee"],
        totalPrice:
            json["total_price"] == null ? null : json["total_price"].toDouble(),
        orderNumber: json["order_number"] == null ? null : json["order_number"],
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        item: json["item"] == null ? null : Item.fromMap(json["item"]),
        user: json["user"] == null ? null : Partner.fromMap(json["user"]),
        partner:
            json["partner"] == null ? null : Partner.fromMap(json["partner"]),
        address:
            json["address"] == null ? null : Address.fromMap(json["address"]),
        histories: json["histories"] == null
            ? []
            : List<History>.from(
                json["histories"].map((x) => History.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "partner_id": partnerId == null ? null : partnerId,
        "price": price == null ? null : price,
        "tax": tax == null ? null : tax,
        "shipping_fee": shippingFee == null ? null : shippingFee,
        "total_price": totalPrice == null ? null : totalPrice,
        "order_number": orderNumber == null ? null : orderNumber,
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "item": item == null ? null : item!.toMap(),
        "user": user == null ? null : user!.toMap(),
        "partner": partner == null ? null : partner!.toMap(),
        "address": address == null ? null : address!.toMap(),
        "histories": histories == null
            ? null
            : List<dynamic>.from(histories!.map((x) => x.toMap())),
      };
}

class AddressTolOrder {
  AddressTolOrder({
    this.id,
    this.orderId,
    this.userId,
    this.partnerId,
    this.addressType,
    this.countryCode,
    this.country,
    this.state,
    this.city,
    this.locationId,
    this.address,
    this.pincode,
    this.presentAddress,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic orderId;
  dynamic userId;
  dynamic partnerId;
  dynamic addressType;
  dynamic countryCode;
  dynamic country;
  dynamic state;
  dynamic city;
  dynamic locationId;
  dynamic address;
  dynamic pincode;
  dynamic presentAddress;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  factory AddressTolOrder.fromMap(Map<String, dynamic> json) => AddressTolOrder(
        id: json["id"] == null ? null : json["id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        partnerId: json["partner_id"] == null ? null : json["partner_id"],
        addressType: json["address_type"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        country: json["country"] == null ? null : json["country"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        locationId: json["location_id"] == null ? null : json["location_id"],
        address: json["address"] == null ? null : json["address"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        presentAddress:
            json["present_address"] == null ? null : json["present_address"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "order_id": orderId == null ? null : orderId,
        "user_id": userId == null ? null : userId,
        "partner_id": partnerId == null ? null : partnerId,
        "address_type": addressType,
        "country_code": countryCode == null ? null : countryCode,
        "country": country == null ? null : country,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "location_id": locationId == null ? null : locationId,
        "address": address == null ? null : address,
        "pincode": pincode == null ? null : pincode,
        "present_address": presentAddress == null ? null : presentAddress,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class History {
  History({
    this.id,
    this.orderId,
    this.orderStatus,
    this.message,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic orderId;
  dynamic orderStatus;
  dynamic message;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  factory History.fromMap(Map<String, dynamic> json) => History(
        id: json["id"] == null ? null : json["id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        orderStatus: json["order_status"] == null ? null : json["order_status"],
        message: json["message"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "order_id": orderId == null ? null : orderId,
        "order_status": orderStatus == null ? null : orderStatus,
        "message": message,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class Item {
  Item({
    this.id,
    this.orderId,
    this.productId,
    this.price,
    this.tax,
    this.shippingFee,
    this.totalPrice,
    this.quantity,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  dynamic id;
  dynamic orderId;
  dynamic productId;
  dynamic price;
  dynamic tax;
  dynamic shippingFee;
  dynamic totalPrice;
  dynamic quantity;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  Product? product;

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id"] == null ? null : json["id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        price: json["price"] == null ? null : json["price"],
        tax: json["tax"] == null ? null : json["tax"].toDouble(),
        shippingFee: json["shipping_fee"] == null ? null : json["shipping_fee"],
        totalPrice:
            json["total_price"] == null ? null : json["total_price"].toDouble(),
        quantity: json["quantity"] == null ? null : json["quantity"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        product:
            json["product"] == null ? null : Product.fromMap(json["product"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "order_id": orderId == null ? null : orderId,
        "product_id": productId == null ? null : productId,
        "price": price == null ? null : price,
        "tax": tax == null ? null : tax,
        "shipping_fee": shippingFee == null ? null : shippingFee,
        "total_price": totalPrice == null ? null : totalPrice,
        "quantity": quantity == null ? null : quantity,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "product": product == null ? null : product!.toMap(),
      };
}

class Product {
  Product({
    this.id,
    this.categoryId,
    this.subCategoryId,
    this.productCode,
    this.name,
    this.price,
    this.tax,
    this.taxRate,
    this.shippingFee,
    this.totalPrice,
    this.stock,
    this.status,
    this.description,
    this.deliveryInfo,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.images,
  });

  dynamic id;
  dynamic categoryId;
  dynamic subCategoryId;
  dynamic productCode;
  dynamic name;
  dynamic price;
  dynamic tax;
  dynamic taxRate;
  dynamic shippingFee;
  dynamic totalPrice;
  dynamic stock;
  dynamic status;
  dynamic description;
  dynamic deliveryInfo;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  TOlImage? image;
  List<TOlImage>? images;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        subCategoryId:
            json["sub_category_id"] == null ? null : json["sub_category_id"],
        productCode: json["product_code"] == null ? null : json["product_code"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        tax: json["tax"] == null ? null : json["tax"].toDouble(),
        taxRate: json["tax_rate"] == null ? null : json["tax_rate"],
        shippingFee: json["shipping_fee"] == null ? null : json["shipping_fee"],
        totalPrice:
            json["total_price"] == null ? null : json["total_price"].toDouble(),
        stock: json["stock"] == null ? null : json["stock"],
        status: json["status"] == null ? null : json["status"],
        description: json["description"] == null ? null : json["description"],
        deliveryInfo:
            json["delivery_info"] == null ? null : json["delivery_info"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        image: json["image"] == null ? null : TOlImage.fromMap(json["image"]),
        images: json["images"] == null
            ? null
            : List<TOlImage>.from(
                json["images"].map((x) => TOlImage.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "category_id": categoryId == null ? null : categoryId,
        "sub_category_id": subCategoryId == null ? null : subCategoryId,
        "product_code": productCode == null ? null : productCode,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "tax": tax == null ? null : tax,
        "tax_rate": taxRate == null ? null : taxRate,
        "shipping_fee": shippingFee == null ? null : shippingFee,
        "total_price": totalPrice == null ? null : totalPrice,
        "stock": stock == null ? null : stock,
        "status": status == null ? null : status,
        "description": description == null ? null : description,
        "delivery_info": deliveryInfo == null ? null : deliveryInfo,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "image": image == null ? null : image!.toMap(),
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toMap())),
      };
}

class Partner {
  Partner({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.createdAt,
    this.membershipCode,
    this.gender,
    this.phone,
    this.profilePic,
    this.emailVerification,
    this.mobileVerification,
    this.isActive,
    this.edited,
    this.online,
    this.lastActive,
    this.hideAt,
  });

  dynamic id;
  dynamic name;
  dynamic lastName;
  dynamic email;
  dynamic createdAt;
  dynamic membershipCode;
  dynamic gender;
  dynamic phone;
  dynamic profilePic;
  dynamic emailVerification;
  dynamic mobileVerification;
  dynamic isActive;
  dynamic edited;
  dynamic online;
  dynamic lastActive;
  dynamic hideAt;

  factory Partner.fromMap(Map<String, dynamic> json) => Partner(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        membershipCode:
            json["membership_code"] == null ? null : json["membership_code"],
        gender: json["gender"] == null ? null : json["gender"],
        phone: json["phone"] == null ? null : json["phone"],
        profilePic: json["profile_pic"],
        emailVerification: json["email_verification"] == null
            ? null
            : json["email_verification"],
        mobileVerification: json["mobile_verification"] == null
            ? null
            : json["mobile_verification"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        edited: json["edited"] == null ? null : json["edited"],
        online: json["online"] == null ? null : json["online"],
        lastActive: json["last_active"],
        hideAt: json["hide_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "membership_code": membershipCode == null ? null : membershipCode,
        "gender": gender == null ? null : gender,
        "phone": phone == null ? null : phone,
        "profile_pic": profilePic,
        "email_verification":
            emailVerification == null ? null : emailVerification,
        "mobile_verification":
            mobileVerification == null ? null : mobileVerification,
        "is_active": isActive == null ? null : isActive,
        "edited": edited == null ? null : edited,
        "online": online == null ? null : online,
        "last_active": lastActive,
        "hide_at": hideAt,
      };
} // To parse this JSON data, do // //     final trackOrderModel = trackOrderModelFromMap(jsonString); TrackOrderModel

trackOrderModelFromMap(String str) => TrackOrderModel.fromMap(json.decode(str));

String trackOrderModelToMap(TrackOrderModel data) => json.encode(data.toMap());

class TrackOrderModel {
  TrackOrderModel({
    this.status,
    this.response,
    this.code,
  });

  dynamic status;
  TolOrderHistoryDatum? response;
  dynamic code;

  factory TrackOrderModel.fromMap(Map<String, dynamic> json) => TrackOrderModel(
        status: json["status"] == null ? null : json["status"],
        response: json["response"] == null
            ? null
            : TolOrderHistoryDatum.fromMap(json["response"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response!.toMap(),
        "code": code == null ? null : code,
      };
}

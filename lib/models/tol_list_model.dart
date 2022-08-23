// To parse this JSON data, do
//
//     final tolProductsModel = tolProductsModelFromMap(jsonString);

import 'dart:convert';

TolProductModel tolProductModelFromMap(String str) =>
    TolProductModel.fromMap(json.decode(str));

String tolProductModelToMap(TolProductModel data) => json.encode(data.toMap());

class TolProductModel {
  TolProductModel({
    this.status,
    this.response,
    this.code,
  });

  dynamic status;
  TolProductResponse? response;
  dynamic code;

  factory TolProductModel.fromMap(Map<String, dynamic> json) => TolProductModel(
        status: json["status"] == null ? null : json["status"],
        response: json["response"] == null
            ? null
            : TolProductResponse.fromMap(json["response"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response!.toMap(),
        "code": code == null ? null : code,
      };
}

class TolProductResponse {
  TolProductResponse({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  dynamic currentPage;
  List<TolProductDatum>? data;
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

  factory TolProductResponse.fromMap(Map<String, dynamic> json) =>
      TolProductResponse(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<TolProductDatum>.from(
                json["data"].map((x) => TolProductDatum.fromMap(x))),
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

class TolProductDatum {
  TolProductDatum({
    this.id,
    this.quantity = 1,
    this.message,
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
    this.images,
    this.image,
    this.productFeatures,
  });

  dynamic id;
  dynamic categoryId;
  dynamic quantity;
  dynamic subCategoryId;
  dynamic productCode;
  dynamic message;
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
  List<TOlImage>? images;
  TOlImage? image;
  List<TOlImage>? productFeatures;

  factory TolProductDatum.fromMap(Map<String, dynamic> json) => TolProductDatum(
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
        images: json["images"] == null
            ? null
            : List<TOlImage>.from(
                json["images"].map((x) => TOlImage.fromMap(x))),
        image: json["image"] == null ? null : TOlImage.fromMap(json["image"]),
        productFeatures: json["product_features"] == null
            ? null
            : List<TOlImage>.from(
                json["product_features"].map((x) => TOlImage.fromMap(x))),
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
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toMap())),
        "image": image == null ? null : image!.toMap(),
        "product_features": productFeatures == null
            ? null
            : List<dynamic>.from(productFeatures!.map((x) => x.toMap())),
      };
}

class TOlImage {
  TOlImage({
    this.id,
    this.productId,
    this.imageName,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.content,
  });

  dynamic id;
  dynamic productId;
  dynamic imageName;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic content;

  factory TOlImage.fromMap(Map<String, dynamic> json) => TOlImage(
        id: json["id"] == null ? null : json["id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        imageName: json["image_name"] == null ? null : json["image_name"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        content: json["content"] == null ? null : json["content"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "product_id": productId == null ? null : productId,
        "image_name": imageName == null ? null : imageName,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "content": content == null ? null : content,
      };
}

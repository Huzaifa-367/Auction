import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Product {
  String name;
  String donorName;
  String retailvalue;
  String lotNo;
  List<String> image_urls;
  String description;
  String logo;
  int auctionTime;
  String productType;
  String type;
  String qty;
  String? auctioneddatetime;

  bool isQuickSale;
  String isVisible;
  int id;
  Product({
    required this.name,
    required this.donorName,
    required this.retailvalue,
    required this.lotNo,
    required this.image_urls,
    required this.description,
    required this.logo,
    required this.auctionTime,
    required this.productType,
    required this.type,
    required this.qty,
    required this.isQuickSale,
    required this.isVisible,
    required this.id,
    this.auctioneddatetime,
  });

  Product copyWith({
    String? name,
    String? donorName,
    String? retailvalue,
    String? lotNo,
    List<String>? image_urls,
    String? description,
    String? logo,
    int? auctionTime,
    String? auctioneddatetime,
    String? productType,
    String? type,
    String? qty,
    bool? isQuickSale,
    String? isVisible,
    int? id,
  }) {
    return Product(
      name: name ?? this.name,
      donorName: donorName ?? this.donorName,
      retailvalue: retailvalue ?? this.retailvalue,
      lotNo: lotNo ?? this.lotNo,
      image_urls: image_urls ?? this.image_urls,
      description: description ?? this.description,
      logo: logo ?? this.logo,
      auctionTime: auctionTime ?? this.auctionTime,
      auctioneddatetime: auctioneddatetime ?? this.auctioneddatetime,
      productType: productType ?? this.productType,
      type: type ?? this.type,
      qty: qty ?? this.qty,
      isQuickSale: isQuickSale ?? this.isQuickSale,
      isVisible: isVisible ?? this.isVisible,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'donorName': donorName});
    result.addAll({'retailvalue': retailvalue});
    result.addAll({'lotNo': lotNo});
    result.addAll({'image_urls': image_urls});
    result.addAll({'description': description});
    result.addAll({'logo': logo});
    result.addAll({'auctionTime': auctionTime});
    result.addAll({'auctioneddatetime': auctioneddatetime});
    result.addAll({'productType': productType});
    result.addAll({'type': type});
    result.addAll({'qty': qty});
    result.addAll({'isQuickSale': isQuickSale});
    result.addAll({'isVisible': isVisible});
    result.addAll({'id': id});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      donorName: map['donorName'] ?? '',
      retailvalue: map['retailvalue'] ?? '',
      lotNo: map['lotNo'] ?? '',
      image_urls: List<String>.from(map['image_urls']),
      description: map['description'] ?? '',
      logo: map['logo'] ?? '',
      auctionTime: int.parse(map['auctionTime'] ?? 0),
      auctioneddatetime: map['auctioneddatetime'] ?? '',
      productType: map['productType'] ?? '',
      type: map['type'] ?? '',
      qty: map['qty'] ?? '',
      isQuickSale: map['isQuickSale'] ?? false,
      isVisible: map['isVisible'] ?? false,
      id: int.parse(map['id'] ?? 0),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(name: $name, donorName: $donorName, retailvalue: $retailvalue, lotNo: $lotNo, image_urls: $image_urls, description: $description, logo: $logo, auctionTime: $auctionTime, auctioneddatetime: $auctioneddatetime,productType: $productType, type: $type, qty: $qty, isQuickSale: $isQuickSale, isVisible: $isVisible, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.name == name &&
        other.donorName == donorName &&
        other.retailvalue == retailvalue &&
        other.lotNo == lotNo &&
        listEquals(other.image_urls, image_urls) &&
        other.description == description &&
        other.logo == logo &&
        other.auctionTime == auctionTime &&
        other.auctioneddatetime == auctioneddatetime &&
        other.productType == productType &&
        other.type == type &&
        other.qty == qty &&
        other.isQuickSale == isQuickSale &&
        other.isVisible == isVisible &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        donorName.hashCode ^
        retailvalue.hashCode ^
        lotNo.hashCode ^
        image_urls.hashCode ^
        description.hashCode ^
        logo.hashCode ^
        auctionTime.hashCode ^
        auctioneddatetime.hashCode ^
        productType.hashCode ^
        type.hashCode ^
        qty.hashCode ^
        isQuickSale.hashCode ^
        isVisible.hashCode ^
        id.hashCode;
  }
}

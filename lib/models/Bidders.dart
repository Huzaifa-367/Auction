import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'Bidder_Model.dart';

class BiddersModel {
  int product_id;
  List<Bidder> bidders = [];
  BiddersModel({
    required this.product_id,
    required this.bidders,
  });

  BiddersModel copyWith({
    int? product_id,
    List<Bidder>? bidders,
  }) {
    return BiddersModel(
      product_id: product_id ?? this.product_id,
      bidders: bidders ?? this.bidders,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'product_id': product_id});
    result.addAll({'bidders': bidders.map((x) => x.toMap()).toList()});

    return result;
  }

  factory BiddersModel.fromMap(Map<String, dynamic> map) {
    return BiddersModel(
      product_id: int.parse(map['product_id'].toString()) ?? 0,
      bidders: List<Bidder>.from(map['bidders']?.map((x) => Bidder.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory BiddersModel.fromJson(String source) =>
      BiddersModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'BiddersModel(product_id: $product_id, bidders: $bidders)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BiddersModel &&
        other.product_id == product_id &&
        listEquals(other.bidders, bidders);
  }

  @override
  int get hashCode => product_id.hashCode ^ bidders.hashCode;
}

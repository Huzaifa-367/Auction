import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Bidder {
  int id;
  int product_id;
  String user_Name;
  String phoneNo;
  int amount;
  Timestamp time;

  Bidder({
    required this.id,
    required this.product_id,
    required this.user_Name,
    required this.phoneNo,
    required this.amount,
    required this.time,
  });

  Bidder copyWith({
    int? id,
    int? product_id,
    String? user_Name,
    String? phoneNo,
    int? amount,
    Timestamp? time,
  }) {
    return Bidder(
      id: id ?? this.id,
      product_id: product_id ?? this.product_id,
      user_Name: user_Name ?? this.user_Name,
      phoneNo: phoneNo ?? this.phoneNo,
      amount: amount ?? this.amount,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'product_id': product_id});
    result.addAll({'user_Name': user_Name});
    result.addAll({'phoneNo': phoneNo});
    result.addAll({'amount': amount});
    result.addAll({'time': time});

    return result;
  }

  factory Bidder.fromMap(Map<String, dynamic> map) {
    return Bidder(
      id: map['id']?.toInt() ?? 0,
      product_id: map['product_id']?.toInt() ?? 0,
      user_Name: map['user_Name'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      amount: map['amount']?.toInt() ?? 0,
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Bidder.fromJson(String source) => Bidder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Bidder(id: $id, product_id: $product_id, user_Name: $user_Name, phoneNo: $phoneNo, amount: $amount, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bidder &&
        other.id == id &&
        other.product_id == product_id &&
        other.user_Name == user_Name &&
        other.phoneNo == phoneNo &&
        other.amount == amount &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        product_id.hashCode ^
        user_Name.hashCode ^
        phoneNo.hashCode ^
        amount.hashCode ^
        time.hashCode;
  }
}

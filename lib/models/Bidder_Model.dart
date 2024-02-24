import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Bidder {
  int id;
  int product_id;
  String user_Name;
  String phoneNo;
  int amount;
  String? time;

  Bidder({
    required this.id,
    required this.product_id,
    required this.user_Name,
    required this.phoneNo,
    required this.amount,
    required this.time,
  });

  factory Bidder.fromMap(Map<String, dynamic> map) {
    return Bidder(
      id: int.parse(map['id']),
      product_id: int.parse(map['product_id']),
      user_Name: map['user_Name'],
      phoneNo: map['phoneNo'],
      amount: int.parse(map['amount']),
      time: map['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': product_id,
      'user_Name': user_Name,
      'phoneNo': phoneNo,
      'amount': amount,
      'time': time,
    };
  }

  String toJson() => json.encode(toMap());

  factory Bidder.fromJson(String source) {
    return Bidder.fromMap(json.decode(source));
  }
}

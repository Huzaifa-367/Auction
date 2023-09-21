import 'dart:convert';

class Bidder {
  int id;
  int product_id;
  String user_Name;
  String phoneNo;
  int amount;

  Bidder({
    required this.id,
    required this.product_id,
    required this.user_Name,
    required this.phoneNo,
    required this.amount,
  });

  Bidder copyWith({
    int? id,
    int? product_id,
    String? user_Name,
    String? phoneNo,
    int? amount,
  }) {
    return Bidder(
      id: id ?? this.id,
      product_id: product_id ?? this.product_id,
      user_Name: user_Name ?? this.user_Name,
      phoneNo: phoneNo ?? this.phoneNo,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'product_id': product_id});
    result.addAll({'user_Name': user_Name});
    result.addAll({'phoneNo': phoneNo});
    result.addAll({'amount': amount});

    return result;
  }

  factory Bidder.fromMap(Map<String, dynamic> map) {
    return Bidder(
      id: int.parse(map['id']) ?? 0,
      product_id: int.parse(map['product_id']) ?? 0,
      user_Name: map['user_Name'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      amount: int.parse(map['amount'].toString()) ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bidder.fromJson(String source) => Bidder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Bidder(id: $id, product_id: $product_id, user_Name: $user_Name, phoneNo: $phoneNo, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bidder &&
        other.id == id &&
        other.product_id == product_id &&
        other.user_Name == user_Name &&
        other.phoneNo == phoneNo &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        product_id.hashCode ^
        user_Name.hashCode ^
        phoneNo.hashCode ^
        amount.hashCode;
  }
}

import 'dart:convert';

class HighBidder {
  String user_Name;
  int amount;

  HighBidder({
    required this.user_Name,
    required this.amount,
  });

  HighBidder copyWith({
    String? user_Name,
    int? amount,
  }) {
    return HighBidder(
      user_Name: user_Name ?? this.user_Name,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'user_Name': user_Name});
    result.addAll({'amount': amount});

    return result;
  }

  factory HighBidder.fromMap(Map<String, dynamic> map) {
    return HighBidder(
      user_Name: map['user_Name'] ?? '',
      amount: map['amount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory HighBidder.fromJson(String source) =>
      HighBidder.fromMap(json.decode(source));

  @override
  String toString() => 'Bidder(user_Name: $user_Name, amount: $amount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HighBidder &&
        other.user_Name == user_Name &&
        other.amount == amount;
  }

  @override
  int get hashCode => user_Name.hashCode ^ amount.hashCode;
}

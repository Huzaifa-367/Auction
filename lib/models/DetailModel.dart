import 'dart:convert';

class Details {
  String? auctionCount;
  String? teleCount;
  String? totalProducts;
  String? totalSales;
  String auction_time;
  LastWeekSales? lastWeekSales;
  Details({
    this.auctionCount,
    this.teleCount,
    this.totalProducts,
    this.totalSales,
    required this.auction_time,
    this.lastWeekSales,
  });

  Details copyWith({
    String? auctionCount,
    String? teleCount,
    String? totalProducts,
    String? totalSales,
    String? auction_time,
    LastWeekSales? lastWeekSales,
  }) {
    return Details(
      auctionCount: auctionCount ?? this.auctionCount,
      teleCount: teleCount ?? this.teleCount,
      totalProducts: totalProducts ?? this.totalProducts,
      totalSales: totalSales ?? this.totalSales,
      auction_time: auction_time ?? this.auction_time,
      lastWeekSales: lastWeekSales ?? this.lastWeekSales,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (auctionCount != null) {
      result.addAll({'auctionCount': auctionCount});
    }
    if (teleCount != null) {
      result.addAll({'teleCount': teleCount});
    }
    if (totalProducts != null) {
      result.addAll({'totalProducts': totalProducts});
    }
    if (totalSales != null) {
      result.addAll({'totalSales': totalSales});
    }
    result.addAll({'auction_time': auction_time});
    if (lastWeekSales != null) {
      result.addAll({'lastWeekSales': lastWeekSales!.toMap()});
    }

    return result;
  }

  factory Details.fromMap(Map<String, dynamic> map) {
    return Details(
      auctionCount: map['auctionCount'],
      teleCount: map['teleCount'],
      totalProducts: map['totalProducts'],
      totalSales: map['totalSales'],
      auction_time: map['auction_time'] ?? '',
      lastWeekSales: map['lastWeekSales'] != null
          ? LastWeekSales.fromMap(map['lastWeekSales'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Details.fromJson(String source) =>
      Details.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Details(auctionCount: $auctionCount, teleCount: $teleCount, totalProducts: $totalProducts, totalSales: $totalSales, auction_time: $auction_time, lastWeekSales: $lastWeekSales)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Details &&
        other.auctionCount == auctionCount &&
        other.teleCount == teleCount &&
        other.totalProducts == totalProducts &&
        other.totalSales == totalSales &&
        other.auction_time == auction_time &&
        other.lastWeekSales == lastWeekSales;
  }

  @override
  int get hashCode {
    return auctionCount.hashCode ^
        teleCount.hashCode ^
        totalProducts.hashCode ^
        totalSales.hashCode ^
        auction_time.hashCode ^
        lastWeekSales.hashCode;
  }
}

class LastWeekSales {
  String? totalPrice;
  String? productCount;
  LastWeekSales({
    this.totalPrice,
    this.productCount,
  });

  LastWeekSales copyWith({
    String? totalPrice,
    String? productCount,
  }) {
    return LastWeekSales(
      totalPrice: totalPrice ?? this.totalPrice,
      productCount: productCount ?? this.productCount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (totalPrice != null) {
      result.addAll({'totalPrice': totalPrice});
    }
    if (productCount != null) {
      result.addAll({'productCount': productCount});
    }

    return result;
  }

  factory LastWeekSales.fromMap(Map<String, dynamic> map) {
    return LastWeekSales(
      totalPrice: map['totalPrice'],
      productCount: map['productCount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LastWeekSales.fromJson(String source) =>
      LastWeekSales.fromMap(json.decode(source));

  @override
  String toString() =>
      'LastWeekSales(totalPrice: $totalPrice, productCount: $productCount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LastWeekSales &&
        other.totalPrice == totalPrice &&
        other.productCount == productCount;
  }

  @override
  int get hashCode => totalPrice.hashCode ^ productCount.hashCode;
}

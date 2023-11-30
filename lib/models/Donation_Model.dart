import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Donation {
  String donorName;
  String retailvalue;
  String description;
  String? date;
  bool? isAnounced;
  int id;
  Donation(
      {required this.donorName,
      required this.retailvalue,
      required this.description,
      this.date,
      required this.id,
      this.isAnounced});

  Donation copyWith({
    String? donorName,
    String? retailvalue,
    String? description,
    String? date,
    int? id,
    bool? isAnounced,
  }) {
    return Donation(
      donorName: donorName ?? this.donorName,
      retailvalue: retailvalue ?? this.retailvalue,
      description: description ?? this.description,
      date: date ?? this.date,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'donorName': donorName});
    result.addAll({'retailvalue': retailvalue});
    result.addAll({'description': description});
    if (date != null) {
      result.addAll({'date': date});
    }
    result.addAll({'id': id});

    return result;
  }

  factory Donation.fromMap(Map<String, dynamic> map) {
    return Donation(
      donorName: map['donorName'] ?? '',
      retailvalue: map['retailvalue'] ?? '',
      description: map['description'] ?? '',
      date: map['date'],
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Donation.fromJson(String source) =>
      Donation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Donation(donorName: $donorName, retailvalue: $retailvalue, description: $description, date: $date, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Donation &&
        other.donorName == donorName &&
        other.retailvalue == retailvalue &&
        other.description == description &&
        other.date == date &&
        other.id == id;
  }

  @override
  int get hashCode {
    return donorName.hashCode ^
        retailvalue.hashCode ^
        description.hashCode ^
        date.hashCode ^
        id.hashCode;
  }
}

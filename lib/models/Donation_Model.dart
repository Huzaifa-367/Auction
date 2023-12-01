import 'dart:convert';

class donate {
  String? id;
  String? retailvalue;
  String? donorName;
  String? description;
  String? date;
  String? isAnounced;

  donate(
    this.id,
    this.retailvalue,
    this.donorName,
    this.description,
    this.date,
    this.isAnounced,
  );

  donate copyWith({
    String? id,
    String? retailvalue,
    String? donorName,
    String? description,
    String? date,
    String? isAnounced,
  }) {
    return donate(
      id ?? this.id,
      retailvalue ?? this.retailvalue,
      donorName ?? this.donorName,
      description ?? this.description,
      date ?? this.date,
      isAnounced ?? this.isAnounced,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (retailvalue != null) {
      result.addAll({'retailvalue': retailvalue});
    }
    if (donorName != null) {
      result.addAll({'donorName': donorName});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (date != null) {
      result.addAll({'date': date});
    }
    if (isAnounced != null) {
      result.addAll({'isAnounced': isAnounced});
    }

    return result;
  }

  factory donate.fromMap(Map<String, dynamic> map) {
    return donate(
      map['id'],
      map['retailvalue'],
      map['donorName'],
      map['description'],
      map['date'],
      map['isAnounced'],
    );
  }

  String toJson() => json.encode(toMap());

  factory donate.fromJson(String source) => donate.fromMap(json.decode(source));

  @override
  String toString() {
    return 'donate(id: $id, retailvalue: $retailvalue, donorName: $donorName, description: $description, date: $date, isAnounced: $isAnounced)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is donate &&
        other.id == id &&
        other.retailvalue == retailvalue &&
        other.donorName == donorName &&
        other.description == description &&
        other.date == date &&
        other.isAnounced == isAnounced;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        retailvalue.hashCode ^
        donorName.hashCode ^
        description.hashCode ^
        date.hashCode ^
        isAnounced.hashCode;
  }
}

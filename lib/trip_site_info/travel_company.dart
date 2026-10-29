import 'package:cloud_firestore/cloud_firestore.dart';

class TravelCompany {
  final String id;
  final String name;
  final double rating;
  final String tripDate;
  final String tripType;
  final double price;
  final int spotsAvailable;

  const TravelCompany({
    required this.id,
    required this.name,
    required this.rating,
    required this.tripDate,
    required this.tripType,
    required this.price,
    required this.spotsAvailable,
  });

  factory TravelCompany.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) => TravelCompany.fromMap(snapshot.id, snapshot.data() ?? const {});

  factory TravelCompany.fromMap(String id, Map<String, dynamic> data) {
    return TravelCompany(
      id: id,
      name: data['name'] as String? ?? '',
      rating: (data['rating'] as num?)?.toDouble() ?? 0,
      tripDate: data['tripDate'] as String? ?? '',
      tripType: data['tripType'] as String? ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0,
      spotsAvailable: (data['spotsAvailable'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'name': name,
    'rating': rating,
    'tripDate': tripDate,
    'tripType': tripType,
    'price': price,
    'spotsAvailable': spotsAvailable,
  };
}

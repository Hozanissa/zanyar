import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SiteReview {
  final String author;
  final double rating;
  final String comment;
  final String date;

  const SiteReview({
    required this.author,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

class HistoricalSite {
  final String id;
  final String name;
  final String kurdishName;
  final String city;
  final String category;
  final String description;
  final String kurdishDescription;
  final String hours;
  final String period;
  final String entry;
  final String status;
  final double rating;
  final int reviewCount;
  final List<SiteReview> reviews;
  final IconData icon;
  final double lat;
  final double lng;
  final List<String> imageUrls;

  const HistoricalSite({
    required this.id,
    required this.name,
    required this.kurdishName,
    required this.city,
    required this.category,
    required this.description,
    this.kurdishDescription = '',
    required this.hours,
    required this.period,
    required this.entry,
    required this.status,
    required this.rating,
    required this.reviewCount,
    required this.reviews,
    required this.icon,
    required this.lat,
    required this.lng,
    this.imageUrls = const [],
  });

  factory HistoricalSite.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) => HistoricalSite.fromMap(snapshot.id, snapshot.data() ?? const {});

  factory HistoricalSite.fromMap(String id, Map<String, dynamic> data) {
    final category = data['category'] as String? ?? 'Heritage';
    return HistoricalSite(
      id: id,
      name: data['name'] as String? ?? '',
      kurdishName: data['kurdishName'] as String? ?? '',
      city: data['city'] as String? ?? '',
      category: category,
      description: data['description'] as String? ?? '',
      kurdishDescription: data['kurdishDescription'] as String? ?? '',
      hours: data['hours'] as String? ?? '',
      period: data['period'] as String? ?? '',
      entry: data['entry'] as String? ?? '',
      status: data['status'] as String? ?? '',
      rating: (data['rating'] as num?)?.toDouble() ?? 0,
      reviewCount: (data['reviewCount'] as num?)?.toInt() ?? 0,
      reviews: const [],
      icon: _siteIcon(category),
      lat: (data['lat'] as num?)?.toDouble() ?? 0,
      lng: (data['lng'] as num?)?.toDouble() ?? 0,
      imageUrls: (data['imageUrls'] as List<dynamic>? ?? const [])
          .whereType<String>()
          .toList(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'name': name,
    'kurdishName': kurdishName,
    'city': city,
    'category': category,
    'description': description,
    'kurdishDescription': kurdishDescription,
    'hours': hours,
    'period': period,
    'entry': entry,
    'status': status,
    'lat': lat,
    'lng': lng,
    'imageUrls': imageUrls,
  };

  static IconData _siteIcon(String category) => switch (category.toLowerCase()) {
    'citadel' => Icons.account_balance,
    'sanctuary' => Icons.temple_buddhist,
    'cave' => Icons.landscape,
    'castle' => Icons.castle,
    _ => Icons.museum,
  };

  String get localizedName {
    final lang = Get.locale?.languageCode ?? 'en';
    if (lang == 'ckb' && kurdishName.isNotEmpty) return kurdishName;
    return name;
  }

  String get localizedDescription {
    final lang = Get.locale?.languageCode ?? 'en';
    if (lang == 'ckb' && kurdishDescription.isNotEmpty) return kurdishDescription;
    return description;
  }
}

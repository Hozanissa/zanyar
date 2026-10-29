import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zanyar/trip_site_info/site_model.dart';
import 'package:zanyar/trip_site_info/travel_company.dart';

class TripBooking {
  final String id;
  final HistoricalSite site;
  final TravelCompany company;
  final DateTime bookedAt;
  final String paymentStatus;

  TripBooking({
    this.id = '',
    required this.site,
    required this.company,
    required this.bookedAt,
    this.paymentStatus = 'payment_pending',
  });

  Map<String, dynamic> toFirestore() => {
    'siteId': site.id,
    'siteName': site.name,
    'companyId': company.id,
    'companyName': company.name,
    'tripDate': company.tripDate,
    'tripType': company.tripType,
    'price': company.price,
    'bookedAt': Timestamp.fromDate(bookedAt),
    'paymentStatus': paymentStatus,
  };

  factory TripBooking.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data() ?? const <String, dynamic>{};
    return TripBooking(
      id: snapshot.id,
      site: HistoricalSite.fromMap(data['siteId'] as String? ?? '', {
        'name': data['siteName'] as String? ?? '',
      }),
      company: TravelCompany.fromMap(data['companyId'] as String? ?? '', {
        'name': data['companyName'] as String? ?? '',
        'tripDate': data['tripDate'] as String? ?? '',
        'tripType': data['tripType'] as String? ?? '',
        'price': data['price'] as num? ?? 0,
      }),
      bookedAt: (data['bookedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      paymentStatus: data['paymentStatus'] as String? ?? 'pending',
    );
  }
}

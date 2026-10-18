import 'package:zanyar_app/trip_site_info/site_model.dart';
import 'package:zanyar_app/trip_site_info/travel_company.dart';

class TripBooking {
  final HistoricalSite site;
  final TravelCompany company;
  final DateTime bookedAt;

  TripBooking({
    required this.site,
    required this.company,
    required this.bookedAt,
  });
}

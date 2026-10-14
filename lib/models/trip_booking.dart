import 'package:zanyar_app/models/site_model.dart';
import 'package:zanyar_app/models/travel_company.dart';

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

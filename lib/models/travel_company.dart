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
}

const List<TravelCompany> kTravelCompanies = [
  TravelCompany(
    id: 'kurdistan_tours',
    name: 'Kurdistan Tours Co.',
    rating: 4.6,
    tripDate: 'Sat, Nov 1',
    tripType: 'Full day',
    price: 25,
    spotsAvailable: 4,
  ),
  TravelCompany(
    id: 'zagros_travel',
    name: 'Zagros Travel',
    rating: 4.2,
    tripDate: 'Sun, Nov 2',
    tripType: 'Half day',
    price: 22,
    spotsAvailable: 8,
  ),
  TravelCompany(
    id: 'hawler_journeys',
    name: 'Hawler Journeys',
    rating: 4.8,
    tripDate: 'Fri, Nov 7',
    tripType: 'Full day',
    price: 30,
    spotsAvailable: 2,
  ),
  TravelCompany(
    id: 'sipan_adventures',
    name: 'Sipan Adventures',
    rating: 4.3,
    tripDate: 'Sat, Nov 8',
    tripType: 'Full day',
    price: 28,
    spotsAvailable: 6,
  ),
];

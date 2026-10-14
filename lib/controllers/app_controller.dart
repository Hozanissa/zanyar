import 'package:get/get.dart';
import 'package:zanyar_app/models/site_model.dart';
import 'package:zanyar_app/models/trip_booking.dart';

class AppNotification {
  final String message;
  final DateTime time;
  AppNotification({required this.message, required this.time});
}

class AppController extends GetxController {
  final RxList<String> favoriteSiteIds = <String>[].obs;
  final RxList<TripBooking> bookings = <TripBooking>[].obs;
  final RxList<AppNotification> notifications = <AppNotification>[].obs;

  bool isFavorite(String siteId) => favoriteSiteIds.contains(siteId);

  void toggleFavorite(HistoricalSite site) {
    if (isFavorite(site.id)) {
      favoriteSiteIds.remove(site.id);
      _notify('favorite_removed_notif'.trParams({'site': site.localizedName}));
    } else {
      favoriteSiteIds.add(site.id);
      _notify('favorite_added_notif'.trParams({'site': site.localizedName}));
    }
  }

  void addBooking(TripBooking booking) {
    bookings.insert(0, booking);
    _notify(
      'trip_booked_notif'.trParams({
        'site': booking.site.localizedName,
        'company': booking.company.name.tr,
        'date': booking.company.tripDate,
      }),
    );
  }

  void cancelBooking(TripBooking booking) {
    bookings.remove(booking);
    _notify(
      'trip_cancelled_notif'.trParams({
        'site': booking.site.localizedName,
        'company': booking.company.name.tr,
      }),
    );
  }

  void _notify(String message) {
    notifications.insert(0, AppNotification(message: message, time: DateTime.now()));
  }
}

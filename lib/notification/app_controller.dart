import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:zanyar/trip_site_info/site_model.dart';
import 'package:zanyar/trip_site_info/trip_booking.dart';

class AppNotification {
  final String id;
  final String message;
  final DateTime time;
  AppNotification({required this.id, required this.message, required this.time});
}

class AppController extends GetxController {
  final RxList<String> favoriteSiteIds = <String>[].obs;
  final RxList<TripBooking> bookings = <TripBooking>[].obs;
  final RxList<AppNotification> notifications = <AppNotification>[].obs;

  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _favoritesSubscription;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _bookingsSubscription;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _notificationsSubscription;
  String? _userId;

  @override
  void onInit() {
    super.onInit();
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen(_bindUser);
  }

  void _bindUser(User? user) {
    _favoritesSubscription?.cancel();
    _bookingsSubscription?.cancel();
    _notificationsSubscription?.cancel();
    _userId = user?.uid;
    favoriteSiteIds.clear();
    bookings.clear();
    notifications.clear();
    if (user == null) return;

    final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    _favoritesSubscription = userRef.collection('favorites').snapshots().listen(
      (snapshot) => favoriteSiteIds.assignAll(snapshot.docs.map((doc) => doc.id)),
    );
    _bookingsSubscription = userRef.collection('bookings').snapshots().listen(
      (snapshot) => bookings.assignAll(
        snapshot.docs.map(TripBooking.fromFirestore).toList()
          ..sort((a, b) => b.bookedAt.compareTo(a.bookedAt)),
      ),
    );
    _notificationsSubscription = userRef
        .collection('notifications')
        .orderBy('time', descending: true)
        .snapshots()
        .listen((snapshot) {
          notifications.assignAll(snapshot.docs.map((doc) {
            final data = doc.data();
            return AppNotification(
              id: doc.id,
              message: data['message'] as String? ?? '',
              time: (data['time'] as Timestamp?)?.toDate() ?? DateTime.now(),
            );
          }));
        });
  }

  bool isFavorite(String siteId) => favoriteSiteIds.contains(siteId);

  Future<void> toggleFavorite(HistoricalSite site) async {
    final userId = _userId;
    if (userId == null) return;
    final favoriteRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(site.id);
    if (isFavorite(site.id)) {
      favoriteSiteIds.remove(site.id);
      await favoriteRef.delete();
      await _notify('favorite_removed_notif'.trParams({'site': site.localizedName}));
    } else {
      favoriteSiteIds.add(site.id);
      await favoriteRef.set({'siteId': site.id, 'createdAt': FieldValue.serverTimestamp()});
      await _notify('favorite_added_notif'.trParams({'site': site.localizedName}));
    }
  }

  Future<void> addBooking(TripBooking booking) async {
    final userId = _userId;
    if (userId == null) throw StateError('Sign in before creating a booking.');
    final reference = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('bookings')
        .add(booking.toFirestore());
    bookings.insert(0, TripBooking(
      id: reference.id,
      site: booking.site,
      company: booking.company,
      bookedAt: booking.bookedAt,
      paymentStatus: booking.paymentStatus,
    ));
    if (booking.paymentStatus == 'paid') {
      await _notify(
        'trip_booked_notif'.trParams({
          'site': booking.site.localizedName,
          'company': booking.company.name.tr,
          'date': booking.company.tripDate,
        }),
      );
    }
  }

  Future<void> cancelBooking(TripBooking booking) async {
    final userId = _userId;
    bookings.remove(booking);
    if (userId != null && booking.id.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('bookings')
          .doc(booking.id)
          .delete();
    }
    await _notify(
      'trip_cancelled_notif'.trParams({
        'site': booking.site.localizedName,
        'company': booking.company.name.tr,
      }),
    );
  }

  Future<void> _notify(String message) async {
    final userId = _userId;
    if (userId == null) return;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .add({'message': message, 'time': FieldValue.serverTimestamp()});
  }

  @override
  void onClose() {
    _authSubscription?.cancel();
    _favoritesSubscription?.cancel();
    _bookingsSubscription?.cancel();
    _notificationsSubscription?.cancel();
    super.onClose();
  }
}

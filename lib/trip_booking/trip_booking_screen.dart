import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanyar_app/notification/app_controller.dart';
import 'package:zanyar_app/trip_booking/booking_confirmed_screen.dart';
import 'package:zanyar_app/trip_site_info/site_model.dart';
import 'package:zanyar_app/trip_site_info/travel_company.dart';
import 'package:zanyar_app/trip_site_info/trip_booking.dart';

const Color _teal = Color(0xFF1F4E4C);
const Color _terracotta = Color(0xFFC4704B);
const Color _cream = Color(0xFFF9F6F0);

class TripBookingScreen extends StatefulWidget {
  final HistoricalSite site;
  const TripBookingScreen({super.key, required this.site});

  @override
  State<TripBookingScreen> createState() => _TripBookingScreenState();
}

class _TripBookingScreenState extends State<TripBookingScreen> {
  TravelCompany? _selected;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF141918) : _cream;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1A2220) : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: isDark ? Colors.white : _teal,
          onPressed: () => Get.back(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'trip_booking'.tr.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.grey[400] : _terracotta,
              ),
            ),
            Text(
              widget.site.localizedName,
              style: GoogleFonts.lora(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : _teal,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'available_trips'.tr.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
                color: isDark ? Colors.grey[500] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: kTravelCompanies.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final company = kTravelCompanies[i];
                  final isSelected = _selected?.id == company.id;
                  return _CompanyCard(
                    company: company,
                    isSelected: isSelected,
                    isDark: isDark,
                    onTap: () => setState(() => _selected = company),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: _selected == null
                  ? null
                  : () {
                      final appCtrl = Get.find<AppController>();
                      appCtrl.addBooking(
                        TripBooking(
                          site: widget.site,
                          company: _selected!,
                          bookedAt: DateTime.now(),
                        ),
                      );
                      Get.off(
                        () => BookingConfirmedScreen(
                          site: widget.site,
                          company: _selected!,
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: _selected == null
                    ? (isDark ? Colors.grey[800] : Colors.grey[300])
                    : _teal,
                foregroundColor: _selected == null
                    ? Colors.grey[500]
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text(
                _selected == null
                    ? 'select_trip_above'.tr
                    : 'confirm_booking'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CompanyCard extends StatelessWidget {
  final TravelCompany company;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _CompanyCard({
    required this.company,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C2422) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? _teal : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? _teal.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        company.name.tr,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          ..._buildStars(company.rating),
                          const SizedBox(width: 4),
                          Text(
                            '${company.rating}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: _terracotta,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  '\$${company.price.toInt()}',
                  style: GoogleFonts.lora(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _teal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 13,
                  color: isDark ? Colors.grey[400] : Colors.grey[500],
                ),
                const SizedBox(width: 4),
                Text(
                  company.tripDate,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 14),
                Icon(
                  Icons.access_time,
                  size: 13,
                  color: isDark ? Colors.grey[400] : Colors.grey[500],
                ),
                const SizedBox(width: 4),
                Text(
                  company.tripType.tr,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: company.spotsAvailable <= 3
                        ? Colors.red.withValues(alpha: 0.12)
                        : _teal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${company.spotsAvailable} ${'spots_available'.tr}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: company.spotsAvailable <= 3 ? Colors.red : _teal,
                    ),
                  ),
                ),
              ],
            ),
            if (isSelected) ...[
              const SizedBox(height: 10),
              const Divider(),
              Row(
                children: [
                  const Icon(Icons.check_circle, color: _teal, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'selected'.tr,
                    style: const TextStyle(
                      color: _teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStars(double r) {
    return List.generate(5, (i) {
      if (i < r.floor()) {
        return const Icon(Icons.star, color: _terracotta, size: 14);
      }
      if (i < r) {
        return const Icon(Icons.star_half, color: _terracotta, size: 14);
      }
      return const Icon(Icons.star_border, color: _terracotta, size: 14);
    });
  }
}

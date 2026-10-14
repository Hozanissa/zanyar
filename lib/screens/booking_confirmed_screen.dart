import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanyar_app/main_screens/home_screen.dart';
import 'package:zanyar_app/models/site_model.dart';
import 'package:zanyar_app/models/travel_company.dart';

const Color _teal = Color(0xFF1F4E4C);
const Color _terracotta = Color(0xFFC4704B);

class BookingConfirmedScreen extends StatelessWidget {
  final HistoricalSite site;
  final TravelCompany company;
  const BookingConfirmedScreen({
    super.key,
    required this.site,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF141918) : const Color(0xFFF9F6F0);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Success icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: _teal.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle, color: _teal, size: 56),
              ),
              const SizedBox(height: 24),
              Text(
                'booking_confirmed'.tr,
                style: GoogleFonts.lora(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : _teal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'booking_confirmed_sub'.tr,
                style: TextStyle(
                  fontSize: 15,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Booking summary card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1C2422) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.07),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _Row(
                      label: 'site'.tr,
                      value: site.localizedName,
                      isDark: isDark,
                      icon: Icons.place,
                    ),
                    const SizedBox(height: 12),
                    _Row(
                      label: 'company'.tr,
                      value: company.name.tr,
                      isDark: isDark,
                      icon: Icons.business,
                    ),
                    const SizedBox(height: 12),
                    _Row(
                      label: 'date'.tr,
                      value: company.tripDate,
                      isDark: isDark,
                      icon: Icons.calendar_today,
                    ),
                    const SizedBox(height: 12),
                    _Row(
                      label: 'trip_type'.tr,
                      value: company.tripType.tr,
                      isDark: isDark,
                      icon: Icons.access_time,
                    ),
                    const SizedBox(height: 12),
                    _Row(
                      label: 'price'.tr,
                      value: '\$${company.price.toInt()}',
                      isDark: isDark,
                      icon: Icons.payments,
                      valueColor: _terracotta,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              // Back to home button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => HomeScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: Text(
                    'back_to_home'.tr,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool isDark;
  final Color? valueColor;

  const _Row({
    required this.label,
    required this.value,
    required this.icon,
    required this.isDark,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: _terracotta),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: valueColor ?? (isDark ? Colors.white : Colors.black87),
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

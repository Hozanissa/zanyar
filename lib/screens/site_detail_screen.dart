import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanyar_app/controllers/app_controller.dart';
import 'package:zanyar_app/models/site_model.dart';
import 'package:zanyar_app/screens/trip_booking_screen.dart';

const Color _teal = Color(0xFF1F4E4C);
const Color _terracotta = Color(0xFFC4704B);

class SiteDetailScreen extends StatelessWidget {
  final HistoricalSite site;
  const SiteDetailScreen({super.key, required this.site});

  @override
  Widget build(BuildContext context) {
    final appCtrl = Get.find<AppController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF141918) : const Color(0xFFF9F6F0);

    return Scaffold(
      backgroundColor: bg,
      body: CustomScrollView(
        slivers: [
          // ── Hero App Bar ──────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: _teal,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.35),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
              onPressed: () => Get.back(),
            ),
            actions: [
              // Favorite button
              Obx(
                () => IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.35),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      appCtrl.isFavorite(site.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: appCtrl.isFavorite(site.id) ? Colors.red : Colors.white,
                      size: 20,
                    ),
                  ),
                  onPressed: () => appCtrl.toggleFavorite(site),
                ),
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _HeroImage(site: site),
            ),
          ),

          // ── Body ─────────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category badge + name
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _teal.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      site.category.tr,
                      style: const TextStyle(
                          color: _teal, fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    site.localizedName,
                    style: GoogleFonts.lora(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : _teal,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Location + rating row
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: _terracotta),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          site.city.tr,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ),
                      ..._buildStars(site.rating),
                      const SizedBox(width: 4),
                      Text(
                        '${site.rating}  (${site.reviewCount})',
                        style: const TextStyle(
                          fontSize: 13,
                          color: _terracotta,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    site.localizedDescription,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.65,
                      color: isDark ? Colors.grey[300] : Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Info grid ──────────────────────────────────────────
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 2.6,
                    children: [
                      _InfoTile(
                        icon: Icons.access_time,
                        label: 'hours'.tr,
                        value: site.hours.tr,
                        isDark: isDark,
                      ),
                      _InfoTile(
                        icon: Icons.confirmation_number,
                        label: 'entry'.tr,
                        value: site.entry.tr,
                        isDark: isDark,
                      ),
                      _InfoTile(
                        icon: Icons.history,
                        label: 'period'.tr,
                        value: site.period.tr,
                        isDark: isDark,
                      ),
                      _InfoTile(
                        icon: Icons.star,
                        label: 'status'.tr,
                        value: site.status.tr,
                        isDark: isDark,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // ── Map placeholder ────────────────────────────────────
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      height: 160,
                      color: isDark ? const Color(0xFF1E2724) : const Color(0xFFDDE8DD),
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.map, size: 48,
                                    color: _teal.withValues(alpha: 0.4)),
                                const SizedBox(height: 4),
                                Text(
                                  '${site.lat.toStringAsFixed(4)}, ${site.lng.toStringAsFixed(4)}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? Colors.grey[500] : Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: _teal,
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 8),
                                  elevation: 2,
                                ),
                                icon: const Icon(Icons.map_outlined, size: 16),
                                label: Text('open_map'.tr,
                                    style: const TextStyle(fontSize: 13)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ── Reviews ────────────────────────────────────────────
                  Text(
                    'reviews'.tr.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                      color: isDark ? Colors.grey[500] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...site.reviews.map((r) => _ReviewCard(review: r, isDark: isDark)),

                  const SizedBox(height: 100), // padding for bottom button
                ],
              ),
            ),
          ),
        ],
      ),

      // ── Join a trip button ──────────────────────────────────────────────
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: () => Get.to(() => TripBookingScreen(site: site)),
              style: ElevatedButton.styleFrom(
                backgroundColor: _teal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: Text(
                'join_a_trip'.tr,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildStars(double r) {
    return List.generate(5, (i) {
      if (i < r.floor()) return const Icon(Icons.star, color: _terracotta, size: 15);
      if (i < r) return const Icon(Icons.star_half, color: _terracotta, size: 15);
      return const Icon(Icons.star_border, color: _terracotta, size: 15);
    });
  }
}

// ── Hero Image ──────────────────────────────────────────────────────────────────

class _HeroImage extends StatelessWidget {
  final HistoricalSite site;
  const _HeroImage({required this.site});

  static final Map<String, List<Color>> _grads = {
    'Citadel':  [Color(0xFF2E5E5B), Color(0xFF8BA888)],
    'Sanctuary':[Color(0xFF3D4B6B), Color(0xFF7B90B2)],
    'Cave':     [Color(0xFF4A3728), Color(0xFF8C7B6A)],
    'Castle':   [Color(0xFF2C3E40), Color(0xFF6B8C6A)],
    'Heritage': [Color(0xFF4A3218), Color(0xFF9C7A48)],
  };

  @override
  Widget build(BuildContext context) {
    final colors = _grads[site.category] ?? [const Color(0xFF2E5E5B), const Color(0xFF6B8C6A)];
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
          ),
        ),
        if (site.imageUrls.isNotEmpty)
          Image.network(
            site.imageUrls.first,
            fit: BoxFit.cover,
            loadingBuilder: (_, c, p) => p == null ? c : const SizedBox.shrink(),
            errorBuilder: (_, _, _) => const SizedBox.shrink(),
          ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withValues(alpha: 0.5)],
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 20,
          child: Text(
            site.name,
            style: GoogleFonts.lora(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              shadows: [const Shadow(blurRadius: 8, color: Colors.black54)],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Info Tile ───────────────────────────────────────────────────────────────────

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isDark;
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C2422) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: _terracotta),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                      color: isDark ? Colors.grey[500] : Colors.grey[500],
                    )),
                Text(value,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF1F4E4C),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Review Card ─────────────────────────────────────────────────────────────────

class _ReviewCard extends StatelessWidget {
  final SiteReview review;
  final bool isDark;
  const _ReviewCard({required this.review, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C2422) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: _teal.withValues(alpha: 0.15),
                child: Text(
                  review.author[0],
                  style: const TextStyle(
                    color: _teal, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.author,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: isDark ? Colors.white : Colors.black87,
                        )),
                    Text(review.date,
                        style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (i) {
                  return Icon(
                    i < review.rating.floor() ? Icons.star : Icons.star_border,
                    size: 14,
                    color: _terracotta,
                  );
                }),
              ),
              const SizedBox(width: 4),
              Text(
                '${review.rating.toInt()}',
                style: const TextStyle(
                  fontSize: 13, color: _terracotta, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review.comment,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: isDark ? Colors.grey[300] : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

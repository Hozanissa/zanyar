import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanyar/main_screens/map_screen.dart' show MapScreen;
import 'package:zanyar/notification/app_controller.dart';
import 'package:zanyar/trip_booking/trip_booking_screen.dart';
import 'package:zanyar/trip_site_info/site_model.dart';

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
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
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
                      color: appCtrl.isFavorite(site.id)
                          ? Colors.red
                          : Colors.white,
                      size: 20,
                    ),
                  ),
                  onPressed: () => appCtrl.toggleFavorite(site),
                ),
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(background: _HeroImage(site: site)),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _teal.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      site.category.tr,
                      style: const TextStyle(
                        color: _teal,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
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
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: _terracotta,
                      ),
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
                      _ReviewSummary(siteId: site.id),
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
                      color: isDark
                          ? const Color(0xFF1E2724)
                          : const Color(0xFFDDE8DD),
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.map,
                                  size: 48,
                                  color: _teal.withValues(alpha: 0.4),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${site.lat.toStringAsFixed(4)}, ${site.lng.toStringAsFixed(4)}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark
                                        ? Colors.grey[500]
                                        : Colors.grey[600],
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
                                onPressed: () => Get.to(
                                  () => MapScreen(initialSiteId: site.id),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: _teal,
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 8,
                                  ),
                                  elevation: 2,
                                ),
                                icon: const Icon(Icons.map_outlined, size: 16),
                                label: Text(
                                  'open_map'.tr,
                                  style: const TextStyle(fontSize: 13),
                                ),
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
                  _SiteReviewSection(siteId: site.id, isDark: isDark),

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
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text(
                'join_a_trip'.tr,
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

class _ReviewSummary extends StatelessWidget {
  final String siteId;
  const _ReviewSummary({required this.siteId});

  @override
  Widget build(BuildContext context) => StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('sites')
        .doc(siteId)
        .collection('reviews')
        .snapshots(),
    builder: (context, snapshot) {
      final reviews = snapshot.data?.docs ?? [];
      final count = reviews.length;
      final average = count == 0
          ? 0.0
          : reviews.fold<double>(
                  0,
                  (sum, doc) => sum + ((doc.data()['rating'] as num?)?.toDouble() ?? 0),
                ) /
                count;
      return Text(
        count == 0 ? 'No ratings' : '${average.toStringAsFixed(1)} ($count)',
        style: const TextStyle(
          fontSize: 13,
          color: _terracotta,
          fontWeight: FontWeight.w600,
        ),
      );
    },
  );
}

class _SiteReviewSection extends StatefulWidget {
  final String siteId;
  final bool isDark;
  const _SiteReviewSection({required this.siteId, required this.isDark});

  @override
  State<_SiteReviewSection> createState() => _SiteReviewSectionState();
}

class _SiteReviewSectionState extends State<_SiteReviewSection> {
  final _commentController = TextEditingController();
  double _rating = 5;
  bool _saving = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final user = FirebaseAuth.instance.currentUser;
    final comment = _commentController.text.trim();
    if (user == null) {
      Get.snackbar('Sign in required', 'Please sign in to leave a review.');
      return;
    }
    if (comment.isEmpty) {
      Get.snackbar('Review required', 'Write a comment before submitting.');
      return;
    }
    setState(() => _saving = true);
    try {
      final userProfile = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final profile = userProfile.data() ?? const <String, dynamic>{};
      final first = profile['firstName'] as String? ?? '';
      final last = profile['lastName'] as String? ?? '';
      final author = '$first $last'.trim().isEmpty
          ? (user.displayName ?? user.email ?? 'User')
          : '$first $last'.trim();
      await FirebaseFirestore.instance
          .collection('sites')
          .doc(widget.siteId)
          .collection('reviews')
          .doc(user.uid)
          .set({
            'userId': user.uid,
            'author': author,
            'rating': _rating,
            'comment': comment,
            'createdAt': FieldValue.serverTimestamp(),
          });
      if (!mounted) return;
      _commentController.clear();
      Get.snackbar('Review saved', 'Your review is now visible.');
    } on FirebaseException catch (error) {
      Get.snackbar('Could not save review', error.message ?? error.code);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('sites')
            .doc(widget.siteId)
            .collection('reviews')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Could not load reviews: ${snapshot.error}');
          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text('No reviews yet. Be the first to share your experience.', style: TextStyle(color: Colors.grey[600])),
            );
          }
          return Column(
            children: docs.map((doc) {
              final data = doc.data();
              final createdAt = data['createdAt'];
              final date = createdAt is Timestamp
                  ? '${createdAt.toDate().year}-${createdAt.toDate().month.toString().padLeft(2, '0')}'
                  : 'Just now';
              return _ReviewCard(
                review: SiteReview(
                  author: data['author'] as String? ?? 'User',
                  rating: (data['rating'] as num?)?.toDouble() ?? 0,
                  comment: data['comment'] as String? ?? '',
                  date: date,
                ),
                isDark: widget.isDark,
              );
            }).toList(),
          );
        },
      ),
      const SizedBox(height: 8),
      Text('Your rating', style: TextStyle(fontWeight: FontWeight.bold, color: widget.isDark ? Colors.white : Colors.black87)),
      Row(
        children: List.generate(5, (index) => IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: () => setState(() => _rating = index + 1.0),
          icon: Icon(index < _rating ? Icons.star : Icons.star_border, color: _terracotta),
        )),
      ),
      TextField(
        controller: _commentController,
        minLines: 2,
        maxLines: 4,
        decoration: const InputDecoration(
          labelText: 'Write your review',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      Align(
        alignment: AlignmentDirectional.centerEnd,
        child: FilledButton.icon(
          onPressed: _saving ? null : _submit,
          icon: _saving
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.send),
          label: const Text('Submit review'),
        ),
      ),
    ],
  );
}

// ── Hero Image ──────────────────────────────────────────────────────────────────

class _HeroImage extends StatelessWidget {
  final HistoricalSite site;
  const _HeroImage({required this.site});

  static final Map<String, List<Color>> _grads = {
    'Citadel': [Color(0xFF2E5E5B), Color(0xFF8BA888)],
    'Sanctuary': [Color(0xFF3D4B6B), Color(0xFF7B90B2)],
    'Cave': [Color(0xFF4A3728), Color(0xFF8C7B6A)],
    'Castle': [Color(0xFF2C3E40), Color(0xFF6B8C6A)],
    'Heritage': [Color(0xFF4A3218), Color(0xFF9C7A48)],
  };

  @override
  Widget build(BuildContext context) {
    final colors =
        _grads[site.category] ??
        [const Color(0xFF2E5E5B), const Color(0xFF6B8C6A)];
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
            loadingBuilder: (_, c, p) =>
                p == null ? c : const SizedBox.shrink(),
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
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                    color: isDark ? Colors.grey[500] : Colors.grey[500],
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF1F4E4C),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
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
                    color: _teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.author,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    Text(
                      review.date,
                      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                    ),
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
                  fontSize: 13,
                  color: _terracotta,
                  fontWeight: FontWeight.bold,
                ),
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

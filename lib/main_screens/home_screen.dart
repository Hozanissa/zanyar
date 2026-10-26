import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanyar_app/bnb.dart';
import 'package:zanyar_app/trip_site_info/site_model.dart';
import 'package:zanyar_app/notification/app_controller.dart';
import 'package:zanyar_app/trip_booking/site_detail_screen.dart';
import 'package:zanyar_app/widgets/auth_toggles.dart';

const Color _teal = Color(0xFF1F4E4C);
const Color _terracotta = Color(0xFFC4704B);
const Color _cream = Color(0xFFF9F6F0);
const Color _darkBg = Color(0xFF141918);

class HomeScreen extends StatefulWidget {
  static String savedData = "";
  static String savedPass = "";

  final String getData;
  final String getPass;

  HomeScreen({super.key, this.getData = "", this.getPass = ""}) {
    if (getData.isNotEmpty) savedData = getData;
    if (getPass.isNotEmpty) savedPass = getPass;
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchCtrl = TextEditingController();
  String _search = '';
  String _selectedCity = 'All';

  final List<String> _cities = [
    'All',
    'Erbil',
    'Duhok',
    'Sulaymaniyah',
    'Erbil (Bradost)',
    'Shekhan (Duhok)',
    'Kalar (Garmian)',
  ];

  List<HistoricalSite> get _filtered {
    return kAllSites.where((s) {
      final matchCity = _selectedCity == 'All' || s.city == _selectedCity;
      final q = _search.toLowerCase().trim();
      final matchSearch =
          q.isEmpty ||
          s.name.toLowerCase().contains(q) ||
          s.kurdishName.toLowerCase().contains(q) ||
          s.category.toLowerCase().contains(q) ||
          s.category.tr.toLowerCase().contains(q) ||
          s.city.toLowerCase().contains(q) ||
          s.city.tr.toLowerCase().contains(q);
      return matchCity && matchSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? _darkBg : _cream;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'زانيار · ZANYAR',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: isDark ? Colors.grey[400] : _terracotta,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'kurdistan'.tr,
                        style: GoogleFonts.lora(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : _teal,
                        ),
                      ),
                      Text(
                        'historical_sites'.tr,
                        style: GoogleFonts.lora(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? Colors.white70
                              : _teal.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                  const AuthToggles(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(color: _teal, thickness: 0.5, indent: 0),

            // ── Search ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF222826) : Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _search = v),
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  decoration: InputDecoration(
                    hintText: 'search_sites_hint'.tr,
                    hintStyle: TextStyle(
                      color: isDark ? Colors.grey[500] : Colors.grey[400],
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: isDark ? Colors.grey[400] : Colors.grey[500],
                    ),
                    suffixIcon: _search.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchCtrl.clear();
                              setState(() => _search = '');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 4,
                    ),
                  ),
                ),
              ),
            ),

            // ── City filter chips ─────────────────────────────────
            const SizedBox(height: 10),
            SizedBox(
              height: 36,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _cities.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final city = _cities[i];
                  final sel = city == _selectedCity;

                  // Same colors as the category chips
                  final selectedBg = isDark ? const Color(0xFF7CB8AE) : _teal;
                  final selectedFg = isDark
                      ? const Color(0xFF1F4E4C)
                      : Colors.white;

                  return ChoiceChip(
                    label: Text(city.tr, style: const TextStyle(fontSize: 13)),
                    selected: sel,
                    checkmarkColor: sel ? selectedFg : null,
                    selectedColor: selectedBg,
                    backgroundColor: isDark
                        ? const Color(0xFF1E2724)
                        : Colors.white,
                    labelStyle: TextStyle(
                      color: sel
                          ? selectedFg
                          : (isDark ? Colors.white70 : Colors.black87),
                      fontWeight: sel ? FontWeight.bold : FontWeight.normal,
                    ),
                    side: BorderSide(
                      color: sel
                          ? selectedBg
                          : (isDark ? Colors.grey[700]! : Colors.grey[300]!),
                    ),
                    onSelected: (_) => setState(() => _selectedCity = city),
                  );
                },
              ),
            ),
            // ── Site count ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
              child: Text(
                '${_filtered.length} ${'sites_count'.tr}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: isDark ? Colors.grey[500] : Colors.grey[600],
                ),
              ),
            ),

            // ── Site list ──────────────────────────────────────────
            Expanded(
              child: _filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: isDark ? Colors.grey[600] : Colors.grey[400],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'no_sites_found'.tr,
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemCount: _filtered.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (_, i) => _SiteCard(site: _filtered[i]),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BNB(currentIndex: 0),
    );
  }
}

// ─── Site Card ─────────────────────────────────────────────────────────────────

class _SiteCard extends StatelessWidget {
  final HistoricalSite site;
  const _SiteCard({required this.site});

  @override
  Widget build(BuildContext context) {
    final appCtrl = Get.find<AppController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => Get.to(() => SiteDetailScreen(site: site)),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C2422) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.07),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image / gradient hero
            _SiteHeroImage(site: site),

            // Info
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          site.localizedName,
                          style: GoogleFonts.lora(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF1F4E4C),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${site.period.tr}  ·  ${site.status.tr}',
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            ..._buildStars(site.rating),
                            const SizedBox(width: 4),
                            Text(
                              '${site.rating} (${site.reviewCount})',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFFC4704B),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Heart button
                  Obx(
                    () => IconButton(
                      onPressed: () => appCtrl.toggleFavorite(site),
                      icon: Icon(
                        appCtrl.isFavorite(site.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: appCtrl.isFavorite(site.id)
                            ? Colors.red
                            : Colors.grey[400],
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStars(double rating) {
    return List.generate(5, (i) {
      if (i < rating.floor()) {
        return const Icon(Icons.star, color: Color(0xFFC4704B), size: 15);
      } else if (i < rating) {
        return const Icon(Icons.star_half, color: Color(0xFFC4704B), size: 15);
      }
      return const Icon(Icons.star_border, color: Color(0xFFC4704B), size: 15);
    });
  }
}

class _SiteHeroImage extends StatelessWidget {
  final HistoricalSite site;
  const _SiteHeroImage({required this.site});

  static final Map<String, List<Color>> _gradients = {
    'Citadel': [Color(0xFF2E5E5B), Color(0xFF8BA888)],
    'Sanctuary': [Color(0xFF3D4B6B), Color(0xFF7B90B2)],
    'Cave': [Color(0xFF4A3728), Color(0xFF8C7B6A)],
    'Castle': [Color(0xFF2C3E40), Color(0xFF6B8C6A)],
    'Heritage': [Color(0xFF4A3218), Color(0xFF9C7A48)],
  };

  @override
  Widget build(BuildContext context) {
    final colors =
        _gradients[site.category] ??
        [const Color(0xFF2E5E5B), const Color(0xFF6B8C6A)];

    return Stack(
      children: [
        // Background gradient
        Container(
          height: 170,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
          ),
        ),
        // Network image overlay (if available)
        if (site.imageUrls.isNotEmpty)
          Positioned.fill(
            child: Image.network(
              site.imageUrls.first,
              fit: BoxFit.cover,
              loadingBuilder: (_, child, progress) =>
                  progress == null ? child : const SizedBox.shrink(),
              errorBuilder: (_, _, _) => const SizedBox.shrink(),
            ),
          ),
        // Gradient overlay so text is readable
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.45),
                ],
              ),
            ),
          ),
        ),
        // Category badge
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
            ),
            child: Text(
              site.category.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        // Icon center
        Positioned.fill(
          child: Center(
            child: Icon(
              site.icon,
              color: Colors.white.withValues(alpha: 0.3),
              size: 64,
            ),
          ),
        ),
      ],
    );
  }
}

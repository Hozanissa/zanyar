import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zanyar/bnb.dart';
import 'package:zanyar/locale/locale_controller.dart';
import 'package:zanyar/widgets/auth_toggles.dart';

class HistoricalSite {
  final String id;
  final String name;
  final String kurdishName;
  final String city;
  final String category;
  final String description;
  final LatLng location;
  final IconData icon;

  const HistoricalSite({
    required this.id,
    required this.name,
    required this.kurdishName,
    required this.city,
    required this.category,
    required this.description,
    required this.location,
    required this.icon,
  });

  /// Main name for the current language, and the other one as the small line.
  String get displayName => LocaleController.kurdishNow ? kurdishName : name;
  String get secondaryName => LocaleController.kurdishNow ? name : kurdishName;
}

class MapScreen extends StatefulWidget {
  final String? initialSiteId;
  const MapScreen({super.key, this.initialSiteId});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  static const LatLng _kurdistanCenter = LatLng(36.35, 44.15);
  static const double _initialZoom = 8.5;

  String _selectedCategory = 'All';
  HistoricalSite? _selectedSite;


  List<HistoricalSite> _sites = [];
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _sitesSubscription;

  List<String> get _categories {
    final set = {'All', ..._sites.map((s) => s.category)};
    return set.toList();
  }

  List<HistoricalSite> get _filteredSites {
    if (_selectedCategory == 'All') return _sites;
    return _sites.where((s) => s.category == _selectedCategory).toList();
  }

  void _moveToSite(HistoricalSite site) {
    setState(() {
      _selectedSite = site;
    });
    _mapController.move(site.location, 13.0);
  }

  void _zoom(double delta) {
    final currentZoom = _mapController.camera.zoom;
    final currentCenter = _mapController.camera.center;
    _mapController.move(currentCenter, (currentZoom + delta).clamp(4.0, 18.0));
  }

  void _resetView() {
    setState(() {
      _selectedSite = null;
    });
    _mapController.move(_kurdistanCenter, _initialZoom);
  }

  @override
  void initState() {
    super.initState();
    _sitesSubscription = FirebaseFirestore.instance
        .collection('sites')
        .snapshots()
        .listen((snapshot) {
          if (!mounted) return;
          final sites = snapshot.docs.map((doc) {
            final data = doc.data();
            final category = data['category'] as String? ?? 'Heritage';
            return HistoricalSite(
              id: doc.id,
              name: data['name'] as String? ?? '',
              kurdishName: data['kurdishName'] as String? ?? '',
              city: data['city'] as String? ?? '',
              category: category,
              description: data['description'] as String? ?? '',
              location: LatLng(
                (data['lat'] as num?)?.toDouble() ?? 0,
                (data['lng'] as num?)?.toDouble() ?? 0,
              ),
              icon: _iconForCategory(category),
            );
          }).toList();
          setState(() {
            _sites = sites;
            if (_selectedSite != null) {
              final matches = sites.where((site) => site.id == _selectedSite!.id);
              _selectedSite = matches.isEmpty ? null : matches.first;
            }
          });
          final id = widget.initialSiteId;
          if (id != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              final matches = _sites.where((site) => site.id == id);
              if (matches.isNotEmpty) _moveToSite(matches.first);
            });
          }
        });
  }

  static IconData _iconForCategory(String category) => switch (category.toLowerCase()) {
    'citadel' => Icons.account_balance,
    'sanctuary' => Icons.temple_buddhist,
    'cave' => Icons.landscape,
    'castle' => Icons.castle,
    _ => Icons.museum,
  };

  @override
  void dispose() {
    _sitesSubscription?.cancel();
    super.dispose();
  }

  Future<void> _openExternalDirections(HistoricalSite site) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${site.location.latitude},${site.location.longitude}',
    );
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'error'.tr,
          'maps_error'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (_) {
      Get.snackbar(
        'error'.tr,
        'maps_app_error'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const primaryTeal = Color(0xFF1F4E4C);
    const terracotta = Color(0xFFC4704B);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'interactive_map'.tr.isEmpty
                              ? 'INTERACTIVE MAP'
                              : 'interactive_map'.tr,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.6,
                            color: theme.brightness == Brightness.dark
                                ? Colors.grey[400]
                                : terracotta,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'all_sites'.tr.isEmpty ? 'All Sites' : 'all_sites'.tr,
                          style: GoogleFonts.lora(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: theme.brightness == Brightness.dark
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: _resetView,
                    tooltip: 'reset_map_view'.tr,
                    icon: Icon(
                      Icons.my_location,
                      color: theme.brightness == Brightness.dark
                          ? Color(0xFF7CB8AE)
                          : primaryTeal,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const AuthToggles(),
                ],
              ),
            ),

            // Category Filter Chips
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat;
                  final isDark = theme.brightness == Brightness.dark;
                  return ChoiceChip(
                    label: Text(cat.tr),
                    selected: isSelected,
                    checkmarkColor: isSelected
                        ? (isDark ? const Color(0xFF1F4E4C) : Colors.white)
                        : null,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedCategory = cat;
                          if (_selectedSite != null &&
                              _selectedCategory != 'All' &&
                              _selectedSite!.category != _selectedCategory) {
                            _selectedSite = null;
                          }
                        });
                      }
                    },
                    selectedColor: isDark
                        ? const Color(0xFF7CB8AE)
                        : primaryTeal,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? (isDark ? const Color(0xFF1F4E4C) : Colors.white)
                          : null,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),

            // Map View with Floating Overlays
            Expanded(
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _kurdistanCenter,
                      initialZoom: _initialZoom,
                      minZoom: 5.0,
                      maxZoom: 18.0,
                      onTap: (tapPosition, point) {
                        if (_selectedSite != null) {
                          setState(() => _selectedSite = null);
                        }
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.zanyar_app',
                      ),
                      MarkerLayer(
                        markers: _filteredSites.map((site) {
                          final isSelected = _selectedSite?.id == site.id;
                          return Marker(
                            point: site.location,
                            width: isSelected ? 55 : 44,
                            height: isSelected ? 55 : 44,
                            child: GestureDetector(
                              onTap: () => _moveToSite(site),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                decoration: BoxDecoration(
                                  color: isSelected ? terracotta : primaryTeal,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: isSelected ? 3 : 2,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  site.icon,
                                  color: Colors.white,
                                  size: isSelected ? 28 : 22,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  // Floating Zoom Controls (+ / -)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Column(
                      children: [
                        FloatingActionButton.small(
                          heroTag: 'map_zoom_in',
                          backgroundColor: theme.colorScheme.surface,
                          onPressed: () => _zoom(1.0),
                          child: Icon(
                            Icons.add,
                            color: theme.brightness == Brightness.dark
                                ? const Color(0xFF7CB8AE)
                                : primaryTeal,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FloatingActionButton.small(
                          heroTag: 'map_zoom_out',
                          backgroundColor: theme.colorScheme.surface,
                          onPressed: () => _zoom(-1.0),
                          child: Icon(
                            Icons.remove,
                            color: theme.brightness == Brightness.dark
                                ? const Color(0xFF7CB8AE)
                                : primaryTeal,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Site Details or Carousel at the Bottom
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: _selectedSite != null
                        ? _buildSelectedSiteCard(_selectedSite!)
                        : _buildQuickSitesCarousel(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BNB(currentIndex: 1),
    );
  }

  Widget _buildSelectedSiteCard(HistoricalSite site) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryTeal = Color(0xFF1F4E4C);
    const terracotta = Color(0xFFC4704B);
    const lightTeal = Color(0xFF7CB8AE);

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: terracotta.withValues(alpha: 0.15),
                  radius: 22,
                  child: Icon(site.icon, color: terracotta, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        site.displayName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            site.secondaryName,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (isDark ? lightTeal : primaryTeal)
                                  .withValues(alpha: isDark ? 0.2 : 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              site.city.tr,
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? lightTeal : primaryTeal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => setState(() => _selectedSite = null),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              site.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                height: 1.35,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: primaryTeal,
                      foregroundColor: isDark ? lightTeal : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => _openExternalDirections(site),
                    icon: const Icon(Icons.directions, size: 18),
                    label: Text('directions'.tr),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: terracotta,
                    side: const BorderSide(color: terracotta),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _mapController.move(site.location, 14.5);
                  },
                  child: Text('focus'.tr),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickSitesCarousel() {
    const primaryTeal = Color(0xFF1F4E4C);

    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filteredSites.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final site = _filteredSites[index];
          return InkWell(
            onTap: () => _moveToSite(site),
            borderRadius: BorderRadius.circular(12),
            child: Card(
              elevation: 3,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: primaryTeal.withValues(alpha: 0.12),
                      radius: 16,
                      child: Icon(site.icon, size: 18, color: primaryTeal),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          site.displayName,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          site.city.tr,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

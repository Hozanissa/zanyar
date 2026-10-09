import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

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
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  static const LatLng _kurdistanCenter = LatLng(36.35, 44.15);
  static const double _initialZoom = 8.5;

  String _selectedCategory = 'All';
  HistoricalSite? _selectedSite;

  final List<HistoricalSite> _sites = const [
    HistoricalSite(
      id: 'erbil_citadel',
      name: 'Erbil Citadel',
      kurdishName: 'قەڵای هەولێر',
      city: 'Erbil',
      category: 'Citadel',
      description:
          'One of the oldest continuously inhabited places on Earth, dating back over 6,000 years, and recognized as a UNESCO World Heritage site.',
      location: LatLng(36.1911, 44.0091),
      icon: Icons.fort,
    ),
    HistoricalSite(
      id: 'amadiya',
      name: 'Amadiya Citadel',
      kurdishName: 'قەڵای ئامێدی',
      city: 'Duhok',
      category: 'Citadel',
      description:
          'An ancient cliff-top fortress town founded around 800 BC, perched on a mesa mountain with spectacular historical gates.',
      location: LatLng(37.0911, 43.4878),
      icon: Icons.location_city,
    ),
    HistoricalSite(
      id: 'shanidar_cave',
      name: 'Shanidar Cave',
      kurdishName: 'ئەشکەوتی شانەدەر',
      city: 'Erbil (Bradost)',
      category: 'Cave',
      description:
          'World-famous archaeological site containing Neanderthal remains and early funeral flower burial evidence in the Bradost Mountain.',
      location: LatLng(36.8333, 44.2167),
      icon: Icons.landscape,
    ),
    HistoricalSite(
      id: 'lalish',
      name: 'Lalish Sanctuary',
      kurdishName: 'پەرستگای لالش',
      city: 'Shekhan (Duhok)',
      category: 'Sanctuary',
      description:
          'The holiest site of the Yazidi community, a peaceful mountain sanctuary with iconic conical spires and centuries-old stone pathways.',
      location: LatLng(36.7719, 43.3039),
      icon: Icons.account_balance,
    ),
    HistoricalSite(
      id: 'sherwana_castle',
      name: 'Sherwana Castle',
      kurdishName: 'قەڵای شێروانە',
      city: 'Kalar (Garmian)',
      category: 'Castle',
      description:
          'Historic 19th-century palace fortress built by Muhammad Pasha Jaff on top of an ancient tell overlooking the Sirwan river.',
      location: LatLng(34.6247, 45.3125),
      icon: Icons.castle,
    ),
    HistoricalSite(
      id: 'khanzad_castle',
      name: 'Khanzad Castle',
      kurdishName: 'قەڵای خانزاد',
      city: 'Erbil',
      category: 'Castle',
      description:
          'A stone fortress constructed in the 16th century during the Soran Emirate by Princess Khanzad along the historic road to Soran.',
      location: LatLng(36.3375, 44.1167),
      icon: Icons.shield,
    ),
    HistoricalSite(
      id: 'dwin_castle',
      name: 'Dwin Castle',
      kurdishName: 'قەڵای دوین',
      city: 'Erbil',
      category: 'Castle',
      description:
          'Ancient medieval fortress linked to the ancestry of Sultan Saladin (Salah ad-Din), offering panoramic views of historical trade routes.',
      location: LatLng(36.4250, 44.2056),
      icon: Icons.castle,
    ),
    HistoricalSite(
      id: 'slemani_heritage',
      name: 'Sulaymaniyah Heritage',
      kurdishName: 'شوێنەواری سلێمانی',
      city: 'Sulaymaniyah',
      category: 'Heritage',
      description:
          'The cultural heart of southern Kurdistan, celebrated for traditional grand bazaars, Goyzha viewpoints, and heritage archives.',
      location: LatLng(35.5558, 45.4351),
      icon: Icons.museum,
    ),
  ];

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

  Future<void> _openExternalDirections(HistoricalSite site) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${site.location.latitude},${site.location.longitude}',
    );
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'Error',
          'Could not open Google Maps',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (_) {
      Get.snackbar(
        'Error',
        'Could not open maps application',
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
                            letterSpacing: 1.2,
                            color: theme.brightness == Brightness.dark
                                ? Colors.grey[400]
                                : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'all_sites'.tr.isEmpty ? 'All Sites' : 'all_sites'.tr,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: terracotta,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: _resetView,
                    tooltip: 'Reset Map View',
                    icon: const Icon(Icons.my_location, color: primaryTeal),
                  ),
                ],
              ),
            ),

            // Category Filter Chips
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
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
                    selectedColor: primaryTeal,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : null,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
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
                          child: const Icon(Icons.add, color: primaryTeal),
                        ),
                        const SizedBox(height: 8),
                        FloatingActionButton.small(
                          heroTag: 'map_zoom_out',
                          backgroundColor: theme.colorScheme.surface,
                          onPressed: () => _zoom(-1.0),
                          child: const Icon(Icons.remove, color: primaryTeal),
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
    );
  }

  Widget _buildSelectedSiteCard(HistoricalSite site) {
    const primaryTeal = Color(0xFF1F4E4C);
    const terracotta = Color(0xFFC4704B);

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
                        site.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            site.kurdishName,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: primaryTeal.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              site.city,
                              style: const TextStyle(
                                fontSize: 11,
                                color: primaryTeal,
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => _openExternalDirections(site),
                    icon: const Icon(Icons.directions, size: 18),
                    label: const Text('Directions'),
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
                  child: const Text('Focus'),
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
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                          site.name,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          site.city,
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

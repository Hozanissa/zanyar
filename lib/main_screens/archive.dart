import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanyar/bnb.dart';
import 'package:zanyar/locale/locale_controller.dart';
import 'package:zanyar/widgets/auth_toggles.dart';

class ArchiveItem {
  final String id;
  final String category; // 'Folklore', 'Poets', 'Scholars'
  final String title;
  final String kurdishTitle;
  final String subtitle;
  final String kurdishSubtitle;
  final String badge;
  final String kurdishBadge;
  final String period;
  final String kurdishPeriod;
  final String story;
  final String significance;
  final String kurdishStory;
  final String kurdishSignificance;

  const ArchiveItem({
    required this.id,
    required this.category,
    required this.title,
    required this.kurdishTitle,
    required this.subtitle,
    this.kurdishSubtitle = '',
    required this.badge,
    this.kurdishBadge = '',
    required this.period,
    this.kurdishPeriod = '',
    required this.story,
    required this.significance,
    this.kurdishStory = '',
    this.kurdishSignificance = '',
  });

  /// Kurdish title in Kurdish mode, English title otherwise.
  String get displayTitle => LocaleController.kurdishNow && kurdishTitle.isNotEmpty
      ? kurdishTitle
      : title;
  String get displaySubtitle =>
      LocaleController.kurdishNow && kurdishSubtitle.isNotEmpty
      ? kurdishSubtitle
      : subtitle;
  String get displayBadge => LocaleController.kurdishNow && kurdishBadge.isNotEmpty
      ? kurdishBadge
      : badge;
  String get displayPeriod =>
      LocaleController.kurdishNow && kurdishPeriod.isNotEmpty
      ? kurdishPeriod
      : period;
  String get displayStory => LocaleController.kurdishNow && kurdishStory.isNotEmpty
      ? kurdishStory
      : story;
  String get displaySignificance =>
      LocaleController.kurdishNow && kurdishSignificance.isNotEmpty
      ? kurdishSignificance
      : significance;

  factory ArchiveItem.fromMap(String id, Map<String, dynamic> data) =>
      ArchiveItem(
        id: id,
        category: data['category'] as String? ?? 'Folklore',
        title: data['title'] as String? ?? '',
        kurdishTitle: data['kurdishTitle'] as String? ?? '',
        subtitle: data['subtitle'] as String? ?? '',
        kurdishSubtitle: data['kurdishSubtitle'] as String? ?? '',
        badge: data['badge'] as String? ?? '',
        kurdishBadge: data['kurdishBadge'] as String? ?? '',
        period: data['period'] as String? ?? '',
        kurdishPeriod: data['kurdishPeriod'] as String? ?? '',
        story: data['story'] as String? ?? '',
        significance: data['significance'] as String? ?? '',
        kurdishStory: data['kurdishStory'] as String? ?? '',
        kurdishSignificance: data['kurdishSignificance'] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
    'category': category,
    'title': title,
    'kurdishTitle': kurdishTitle,
    'subtitle': subtitle,
    'kurdishSubtitle': kurdishSubtitle,
    'badge': badge,
    'kurdishBadge': kurdishBadge,
    'period': period,
    'kurdishPeriod': kurdishPeriod,
    'story': story,
    'significance': significance,
    'kurdishStory': kurdishStory,
    'kurdishSignificance': kurdishSignificance,
  };
}

const Color _primaryTeal = Color(0xFF1F4E4C);
const Color _terracotta = Color(0xFFC4704B);

class Archive extends StatefulWidget {
  const Archive({super.key});

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  String _selectedCategory = 'Folklore';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = const ['Folklore', 'Poets', 'Scholars'];


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ArchiveItem> _filteredItems(List<ArchiveItem> items) {
    return items.where((item) {
      final matchesCategory = item.category == _selectedCategory;
      if (!matchesCategory) return false;

      if (_searchQuery.trim().isEmpty) return true;

      final query = _searchQuery.toLowerCase();
      return item.title.toLowerCase().contains(query) ||
          item.displaySubtitle.toLowerCase().contains(query) ||
          item.kurdishTitle.toLowerCase().contains(query) ||
          item.displayBadge.toLowerCase().contains(query);
    }).toList();
  }

  void _openDetail(ArchiveItem item) {
    Get.to(() => ArchiveDetailScreen(item: item));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF141918) : const Color(0xFFF9F6F0);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Section
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'cultural_archive'.tr,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.6,
                          color: isDark ? Colors.grey[400] : _terracotta,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'kurdish_heritage'.tr,
                        style: GoogleFonts.lora(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : _primaryTeal,
                        ),
                      ),
                    ],
                  ),
                  const AuthToggles(),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF222826)
                      : const Color(0xFFF3EDE5),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF323B38)
                        : const Color(0xFFE4DAD0),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _searchQuery = val),
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  decoration: InputDecoration(
                    hintText: 'search_hint'.trParams({
                      'cat': _selectedCategory.tr.toLowerCase(),
                    }),
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: isDark
                          ? Colors.grey[500]
                          : const Color(0xFF999086),
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: isDark
                          ? Colors.grey[400]
                          : const Color(0xFF8C8277),
                      size: 22,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),

            // Category Chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Row(
                children: _categories.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCategory = cat;
                          _searchQuery = '';
                          _searchController.clear();
                        });
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _primaryTeal
                              : (isDark
                                    ? const Color(0xFF202725)
                                    : Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? _primaryTeal
                                : (isDark
                                      ? const Color(0xFF38433F)
                                      : const Color(0xFFDACFC6)),
                            width: 1.2,
                          ),
                        ),
                        child: Text(
                          cat.tr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : (isDark
                                      ? Colors.grey[300]
                                      : const Color(0xFF3A342F)),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 6),

            _buildArchiveList(isDark),
          ],
        ),
      ),
      bottomNavigationBar: const BNB(currentIndex: 2),
    );
  }

  Widget _buildArchiveList(bool isDark) {
    final collection = FirebaseFirestore.instance.collection('archiveItems');
    return Expanded(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: collection.snapshots(),
        builder: (context, itemsSnapshot) {
          if (itemsSnapshot.hasError) {
            return Center(
              child: Text('Could not load archive: ${itemsSnapshot.error}'),
            );
          }
          if (!itemsSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = itemsSnapshot.data!.docs
              .map((doc) => ArchiveItem.fromMap(doc.id, doc.data()))
              .toList();
          return _buildItemList(items, isDark);
        },
      ),
    );
  }

  Widget _buildItemList(List<ArchiveItem> items, bool isDark) {
    final filteredItems = _filteredItems(items);
    if (filteredItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_stories_outlined, size: 48,
                color: isDark ? Colors.grey[600] : Colors.grey[400]),
            const SizedBox(height: 12),
            Text('no_items'.tr, style: TextStyle(fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey[400] : Colors.grey[600])),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      itemCount: filteredItems.length,
      separatorBuilder: (context, index) => const SizedBox(height: 14),
      itemBuilder: (context, index) =>
          _buildArchiveCard(context, filteredItems[index], isDark),
    );
  }

  Widget _buildArchiveCard(
    BuildContext context,
    ArchiveItem item,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2422) : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isDark ? const Color(0xFF2C3532) : const Color(0xFFECE5DE),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : const Color(0xFF8A7E72).withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => _openDetail(item),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.displayTitle,
                        style: GoogleFonts.lora(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF1F2B28),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? _primaryTeal.withValues(alpha: 0.3)
                            : const Color(0xFFE2F0EA),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        item.displayBadge,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _primaryTeal,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Subtitle and Period
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        item.displaySubtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? Colors.grey[400]
                              : const Color(0xFF756F68),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.displayPeriod,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'monospace',
                        color: isDark
                            ? Colors.grey[400]
                            : const Color(0xFF867E77),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Read more and arrow
                Row(
                  children: [
                    Text(
                      'read_more'.tr,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? const Color(0xFF68B0A5) : _primaryTeal,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_right_alt,
                      size: 20,
                      color: isDark ? const Color(0xFF68B0A5) : _primaryTeal,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ArchiveDetailScreen extends StatelessWidget {
  final ArchiveItem item;

  const ArchiveDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF141918) : const Color(0xFFF9F6F0);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              InkWell(
                onTap: () => Get.back(),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.chevron_left,
                        color: isDark ? const Color(0xFF7CB8AE) : _primaryTeal,
                        size: 24,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        'back_to'.trParams({
                          'cat': item.category.tr.toLowerCase(),
                        }),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? const Color(0xFF7CB8AE)
                              : _primaryTeal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Tag and Period
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? _primaryTeal.withValues(alpha: 0.3)
                          : const Color(0xFFE2F0EA),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      item.displayBadge,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _primaryTeal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    item.displayPeriod,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? Colors.grey[400]
                          : const Color(0xFF867E77),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Title and Subtitle
              Text(
                item.displayTitle,
                style: GoogleFonts.lora(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                  color: isDark ? Colors.white : const Color(0xFF1F2B28),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.displaySubtitle,
                style: TextStyle(
                  fontSize: 15,
                  color: isDark ? Colors.grey[400] : const Color(0xFF756F68),
                ),
              ),
              const SizedBox(height: 24),

              // The Story Heading & Body
              Text(
                'the_story'.tr,
                style: GoogleFonts.lora(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? const Color(0xFF7CB8AE) : _primaryTeal,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                item.displayStory,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: isDark ? Colors.grey[300] : const Color(0xFF3D3733),
                ),
              ),
              const SizedBox(height: 24),

              // Cultural Significance Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1C2723)
                      : const Color(0xFFE9F3EE),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF2C3E37)
                        : const Color(0xFFD6E7DF),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'cultural_significance'.tr,
                      style: GoogleFonts.lora(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? const Color(0xFF7CB8AE) : _primaryTeal,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.displaySignificance,
                      style: TextStyle(
                        fontSize: 14.5,
                        height: 1.55,
                        color: isDark
                            ? Colors.grey[300]
                            : const Color(0xFF38433F),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

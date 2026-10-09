import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanyar_app/bnb.dart';

class ArchiveItem {
  final String id;
  final String category; // 'Folklore', 'Poets', 'Scholars'
  final String title;
  final String kurdishTitle;
  final String subtitle;
  final String badge;
  final String period;
  final String story;
  final String significance;

  const ArchiveItem({
    required this.id,
    required this.category,
    required this.title,
    required this.kurdishTitle,
    required this.subtitle,
    required this.badge,
    required this.period,
    required this.story,
    required this.significance,
  });
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

  final List<ArchiveItem> _archiveItems = const [
    // Folklore
    ArchiveItem(
      id: 'mem_u_zin',
      category: 'Folklore',
      title: 'The tale of Mem u Zin',
      kurdishTitle: 'مەم و زین',
      subtitle: 'Classic Kurdish love epic, 17th century',
      badge: 'Epic',
      period: '1695',
      story: 'Mem û Zîn is a Kurdish love epic written by Ehmedê Xanî in 1695, drawing on an older oral story. Set in the principality of Botan, it follows Mem and Zîn, whose love is thwarted by intrigue and social barriers. Their tragic story intertwines devotion, loss, and spiritual longing.',
      significance: 'Written in Kurmanji, the epic is a landmark of Kurdish literature. Beyond its love story, it reflects on division, power, and the place of the Kurdish language. It continues to inspire storytelling, theatre, and literary study.',
    ),
    ArchiveItem(
      id: 'dawrese_evdi',
      category: 'Folklore',
      title: 'Dawrêşê Evdî',
      kurdishTitle: 'دەورێشێ عەڤدی',
      subtitle: 'Heroic folk ballad, oral tradition',
      badge: 'Ballad',
      period: 'Oral',
      story: 'A legendary dengbêj ballad recounting the chivalric bravery and tragic romance of Dawrêşê Evdî, a Yazidi warrior from the Sharqi region. When hostile confederations threatened the tribal lands, Dawrêş led an outnumbered defense for honor, love for Edûlê, and selfless devotion.',
      significance: 'Considered the pinnacle of Kurdish oral dengbêj tradition, Dawrêşê Evdî preserves centuries of historical resilience, oral poetic meters, and heroic folklore across generations.',
    ),
    ArchiveItem(
      id: 'kawa_blacksmith',
      category: 'Folklore',
      title: 'Kawa the Blacksmith',
      kurdishTitle: 'کاوەی ئاسنگەر',
      subtitle: 'The legend of Newroz and freedom',
      badge: 'Myth',
      period: 'Ancient',
      story: 'The epic folk legend of Kawa, a blacksmith who rose up against the merciless serpent tyrant Zahhak. Refusing to sacrifice the youth of his land, Kawa forged a rebellion, struck down the tyrant, and lit great fires upon the rugged mountain peaks to herald liberation.',
      significance: 'Celebrated every year on Newroz (March 21st), Kawa’s revolt is the defining symbol of Kurdish rebirth, resistance against oppression, and the arrival of light and spring.',
    ),
    ArchiveItem(
      id: 'siyabend_xec',
      category: 'Folklore',
      title: 'Siyabend and Xecê',
      kurdishTitle: 'سیابەند و خەجێ',
      subtitle: 'Tragic romantic myth of Mount Sipan',
      badge: 'Romance',
      period: 'Oral',
      story: 'A heart-rending tale of love set on Mount Sipan. Siyabend, an orphan and skilled hunter, wins the hand of Xecê against high odds, only for tragedy to strike along the mountain cliffs in a moment of fateful misfortune.',
      significance: 'A core pastoral love poem recited by oral bards, symbolizing the dramatic intimacy between Kurdish wanderers, untamed nature, and tragic sacrifice.',
    ),

    // Poets
    ArchiveItem(
      id: 'melaye_ciziri',
      category: 'Poets',
      title: 'Melayê Cizîrî',
      kurdishTitle: 'مەلای جزیری',
      subtitle: 'Master of Kurdish mystical poetry',
      badge: 'Classical',
      period: '1570–1640',
      story: 'Born in Cizre, Melayê Cizîrî was a premier luminary of classical Kurdish literature. His Divan elevated the Kurmanji dialect to the heights of high mystical poetry, weaving Sufi metaphysics, radiant imagery, and romantic devotion.',
      significance: 'Established the classical Kurdish poetic tradition alongside Persian and Arabic masters, creating verses treasured across centuries of scholars.',
    ),
    ArchiveItem(
      id: 'nali',
      category: 'Poets',
      title: 'Nalî (Mullah Khidr)',
      kurdishTitle: 'نالی',
      subtitle: 'Pioneer of Sorani classical poetry',
      badge: 'Sorani',
      period: '1797–1855',
      story: 'Hailing from Sharazoor, Nalî inaugurated the golden age of classical Sorani poetry in the cultural capital of the Baban Emirate in Sulaymaniyah. His verses blend poignant longing, philosophical wit, and refined linguistic mastery.',
      significance: 'Nalî transformed Sorani into a dominant literary medium and founded the legendary Nalî School of poetry with Salim and Kurdi.',
    ),
    ArchiveItem(
      id: 'sherko_bekas',
      category: 'Poets',
      title: 'Sherko Bekas',
      kurdishTitle: 'شێرکۆ بێکەس',
      subtitle: 'Poet of freedom and nature',
      badge: 'Modern',
      period: '1940–2013',
      story: 'A revolutionary pioneer of modern Kurdish free verse (Ruwanga movement), Sherko Bekas gave voice to the Kurdish soul, mountains, tragic national struggles, and cosmic themes of human liberty.',
      significance: 'Winner of the Swedish Tucholsky Prize, his works have been translated into dozens of world languages, making him one of Kurdistan’s most celebrated modern bards.',
    ),

    // Scholars
    ArchiveItem(
      id: 'sharafkhan_bidlisi',
      category: 'Scholars',
      title: 'Sharafkhan Bidlisi',
      kurdishTitle: 'شەرەفخانی بەدلیسی',
      subtitle: 'Author of the Sharafnama',
      badge: 'Chronicle',
      period: '1543–1603',
      story: 'Prince of Bitlis and renowned statesman who compiled the monumental Sharafnama in 1597, the earliest comprehensive history and dynastic genealogy of the Kurdish principalities.',
      significance: 'The Sharafnama stands as the premier primary historiographical work documenting medieval Kurdish politics, territorial kingdoms, and cultural life.',
    ),
    ArchiveItem(
      id: 'ibn_al_athir',
      category: 'Scholars',
      title: 'Ibn al-Athir',
      kurdishTitle: 'ئیبن ئەلئەسیر',
      subtitle: 'Great medieval historian of Cizre',
      badge: 'History',
      period: '1160–1233',
      story: 'Born in Cizre (Jazirat Ibn Umar), Ibn al-Athir authored Al-Kamil fi al-Tarikh (The Complete History), one of the most authoritative and comprehensive chronicles of the Islamic medieval era.',
      significance: 'An irreplaceable universal source providing firsthand documentation of the Crusades, Seljuk and Ayyubid realms, and early medieval Eurasia.',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ArchiveItem> get _filteredItems {
    return _archiveItems.where((item) {
      final matchesCategory = item.category == _selectedCategory;
      if (!matchesCategory) return false;

      if (_searchQuery.trim().isEmpty) return true;

      final query = _searchQuery.toLowerCase();
      return item.title.toLowerCase().contains(query) ||
          item.subtitle.toLowerCase().contains(query) ||
          item.kurdishTitle.toLowerCase().contains(query) ||
          item.badge.toLowerCase().contains(query);
    }).toList();
  }

  void _openDetail(ArchiveItem item) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ArchiveDetailScreen(item: item)),
    );
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
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CULTURAL ARCHIVE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.6,
                      color: isDark ? Colors.grey[400] : _terracotta,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Kurdish Heritage',
                    style: GoogleFonts.lora(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : _primaryTeal,
                    ),
                  ),
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
                    hintText: 'Search ${_selectedCategory.toLowerCase()}...',
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
                          cat,
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

            // Archive Cards List
            Expanded(
              child: _filteredItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.auto_stories_outlined,
                            size: 48,
                            color: isDark ? Colors.grey[600] : Colors.grey[400],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No items found',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                      itemCount: _filteredItems.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        return _buildArchiveCard(context, item, isDark);
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BNB(currentIndex: 2),
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
                        item.title,
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
                        item.badge,
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
                        item.subtitle,
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
                      item.period,
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
                      'Read more',
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
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
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
                        'Back to ${item.category.toLowerCase()}',
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
                      item.badge,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _primaryTeal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    item.period,
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
                item.title,
                style: GoogleFonts.lora(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                  color: isDark ? Colors.white : const Color(0xFF1F2B28),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.subtitle,
                style: TextStyle(
                  fontSize: 15,
                  color: isDark ? Colors.grey[400] : const Color(0xFF756F68),
                ),
              ),
              const SizedBox(height: 24),

              // The Story Heading & Body
              Text(
                'The story',
                style: GoogleFonts.lora(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? const Color(0xFF7CB8AE) : _primaryTeal,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                item.story,
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
                      'Cultural significance',
                      style: GoogleFonts.lora(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? const Color(0xFF7CB8AE) : _primaryTeal,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.significance,
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

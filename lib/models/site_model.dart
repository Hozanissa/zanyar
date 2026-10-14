import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SiteReview {
  final String author;
  final double rating;
  final String comment;
  final String date;
  const SiteReview({
    required this.author,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

class HistoricalSite {
  final String id;
  final String name;
  final String kurdishName;
  final String city;
  final String category;
  final String description;
  final String kurdishDescription;
  final String hours;
  final String period;
  final String entry;
  final String status;
  final double rating;
  final int reviewCount;
  final List<SiteReview> reviews;
  final IconData icon;
  final double lat;
  final double lng;
  final List<String> imageUrls; // network images

  const HistoricalSite({
    required this.id,
    required this.name,
    required this.kurdishName,
    required this.city,
    required this.category,
    required this.description,
    this.kurdishDescription = '',
    required this.hours,
    required this.period,
    required this.entry,
    required this.status,
    required this.rating,
    required this.reviewCount,
    required this.reviews,
    required this.icon,
    required this.lat,
    required this.lng,
    this.imageUrls = const [],
  });

  String get localizedName {
    final lang = Get.locale?.languageCode ?? 'en';
    if (lang == 'ckb' && kurdishName.isNotEmpty) return kurdishName;
    return name;
  }

  String get localizedDescription {
    final lang = Get.locale?.languageCode ?? 'en';
    if (lang == 'ckb' && kurdishDescription.isNotEmpty) return kurdishDescription;
    return description;
  }
}

// ─── Site data ────────────────────────────────────────────────────────────────

const List<HistoricalSite> kAllSites = [
  HistoricalSite(
    id: 'erbil_citadel',
    name: 'Erbil Citadel',
    kurdishName: 'قەڵای هەولێر',
    city: 'Erbil',
    category: 'Citadel',
    description:
        'One of the oldest continuously inhabited settlements in the world, the Erbil Citadel rises 32 metres above the surrounding plain, its tell formation reflecting millennia of human occupation.',
    kurdishDescription:
        'یەکێکە لە کۆنترین نیشتەجێگە بەردەوام ئاوەدانەکانی جیهان، قەڵای هەولێر ٣٢ مەتر لە دەشتی دەوروبەری بەرز دەبێتەوە و گوزارشت لە هەزاران ساڵ ژیانی مرۆڤایەتی دەکات.',
    hours: '8 am – 6 pm',
    period: 'Neolithic – present',
    entry: 'Free',
    status: 'UNESCO',
    rating: 4.8,
    reviewCount: 128,
    icon: Icons.account_balance,
    lat: 36.1901,
    lng: 44.0091,
    imageUrls: [
      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Erbil_citadel.jpg/960px-Erbil_citadel.jpg',
    ],
    reviews: [
      SiteReview(
        author: 'Rêzan A.',
        rating: 5,
        comment: 'Breathtaking. One of the most profound sites I have ever visited.',
        date: 'Oct 2025',
      ),
      SiteReview(
        author: 'Sarkar M.',
        rating: 5,
        comment: 'A living piece of history. The panoramic view from the top is unforgettable.',
        date: 'Sep 2025',
      ),
      SiteReview(
        author: 'Hozan I.',
        rating: 4,
        comment: 'Incredible historical value. Signage could be improved.',
        date: 'Aug 2025',
      ),
    ],
  ),
  HistoricalSite(
    id: 'lalish_temple',
    name: 'Lalish Temple',
    kurdishName: 'لالش',
    city: 'Shekhan (Duhok)',
    category: 'Sanctuary',
    description:
        'The holiest shrine of the Yazidi faith, nestled in a mountain valley. Pilgrims walk barefoot within the sacred grounds, past ancient conical spires and olive trees centuries old.',
    kurdishDescription:
        'پیرۆزترین مەزارگەی ئایینی ئێزدییە، لە دۆڵێکی شاخاویدا هەڵکەوتووە. زیارەتکاران بە پێ پەتی بە ناو شوێنە پیرۆزەکاندا دەڕۆن، بەلای قوبە قووچەکییە کۆنەکان و دار زەیتوونە چەندین سەدەییەکاندا.',
    hours: 'Sunrise – Sunset',
    period: '2nd century CE – present',
    entry: 'Free',
    status: 'Sacred Site',
    rating: 4.9,
    reviewCount: 214,
    icon: Icons.temple_buddhist,
    lat: 36.7719,
    lng: 43.3039,
    imageUrls: [
      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Lalish_temple.jpg/960px-Lalish_temple.jpg',
    ],
    reviews: [
      SiteReview(
        author: 'Dilshad Y.',
        rating: 5,
        comment: 'A deeply spiritual and peaceful place. Unlike anywhere else.',
        date: 'Oct 2025',
      ),
      SiteReview(
        author: 'Nour H.',
        rating: 5,
        comment: 'The architecture is stunning and the atmosphere is serene.',
        date: 'Sep 2025',
      ),
    ],
  ),
  HistoricalSite(
    id: 'bradost_caves',
    name: 'Bradost Caves',
    kurdishName: 'شکەفتەکانی بەرادۆست',
    city: 'Erbil (Bradost)',
    category: 'Cave',
    description:
        'A network of dramatic limestone caves in the Bradost mountains with prehistoric cave paintings and stalactites, revealing traces of Palaeolithic settlement deep in the Kurdish highlands.',
    kurdishDescription:
        'تۆڕێک لە ئەشکەوتی بەردی کەڵسیی سەرسوڕهێنەر لە زنجیرە چیاکانی برادۆست کە وێنەی سەر بەردی پێش مێژوو و ستالاکتیتی تێدایە، ئاماژە بە نیشتەجێبوونی سەردەمی چەرخی بەردینی کۆن دەکات.',
    hours: '9 am – 5 pm',
    period: 'Palaeolithic',
    entry: 'Free',
    status: 'Heritage',
    rating: 4.5,
    reviewCount: 73,
    icon: Icons.landscape,
    lat: 36.7500,
    lng: 44.2500,
    imageUrls: [],
    reviews: [
      SiteReview(
        author: 'Alan K.',
        rating: 5,
        comment: 'Hidden gem. The cave paintings left me speechless.',
        date: 'Jul 2025',
      ),
      SiteReview(
        author: 'Zhiar S.',
        rating: 4,
        comment: 'Stunning natural site. Bring good hiking shoes.',
        date: 'Jun 2025',
      ),
    ],
  ),
  HistoricalSite(
    id: 'sherwana_castle',
    name: 'Sherwana Castle',
    kurdishName: 'قەڵای شێروانە',
    city: 'Kalar (Garmian)',
    category: 'Castle',
    description:
        'Historic 19th-century palace fortress built by Muhammad Pasha Jaff on an ancient tell overlooking the Sirwan river valley, blending traditional Kurdish and Ottoman architecture.',
    kurdishDescription:
        'قەڵایەکی مێژوویی سەدەی ١٩یە کە لەلایەن محەمەد پاشای جاف لەسەر تەپۆڵکەیەکی کۆن دروستکراوە کە دەڕوانێتە سەر دۆڵی ڕووباری سیروان، و تێکەڵەیەکە لە تەلارسازیی کوردی و عوسمانی.',
    hours: '10 am – 4 pm',
    period: '19th century',
    entry: 'Free',
    status: 'Heritage',
    rating: 4.4,
    reviewCount: 56,
    icon: Icons.castle,
    lat: 34.6247,
    lng: 45.3125,
    imageUrls: [],
    reviews: [
      SiteReview(
        author: 'Karo R.',
        rating: 4,
        comment: 'Impressive architecture and incredible river views.',
        date: 'Aug 2025',
      ),
    ],
  ),
  HistoricalSite(
    id: 'khanzad_castle',
    name: 'Khanzad Castle',
    kurdishName: 'قەڵای خانزاد',
    city: 'Erbil',
    category: 'Castle',
    description:
        'A stone fortress built in the 16th century during the Soran Emirate by Princess Khanzad, a rare monument to Kurdish female leadership in the medieval era.',
    kurdishDescription:
        'قەڵایەکی بەردینە کە لە سەدەی ١٦ لە سەردەمی میرنشینی سۆران لەلایەن شازادە خانزادەوە دروستکراوە، کە سیمبولێکی دەگمەنی سەرکردایەتیی ئافرەتانی کوردە لە سەردەمی ناوەڕاستدا.',
    hours: '9 am – 5 pm',
    period: '16th century',
    entry: 'Free',
    status: 'Heritage',
    rating: 4.6,
    reviewCount: 89,
    icon: Icons.shield,
    lat: 36.3375,
    lng: 44.1167,
    imageUrls: [],
    reviews: [
      SiteReview(
        author: 'Shilan B.',
        rating: 5,
        comment: 'Such a powerful symbol of Kurdish history and women in power.',
        date: 'Sep 2025',
      ),
      SiteReview(
        author: 'Aram D.',
        rating: 4,
        comment: 'Beautiful views of the valley and well-preserved battlements.',
        date: 'Oct 2025',
      ),
    ],
  ),
  HistoricalSite(
    id: 'slemani_heritage',
    name: 'Sulaymaniyah Heritage',
    kurdishName: 'شوێنەواری سلێمانی',
    city: 'Sulaymaniyah',
    category: 'Heritage',
    description:
        'The cultural heart of southern Kurdistan, celebrated for traditional grand bazaars, the Goyzha mountain viewpoint, the Sulaymaniyah Museum, and centuries-old heritage archives.',
    kurdishDescription:
        'دڵی ڕۆشنبیریی باشووری کوردستانە، کە بە بازاڕە گەورە و کۆنەکانی، ڕوانگەی کێوی گۆیژە، مۆزەخانەی سلێمانی و ئەرشیفە چەندین سەدەییەکانی ناسراوە.',
    hours: 'All day',
    period: '18th century – present',
    entry: 'Free',
    status: 'Cultural District',
    rating: 4.7,
    reviewCount: 162,
    icon: Icons.museum,
    lat: 35.5558,
    lng: 45.4351,
    imageUrls: [],
    reviews: [
      SiteReview(
        author: 'Dashti F.',
        rating: 5,
        comment: 'The bazaar alone is worth the trip. Vibrant and alive with culture.',
        date: 'Oct 2025',
      ),
      SiteReview(
        author: 'Peshang N.',
        rating: 5,
        comment: 'The museum has extraordinary Assyrian and Sumerian artefacts.',
        date: 'Sep 2025',
      ),
    ],
  ),
];

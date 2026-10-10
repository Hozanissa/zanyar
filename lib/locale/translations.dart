// translations.dart
import 'package:get/get.dart';

/// All UI text lives here.
///
/// Keys written in snake_case are UI strings. Keys written as plain English
/// ('Citadel', 'Erbil', 'Folklore'...) are data labels: `'Citadel'.tr` gives
/// the Kurdish word in Kurdish mode and falls back to the English text itself.
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      // Navigation / profile
      'home': 'Home',
      'map': 'Map',
      'archive': 'Archive',
      'profile': 'Profile',
      'all_sites': 'All Sites',
      'interactive_map': 'INTERACTIVE MAP',
      'account': 'ACCOUNT',
      'language': 'Language',
      'dark_mode': 'Dark mode',
      'favorites': 'Favorites',
      'trip_requests': 'My trip requests',
      'notifications': 'Notifications',
      'sign_out': 'Sign out',

      // Splash / login
      'welcome_to_zanyar': 'Welcome to Zanyar',
      'login_to_continue': 'Login to continue',
      'journey_starts': 'Your journey starts here.',
      'email': 'Email',
      'enter_email': 'Enter Your Email',
      'password': 'Password',
      'enter_password': 'Enter Your Password',
      'login': 'Login',
      'or': 'Or',
      'sign_up': 'Sign up',
      'to_register': 'to register a new account',
      'forgot_password': 'Forgot your password?',
      'reset_password': 'Reset password',
      'email_required': 'Email is required',
      'email_must_gmail': 'Email must end with @gmail.com',
      'password_required': 'Password is required',
      'incorrect_password': 'Incorrect Password',
      'incorrect_email': 'Incorrect email',
      'invalid_credentials': 'Invalid email or password',

      // Register
      'create_account_title': 'Create a new account',
      'first_name': 'First Name',
      'enter_first_name': 'Enter Your First Name',
      'last_name': 'Last Name',
      'enter_last_name': 'Enter Your Last Name',
      'phone': 'Phone Number',
      'enter_phone': 'Enter Your Phone Number',
      'create_account': 'Create Account',
      'back_to_login': 'Back to login',
      'first_name_required': 'First name is required',
      'last_name_required': 'Last name is required',
      'phone_required': 'Phone number is required',
      'phone_digits': 'Phone number must contain digits only',
      'phone_short': 'Phone number is too short',
      'invalid_email': 'Please enter a valid email',
      'password_short': 'Password must be at least 6 characters',
      'account_created': 'Account created, go back to login screen',

      // Reset password
      'reset_your_password': 'Reset your password',
      'reset_instruction': 'Enter your email to receive a password reset link.',
      'send_link': 'Send Link',
      'no_account': 'No account found with this email',
      'link_sent': 'Reset link sent, check your email and go back to login',

      // Home
      'kurdistan': 'Kurdistan',
      'historical_sites': 'Historical Sites',
      'name_label': 'Name',

      // Archive
      'cultural_archive': 'CULTURAL ARCHIVE',
      'kurdish_heritage': 'Kurdish Heritage',
      'search_hint': 'Search @cat...',
      'read_more': 'Read more',
      'no_items': 'No items found',
      'the_story': 'The story',
      'cultural_significance': 'Cultural significance',
      'back_to': 'Back to @cat',

      // Map
      'reset_map_view': 'Reset Map View',
      'directions': 'Directions',
      'focus': 'Focus',
      'error': 'Error',
      'maps_error': 'Could not open Google Maps',
      'maps_app_error': 'Could not open maps application',

      // Admin panel
      'admin_title': 'Admin Control Panel',
      'admin_users': 'User Management',
      'admin_users_desc': 'Used to view user accounts, suspend/ban users who violate rules, reset accounts or handle account-related support.',
      'admin_content': 'Content Management',
      'admin_content_desc':
          'Used to manage sites, archive, and approve/reject trip listings.',
      'admin_companies': 'Travel Companies Management',
      'admin_companies_desc': 'Used to approve new travel companies, remove companies with bad ratings/reviews, and manage company profiles with their trips.',
      'admin_moderation': 'Moderation',
      'admin_moderation_desc': 'Review and moderate reviews/ratings, handle reported content and reported users.',
      'admin_analytics': 'Analytics',
      'admin_analytics_desc':
          'View number of users, trip requests, and most-viewed sites.',
    },
    'ckb_IQ': {
      // Navigation / profile
      'home': 'سەرەکی',
      'map': 'نەخشە',
      'archive': 'ئەرشیف',
      'all_sites': 'هەموو شوێنەکان',
      'interactive_map': 'نەخشەی کارلێککار',
      'account': 'هەژمار',
      'profile': 'پرۆفایل',
      'language': 'زمان',
      'dark_mode': 'دۆخی تاریک',
      'favorites': 'دڵخوازەکان',
      'trip_requests': 'داواکارییەکانی گەشتم',
      'notifications': 'ئاگادارکردنەوەکان',
      'sign_out': 'چوونەدەرەوە',

      // Splash / login
      'welcome_to_zanyar': 'بەخێربێیت بۆ زانیار',
      'login_to_continue': 'بچۆ ژوورەوە بۆ بەردەوامبوون',
      'journey_starts': 'گەشتەکەت لێرەوە دەست پێدەکات.',
      'email': 'ئیمەیڵ',
      'enter_email': 'ئیمەیڵەکەت بنووسە',
      'password': 'وشەی نهێنی',
      'enter_password': 'وشەی نهێنییەکەت بنووسە',
      'login': 'چوونەژوورەوە',
      'or': 'یان',
      'sign_up': 'خۆتۆمارکردن',
      'to_register': 'بۆ تۆمارکردنی هەژمارێکی نوێ',
      'forgot_password': 'وشەی نهێنیت لەبیرچووە؟',
      'reset_password': 'گۆڕینی وشەی نهێنی',
      'email_required': 'ئیمەیڵ پێویستە',
      'email_must_gmail': 'ئیمەیڵ دەبێت بە @gmail.com کۆتایی بێت',
      'password_required': 'وشەی نهێنی پێویستە',
      'incorrect_password': 'وشەی نهێنی هەڵەیە',
      'incorrect_email': 'ئیمەیڵ هەڵەیە',
      'invalid_credentials': 'ئیمەیڵ یان وشەی نهێنی هەڵەیە',

      // Register
      'create_account_title': 'هەژمارێکی نوێ دروست بکە',
      'first_name': 'ناوی یەکەم',
      'enter_first_name': 'ناوی یەکەمت بنووسە',
      'last_name': 'پاشناو',
      'enter_last_name': 'پاشناوەکەت بنووسە',
      'phone': 'ژمارەی مۆبایل',
      'enter_phone': 'ژمارەی مۆبایلەکەت بنووسە',
      'create_account': 'دروستکردنی هەژمار',
      'back_to_login': 'گەڕانەوە بۆ چوونەژوورەوە',
      'first_name_required': 'ناوی یەکەم پێویستە',
      'last_name_required': 'پاشناو پێویستە',
      'phone_required': 'ژمارەی مۆبایل پێویستە',
      'phone_digits': 'ژمارەی مۆبایل دەبێت تەنها ژمارە بێت',
      'phone_short': 'ژمارەی مۆبایل زۆر کورتە',
      'invalid_email': 'تکایە ئیمەیڵێکی دروست بنووسە',
      'password_short': 'وشەی نهێنی دەبێت لانیکەم 6 پیت بێت',
      'account_created': 'هەژمار دروستکرا، بگەڕێوە بۆ شاشەی چوونەژوورەوە',

      // Reset password
      'reset_your_password': 'وشەی نهێنیت بگۆڕە',
      'reset_instruction':
          'ئیمەیڵەکەت بنووسە بۆ وەرگرتنی بەستەری گۆڕینی وشەی نهێنی.',
      'send_link': 'ناردنی بەستەر',
      'no_account': 'هیچ هەژمارێک بەم ئیمەیڵە نەدۆزرایەوە',
      'link_sent': 'بەستەر نێردرا، ئیمەیڵەکەت بپشکنە و بگەڕێوە بۆ چوونەژوورەوە',

      // Home
      'kurdistan': 'کوردستان',
      'historical_sites': 'شوێنە مێژووییەکان',
      'name_label': 'ناو',

      // Archive
      'cultural_archive': 'ئەرشیفی کولتووری',
      'kurdish_heritage': 'کەلەپووری کوردی',
      'search_hint': 'گەڕان لە @cat...',
      'read_more': 'زیاتر بخوێنەوە',
      'no_items': 'هیچ شتێک نەدۆزرایەوە',
      'the_story': 'چیرۆکەکە',
      'cultural_significance': 'گرنگی کولتووری',
      'back_to': 'گەڕانەوە بۆ @cat',
      'Folklore': 'فۆلکلۆر',
      'Poets': 'شاعیران',
      'Scholars': 'زانایان',

      // Map
      'reset_map_view': 'گەڕاندنەوەی نەخشە',
      'directions': 'ڕێنمایی ڕێگا',
      'focus': 'نزیککردنەوە',
      'error': 'هەڵە',
      'maps_error': 'نەتوانرا گووگڵ مەپس بکرێتەوە',
      'maps_app_error': 'نەتوانرا بەرنامەی نەخشە بکرێتەوە',
      'All': 'هەموو',
      'Citadel': 'قەڵا',
      'Castle': 'کەلات',
      'Cave': 'ئەشکەوت',
      'Sanctuary': 'پەرستگا',
      'Heritage': 'کەلەپوور',
      'Erbil': 'هەولێر',
      'Duhok': 'دهۆک',
      'Erbil (Bradost)': 'هەولێر (بەرادۆست)',
      'Shekhan (Duhok)': 'شێخان (دهۆک)',
      'Kalar (Garmian)': 'کەلار (گەرمیان)',
      'Sulaymaniyah': 'سلێمانی',

      // Admin panel
      'admin_title': 'پانێڵی کۆنتڕۆڵی ئەدمین',
      'admin_users': 'بەڕێوەبردنی بەکارهێنەران',
      'admin_users_desc': 'بینینی هەژماری بەکارهێنەران، ڕاگرتن یان قەدەغەکردنی ئەوانەی یاسا پێشێل دەکەن، دووبارە دانانەوەی هەژمار و چارەسەرکردنی کێشەی هەژمارەکان.',
      'admin_content': 'بەڕێوەبردنی ناوەڕۆک',
      'admin_content_desc': 'بەڕێوەبردنی شوێنەکان و ئەرشیف و پەسەندکردن یان ڕەتکردنەوەی گەشتەکان.',
      'admin_companies': 'بەڕێوەبردنی کۆمپانیاکانی گەشتیاری',
      'admin_companies_desc': 'پەسەندکردنی کۆمپانیا نوێیەکان، لابردنی ئەو کۆمپانیایانەی هەڵسەنگاندنی خراپیان هەیە، و بەڕێوەبردنی پرۆفایلی کۆمپانیا و گەشتەکانیان.',
      'admin_moderation': 'چاودێریکردن',
      'admin_moderation_desc': 'پێداچوونەوە بە هەڵسەنگاندن و بۆچوونەکان و چارەسەرکردنی ناوەڕۆک و بەکارهێنەرە ڕاپۆرتکراوەکان.',
      'admin_analytics': 'ئامار',
      'admin_analytics_desc': 'بینینی ژمارەی بەکارهێنەران و داواکارییەکانی گەشت و زۆرترین شوێنی بینراو.',
    },
  };
}

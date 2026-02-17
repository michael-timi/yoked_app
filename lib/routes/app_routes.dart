import 'package:get/get.dart';
import '../core/bindings/app_bindings.dart';
import '../app/screens/auth/splash_screen.dart';
import '../app/screens/auth/start_screen.dart';
import '../app/screens/auth/login_screen.dart';
import '../app/screens/auth/account_setup_screen.dart';
import '../app/screens/auth/couple_goals_screen.dart';
import '../app/screens/auth/fasting_setup_screen.dart';
import '../app/screens/auth/focus_areas_screen.dart';
import '../app/screens/auth/prayer_intention_screen.dart';
import '../app/screens/auth/prayer_rhythm_screen.dart';
import '../app/screens/auth/relationship_stage_screen.dart';
import '../app/screens/auth/register_screen.dart';
import '../app/screens/home/home_screen.dart';
import '../app/screens/success_screen.dart';
import '../app/screens/main/main_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String start = '/start';
  static const String login = '/login';
  static const String register = '/register';
  static const String success = '/success';
  static const String accountSetup = '/account-setup';
  static const String relationshipStage = '/relationship-stage';
  static const String coupleGoals = '/couple-goals';
  static const String focusAreas = '/focus-areas';
  static const String prayerRhythm = '/prayer-rhythm';
  static const String prayerIntention = '/prayer-intention';
  static const String fastingSetup = '/fasting-setup';
  static const String main = '/main';
  static const String home = '/home';

  static final List<GetPage<dynamic>> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: start, page: () => const StartScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: success, page: () => const SuccessScreen()),
    GetPage(name: accountSetup, page: () => const AccountSetupScreen()),
    GetPage(
      name: relationshipStage,
      page: () => const RelationshipStageScreen(),
    ),
    GetPage(name: coupleGoals, page: () => const CoupleGoalsScreen()),
    GetPage(name: focusAreas, page: () => const FocusAreasScreen()),
    GetPage(name: prayerRhythm, page: () => const PrayerRhythmScreen()),
    GetPage(name: prayerIntention, page: () => const PrayerIntentionScreen()),
    GetPage(name: fastingSetup, page: () => const FastingSetupScreen()),
    GetPage(
      name: main,
      page: () => const MainScreen(),
      binding: MainBindings(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: HomeBindings(),
    ),
  ];
}

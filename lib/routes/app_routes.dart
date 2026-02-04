import 'package:get/get.dart';
import '../core/bindings/app_bindings.dart';
import '../app/screens/auth/splash_screen.dart';
import '../app/screens/auth/start_screen.dart';
import '../app/screens/auth/login_screen.dart';
import '../app/screens/auth/register_screen.dart';
import '../app/screens/home/home_screen.dart';
import '../app/screens/main/main_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String start = '/start';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String home = '/home';

  static final List<GetPage<dynamic>> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: start, page: () => const StartScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
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

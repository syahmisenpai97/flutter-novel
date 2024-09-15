import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kacs/views/pages/HomeScreen/home_screen.dart';
import 'package:kacs/views/pages/NovelDetailScreen/novel_details_screen.dart';
import 'package:kacs/views/pages/OTPScreen/otp_screen.dart';
import 'package:kacs/views/pages/SignInScreen/sign_in_screen.dart';
import 'package:kacs/views/pages/SignUpScreen/sign_up_screen.dart';
import 'package:kacs/views/pages/SplashScreen/splash_screen.dart';

class Routes {
  static const initialRoute = '/splash';
  static final List<GetPage> pages = [
    GetPage(
      name: '/home',
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: '/splash',
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: '/signIn',
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: '/signUp',
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: '/otp',
      page: () => const OTPScreen(),
    ),
    GetPage(
      name: '/details',
      page: () => const NovelDetailsScreen(),
    ),
    // GetPage(
    //   name: '/read',
    //   page: () => const ReadScreen(),
    // ),
  ];

  static String determineInitialRoute() {
    final box = GetStorage();
    return box.read('userData') != null ? '/home' : '/splash';
  }
}

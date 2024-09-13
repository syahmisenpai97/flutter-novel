import 'package:get/get.dart';
import 'package:kacs/views/pages/HomeScreen/home_screen.dart';
import 'package:kacs/views/pages/NovelDetailScreen/novel_details_screen.dart';
import 'package:kacs/views/pages/OTPScreen/otp_screen.dart';
import 'package:kacs/views/pages/ReadScreen/read_screen.dart';
import 'package:kacs/views/pages/SignInScreen/sign_in_screen.dart';
import 'package:kacs/views/pages/SignUpScreen/sign_up_screen.dart';

class Routes {
  static const initialRoute = '/home';
  static final List<GetPage> pages = [
    GetPage(
      name: '/home',
      page: () => const HomeScreen(),
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
}

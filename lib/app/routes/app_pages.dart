import 'package:get/get.dart';

import '../modules/landingPage/bindings/landing_page_binding.dart';
import '../modules/landingPage/views/landing_page_view.dart';
import '../modules/profileTab/bindings/profile_tab_binding.dart';
import '../modules/profileTab/views/profile_tab_view.dart';
import '../modules/shortsTab/bindings/shorts_tab_binding.dart';
import '../modules/shortsTab/views/shorts_tab_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGN_UP;

  static final routes = [
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.LANDING_PAGE,
      page: () => const LandingPageView(),
      binding: LandingPageBinding(),
    ),
    GetPage(
      name: _Paths.SHORTS_TAB,
      page: () => const ShortsTabView(),
      binding: ShortsTabBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_TAB,
      page: () => const ProfileTabView(),
      binding: ProfileTabBinding(),
    ),
  ];
}

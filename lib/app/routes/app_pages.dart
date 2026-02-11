import 'package:talktomylawyer/app/modules/authentication/login/bindings/login_binding.dart';
import 'package:talktomylawyer/app/modules/authentication/login/views/login_view.dart';
import 'package:talktomylawyer/app/modules/authentication/splash/bindings/splash_binding.dart';
import 'package:talktomylawyer/app/modules/authentication/splash/views/splash_view.dart';
import 'package:talktomylawyer/app/modules/home/bindings/home_binding.dart';
import 'package:talktomylawyer/app/modules/home/views/home_view.dart';
import 'package:talktomylawyer/app/modules/onboarding/bindings/onboarding_binding.dart';
import 'package:talktomylawyer/app/modules/onboarding/views/onboarding_view.dart';
import 'package:talktomylawyer/app/modules/role_selection/bindings/role_selection_binding.dart';
import 'package:talktomylawyer/app/modules/role_selection/views/role_selection_view.dart';
import 'package:talktomylawyer/app/modules/client_dashboard/bindings/client_dashboard_binding.dart';
import 'package:talktomylawyer/app/modules/client_dashboard/views/client_dashboard_view.dart';
import 'package:talktomylawyer/app/modules/client_home/bindings/client_home_binding.dart';
import 'package:talktomylawyer/app/modules/client_home/views/client_home_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.onboarding;
  // static const INITIAL = Routes.EXAMPLE_WIDGETS;
  // static const INITIAL = Routes.TEST_BOTTOMSHEET_THEME;

  static final routes = [
    //Testing Theme
    //Text Theme

    //-------------------------------------END THEME SCREENS----------------------------//
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.roleSelection,
      page: () => const RoleSelectionView(),
      binding: RoleSelectionBinding(),
    ),
    GetPage(
      name: _Paths.clientDashboard,
      page: () => const ClientDashboardView(),
      binding: ClientDashboardBinding(),
    ),
    GetPage(
      name: _Paths.clientHome,
      page: () => const ClientHomeView(),
      binding: ClientHomeBinding(),
    ),
  ];
}

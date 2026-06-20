import 'package:get/get.dart';
import 'package:talktomylawyer/app/modules/client_profile/bindings/client_profile_binding.dart';
import 'package:talktomylawyer/app/modules/client_profile/views/client_profile_view.dart';

// Shared auth
import '../modules/authentication/splash/bindings/splash_binding.dart';
import '../modules/authentication/splash/views/splash_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/role_selection/bindings/role_selection_binding.dart';
import '../modules/role_selection/views/role_selection_view.dart';

// Client auth
import '../modules/client_auth/client_login/bindings/client_login_binding.dart';
import '../modules/client_auth/client_login/views/client_login_view.dart';
import '../modules/client_auth/client_register/bindings/client_register_binding.dart';
import '../modules/client_auth/client_register/views/client_register_view.dart';

// Client dashboard
import '../modules/client_dashboard/bindings/client_dashboard_binding.dart';
import '../modules/client_dashboard/views/client_dashboard_view.dart';

// Lawyer auth
import '../modules/lawyer_auth/lawyer_login/bindings/lawyer_login_binding.dart';
import '../modules/lawyer_auth/lawyer_login/views/lawyer_login_view.dart';
import '../modules/lawyer_auth/lawyer_register/bindings/lawyer_register_binding.dart';
import '../modules/lawyer_auth/lawyer_register/views/lawyer_register_view.dart';

// Lawyer dashboard
import '../modules/lawyer_dashboard/bindings/lawyer_dashboard_binding.dart';
import '../modules/lawyer_dashboard/views/lawyer_dashboard_view.dart';
import '../modules/lawyer_details/bindings/lawyer_details_binding.dart';
import '../modules/lawyer_details/views/lawyer_details_view.dart';
import '../modules/lawyer_details/bindings/book_consultation_binding.dart';
import '../modules/lawyer_details/views/book_consultation_view.dart';
import '../modules/consultation_history/bindings/consultation_history_binding.dart';
import '../modules/consultation_history/views/consultation_history_view.dart';
import '../modules/consultation_details/bindings/consultation_details_binding.dart';
import '../modules/consultation_details/views/consultation_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
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

    // Client Auth
    GetPage(
      name: _Paths.clientLogin,
      page: () => const ClientLoginView(),
      binding: ClientLoginBinding(),
    ),
    GetPage(
      name: _Paths.clientRegister,
      page: () => const ClientRegisterView(),
      binding: ClientRegisterBinding(),
    ),

    // Client Dashboard
    GetPage(
      name: _Paths.clientDashboard,
      page: () => const ClientDashboardView(),
      binding: ClientDashboardBinding(),
    ),

    // Lawyer Details
    GetPage(
      name: _Paths.lawyerDetails,
      page: () => const LawyerDetailsView(),
      binding: LawyerDetailsBinding(),
    ),
    // Book Consultation
    GetPage(
      name: _Paths.bookConsultation,
      page: () => const BookConsultationView(),
      binding: BookConsultationBinding(),
    ),
    // Consultation History
    GetPage(
      name: _Paths.consultationHistory,
      page: () => const ConsultationHistoryView(),
      binding: ConsultationHistoryBinding(),
    ),
    // Consultation Details
    GetPage(
      name: _Paths.consultationDetails,
      page: () => const ConsultationDetailsView(),
      binding: ConsultationDetailsBinding(),
    ),
    // Client Profile Edit
    GetPage(
      name: _Paths.clientProfile,
      page: () => const ClientProfileView(),
      binding: ClientProfileBinding(),
    ),

    // Lawyer Auth
    GetPage(
      name: _Paths.lawyerLogin,
      page: () => const LawyerLoginView(),
      binding: LawyerLoginBinding(),
    ),
    GetPage(
      name: _Paths.lawyerRegister,
      page: () => const LawyerRegisterView(),
      binding: LawyerRegisterBinding(),
    ),

    // Lawyer Dashboard
    GetPage(
      name: _Paths.lawyerDashboard,
      page: () => const LawyerDashboardView(),
      binding: LawyerDashboardBinding(),
    ),
  ];
}

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  // Shared Auth
  static const splash = _Paths.splash;
  static const onboarding = _Paths.onboarding;
  static const roleSelection = _Paths.roleSelection;
  static const home = _Paths.home;
  static const login = _Paths.login;

  // Client Auth
  static const clientLogin = _Paths.clientLogin;
  static const clientRegister = _Paths.clientRegister;

  // Client App
  static const clientDashboard = _Paths.clientDashboard;
  static const clientHome = _Paths.clientHome;
  static const lawyerDetails = _Paths.lawyerDetails;
  static const bookConsultation = _Paths.bookConsultation;

  // Lawyer Auth
  static const lawyerLogin = _Paths.lawyerLogin;
  static const lawyerRegister = _Paths.lawyerRegister;

  // Lawyer App
  static const lawyerDashboard = _Paths.lawyerDashboard;
}

abstract class _Paths {
  _Paths._();
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const roleSelection = '/role_selection';
  static const home = '/home';
  static const login = '/login';

  static const clientLogin = '/client_login';
  static const clientRegister = '/client_register';
  static const clientDashboard = '/client_dashboard';
  static const clientHome = '/client_home';
  static const lawyerDetails = '/lawyer_details';
  static const bookConsultation = '/book_consultation';

  static const lawyerLogin = '/lawyer_login';
  static const lawyerRegister = '/lawyer_register';
  static const lawyerDashboard = '/lawyer_dashboard';
}

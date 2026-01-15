part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const MAIN = _Paths.MAIN;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const MY_REPORT = _Paths.MY_REPORT;
}

abstract class _Paths {
  static const HOME = '/';
  static const LOGIN = '/login';
  static const MAIN = '/main';
  static const DASHBOARD = '/dashboard';
  static const MY_REPORT = '/my-report';
}

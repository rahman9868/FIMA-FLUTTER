part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const DASHBOARD = _Paths.DASHBOARD;
}

abstract class _Paths {
  static const HOME = '/';
  static const LOGIN = '/login';
  static const DASHBOARD = '/dashboard';
}

// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const LOGIN = _Paths.LOGIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const HOME = _Paths.HOME;
  static const SETTINGS = _Paths.SETTINGS;
  static const PROFILE = _Paths.PROFILE;
  static const CONTACT = _Paths.CONTACT;
  static const DETAIL_PAGE = _Paths.DETAIL_PAGE;
    static const SAVED = _Paths.SAVED;

}

abstract class _Paths {
  //Home
  static const HOME = '/home';
  static const SETTINGS = '/settings';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const PROFILE = '/profile';
  static const CONTACT = '/contact_us';
  static const DETAIL_PAGE = '/detail-page';
    static const SAVED = '/saved-articles';

}

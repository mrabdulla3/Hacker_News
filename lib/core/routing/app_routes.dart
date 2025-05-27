// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const DETAIL_PAGE = _Paths.DETAIL_PAGE;
}

abstract class _Paths {
  //Home
  static const HOME = '/home';
  static const DETAIL_PAGE = '/detail-page';
}

import 'package:get/get.dart';
import 'package:hacker_news/controllers/detail_page_controller.dart';
import 'package:hacker_news/controllers/home_controller.dart';
import 'package:hacker_news/views/detail_page.dart';
import 'package:hacker_news/views/home.dart';

part 'app_routes.dart';

class AppPages {
  static final List<GetPage<dynamic>> routes = [
    // GetPage(
    //   name: _Paths.SPLASH,
    //   page: () => const SplashView(),
    // ),

    // HOME
    GetPage(
      name: _Paths.HOME,
      page: () => const Home(),
      binding: BindingsBuilder(
        () => Get.lazyPut<HomeController>(() => HomeController()),
      ),
    ),

    GetPage(
      name: _Paths.DETAIL_PAGE,
      page: () {
        final link = Get.arguments as String;
        return DetailPage(link: link);
      },
      binding: BindingsBuilder(() {
        final link = Get.arguments as String;
        Get.lazyPut<DetailPageController>(() => DetailPageController(link));
      }),
    ),
  ];
}

class BindingsX {
  static BindingsBuilder initialBindings() {
    return BindingsBuilder(() {
      Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    });
  }
}

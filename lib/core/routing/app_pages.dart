import 'package:get/get.dart';
import 'package:hacker_news/controllers/contactus_controller.dart';
import 'package:hacker_news/controllers/detail_page_controller.dart';
import 'package:hacker_news/controllers/home_controller.dart';
import 'package:hacker_news/controllers/login_controller.dart';
import 'package:hacker_news/controllers/profile_controller.dart';
import 'package:hacker_news/controllers/saved_controller.dart';
import 'package:hacker_news/controllers/settings_controller.dart';
import 'package:hacker_news/controllers/signup_controller.dart';
import 'package:hacker_news/views/contactus_screen.dart';
import 'package:hacker_news/views/detail_page.dart';
import 'package:hacker_news/views/home.dart';
import 'package:hacker_news/views/login_screen.dart';
import 'package:hacker_news/views/profile_screen.dart';
import 'package:hacker_news/views/saved_screen.dart';
import 'package:hacker_news/views/settings_screen.dart';
import 'package:hacker_news/views/signup_screen.dart';

part 'app_routes.dart';

class AppPages {
  static final List<GetPage<dynamic>> routes = [
    // GetPage(
    //   name: _Paths.SPLASH,
    //   page: () => const SplashView(),
    // ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<LoginController>(() => LoginController()),
      ),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignUpScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<SignupController>(() => SignupController()),
      ),
    ),

    // HOME
    GetPage(
      name: _Paths.HOME,
      page: () => const Home(),
      binding: BindingsBuilder(
        () => Get.lazyPut<HomeController>(() => HomeController()),
      ),
    ),

    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<SettingsController>(() => SettingsController()),
      ),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<ProfileController>(() => ProfileController()),
      ),
    ),
    GetPage(
      name: _Paths.CONTACT,
      page: () => const ContactUsScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<ContactusController>(() => ContactusController()),
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
    GetPage(
      name: _Paths.SAVED,
      page: () => SavedScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<SavedController>(() => SavedController()),
      ),
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

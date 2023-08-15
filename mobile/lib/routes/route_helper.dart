import 'package:food_express/base/custom_info_page.dart';
import 'package:food_express/pages/account/account_page.dart';
import 'package:food_express/pages/account/edit_profile_page.dart';
import 'package:food_express/pages/location/location_page.dart';
import 'package:food_express/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import '../pages/account/auth/sign_in_page.dart';
import '../pages/account/auth/sign_up_page.dart';
import '../pages/cart/cart_page.dart';
import '../pages/food/popular_food_details.dart';
import '../pages/home/home_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String editprofile = "/edit-profile";
  static const String accountPage = "/account-page";
  static const String locationPage = "/location-page";
  static const String cartPage = "/cart-page";
  static const String signUp = "/sign-up";
  static const String signIn = "/sign-in";

  static String getSplashPage() => splashPage;
  static String getInitial(int index) => '$initial?index=$index';
  static String getPopularFood(int pageId, String page) => '$popularFood?pageId=$pageId&page=$page';
  static String getEditProfilePage() => editprofile;
  static String getAccountPage() => accountPage;
  static String getLocationPage() => locationPage;
  static String getCartPage() => cartPage;
  static String getSignUpPage() => signUp;
  static String getSignInPage() => signIn;

  static List<GetPage> routes = [
    GetPage(
        name: splashPage,
        page: () {
          return const SplashPage();
        }),
    GetPage(
      name: initial,
      page: () {
        int index = int.parse(Get.parameters['index']!);
        return HomePage(selectedIndex: index);
      },
    ),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(
            pageId: int.parse(pageId!),
            page: page!,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: editprofile,
        page: () {
          return EditProfilePage();
        },
        transition: Transition.rightToLeft),
    GetPage(
      name: accountPage,
      page: () {
        return const AccountPage();
      },
    ),
    GetPage(
        name: locationPage,
        page: () {
          return LocationPage();
        },
        transition: Transition.rightToLeft),
    GetPage(
      name: cartPage,
      page: () {
        return const CartPage();
      },
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
        name: signUp,
        page: () {
          return SignUpPage();
        }),
    GetPage(
        name: signIn,
        page: () {
          return SignInPage();
        },
        transition: Transition.fade),
  ];
}

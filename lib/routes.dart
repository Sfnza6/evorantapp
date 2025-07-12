import 'package:get/get.dart';
import 'package:iforenta_app/controllers/auth/RegisterController.dart';
import 'package:iforenta_app/models/category.dart';
import 'package:iforenta_app/models/food_item.dart';
import 'package:iforenta_app/routes/app_routes.dart';
import 'package:iforenta_app/views/OrderStatusScreen.dart';
import 'package:iforenta_app/views/category_items_screen.dart';
import 'package:iforenta_app/views/checkout_screen.dart';
import 'package:iforenta_app/views/forgot_password_screen.dart';
import 'package:iforenta_app/views/home_screen.dart';
import 'package:iforenta_app/views/login_screen.dart';
import 'package:iforenta_app/views/onboarding_screen.dart';
import 'package:iforenta_app/views/product/product_detail_screen.dart';
import 'package:iforenta_app/views/register_screen.dart';
import 'package:iforenta_app/views/resetPassword.dart';
import 'package:iforenta_app/views/success_resetpassword.dart';
import 'package:iforenta_app/views/success_signup.dart';
import 'package:iforenta_app/views/verifaycodesignup.dart';
import 'package:iforenta_app/views/verification_screen.dart';
import 'package:iforenta_app/views/welcome_screen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: AppRoutes.onboarding,
    page: () => const OnboardingScreen(),
  ),
  GetPage(
    name: AppRoutes.welcome,
    page: () => WelcomeScreen(),
  ),
  GetPage(
    name: AppRoutes.register,
    page: () => RegisterScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut<SignUpControllerImp>(() => SignUpControllerImp());
    }),
  ),
  GetPage(
    name: AppRoutes.login,
    page: () => LoginScreen(),
  ),
  GetPage(
    name: AppRoutes.forgotPassword,
    page: () => ForgetPassword(),
  ),
  GetPage(
    name: AppRoutes.verification,
    page: () => Verifaycode(),
  ),
  GetPage(name: AppRoutes.resetPassword, page: () => const Resetpassword()),
  GetPage(
    name: AppRoutes.successSignup,
    page: () => const Successsignup(),
  ),
  GetPage(
    name: AppRoutes.verifaycodesignup,
    page: () => Verifaycodesignup(),
  ),
  GetPage(
    name: AppRoutes.successResetPassword,
    page: () => Successresetpassword(),
  ),
  GetPage(
    name: AppRoutes.homepage,
    page: () => HomeScreen(),
  ),
  GetPage(
    name: AppRoutes.productDetail,
    page: () {
      final FoodItem item = Get.arguments as FoodItem;
      return ProductDetailScreen(item: item);
    },
  ),
  GetPage(
    name: AppRoutes.checkout, // ← new
    page: () => CheckoutScreen(),
  ),
  GetPage(
    name: AppRoutes.categoryitems,
    page: () => CategoryItemsScreen(category: Get.arguments as Category),
  ),
  GetPage(
    name: AppRoutes.orderStatus,
    page: () => const OrderStatusScreen(),
  ),
];

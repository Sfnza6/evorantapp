import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iforenta_app/routes/app_routes.dart';
import 'package:iforenta_app/services/services.dart';

class Mymiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  Myservices myservices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (myservices.sharedPreferences.getString("onboarding") == "1") {
      return RouteSettings(name: AppRoutes.login);
    }
    return null;
  }
}

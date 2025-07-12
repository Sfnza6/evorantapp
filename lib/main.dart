import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iforenta_app/bindings/app_bindings.dart';
import 'package:iforenta_app/routes.dart';
import 'package:iforenta_app/views/main_navigation.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const IforentaApp());
}

class IforentaApp extends StatelessWidget {
  const IforentaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: MainNavigation(), // ← هنا
        debugShowCheckedModeBanner: false,
        title: 'Iforenta',
        initialBinding: AppBindings(), // 💡 هنا ربط الكنترولر
        initialRoute: AppRoutes.homepage, // أو welcome لو onboarding خلصت
        getPages: routes // 💡 هنا قائمة الصفحات

        );
  }
}

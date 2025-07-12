// lib/views/main_navigation.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iforenta_app/views/cart_screen.dart';
import 'package:iforenta_app/views/favorites_screen.dart';
import 'package:iforenta_app/views/home_screen.dart';
import 'package:iforenta_app/views/profile_screen.dart';
import '../controllers/navigation_controller.dart';

class MainNavigation extends StatelessWidget {
  final NavigationController controller = Get.put(NavigationController());

  final List<Widget> screens = [
    HomeScreen(),
    CartScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: IndexedStack(
            index: controller.currentIndex.value,
            children: screens,
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   currentIndex: controller.currentIndex.value,
          //   onTap: controller.changePage,
          //   selectedItemColor: Colors.redAccent,
          //   unselectedItemColor: Colors.grey,
          //   items: const [
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.home), label: "الرئيسية"),
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.shopping_cart), label: "السلة"),
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.favorite), label: "المفضلة"),
          //     BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
          //   ],
          // ),
        ));
  }
}

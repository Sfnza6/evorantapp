// lib/views/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iforenta_app/views/cart_screen.dart';
import 'package:iforenta_app/views/favorites_screen.dart';
import 'package:iforenta_app/views/profile_screen.dart';
import 'package:iforenta_app/views/widgets/category_item.dart';
import 'package:iforenta_app/views/widgets/food_item_card.dart';
import 'package:iforenta_app/views/widgets/offers_carousel.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/navigation_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/favorite_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final navCtrl = Get.put(NavigationController());
  final homeCtrl = Get.put(HomeController());
  final cartCtrl = Get.put(CartController());
  final favCtrl = Get.put(FavoriteController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      homeCtrl.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _mainContent(),
      const CartScreen(),
      const FavoritesScreen(),
      const ProfileScreen(),
    ];

    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          body: IndexedStack(
            index: navCtrl.currentIndex.value,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navCtrl.currentIndex.value,
            onTap: navCtrl.changePage,
            selectedItemColor: Colors.redAccent,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'الرئيسية'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'السلة'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'المفضلة'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
            ],
          ),
        ));
  }

  Widget _mainContent() {
    return SafeArea(
      child: Obx(() {
        if (homeCtrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: homeCtrl.loadData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1) Slider Offers

                OffersCarousel(images: homeCtrl.sliderImages),

                const SizedBox(height: 16),

                // 2) Categories
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('الفئات',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),

                const SizedBox(height: 8),
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: homeCtrl.categories.length,
                    itemBuilder: (_, i) =>
                        CategoryItem(category: homeCtrl.categories[i]),
                  ),
                ),

                const SizedBox(height: 16),

                // 3) Featured Items
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('الأصناف المميزة',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: homeCtrl.featuredItems.length,
                    itemBuilder: (_, i) => SizedBox(
                      width: 200,
                      child: FoodItemCard(
                          item: homeCtrl.featuredItems[i], isFeatured: true),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 4) All Items
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('جميع الأصناف',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeCtrl.foodItems.length,
                  itemBuilder: (_, i) =>
                      FoodItemCard(item: homeCtrl.foodItems[i]),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

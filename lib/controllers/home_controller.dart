// lib/controllers/home_controller.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/category.dart';
import '../models/offer.dart';
import '../models/food_item.dart';
import '../services/api_service.dart';

class HomeController extends GetxController {
  final ApiService api = ApiService();

  var isLoading = false.obs;
  var categories = <Category>[].obs;
  var offers = <Offer>[].obs;
  var featuredItems = <FoodItem>[].obs;
  var foodItems = <FoodItem>[].obs;

  var sliderImages = <String>[].obs;
  late final PageController sliderController;
  Timer? sliderTimer;
  int currentSlide = 0;

  @override
  void onInit() {
    super.onInit();
    sliderController = PageController(viewportFraction: 0.9);
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      isLoading(true);
      final results = await Future.wait([
        api.fetchCategories(),
        api.fetchOffers(),
        api.fetchFeaturedItems(),
        api.fetchAllItems(),
      ]);
      categories.assignAll(results[0] as List<Category>);
      offers.assignAll(results[1] as List<Offer>);
      featuredItems.assignAll(results[2] as List<FoodItem>);
      foodItems.assignAll(results[3] as List<FoodItem>);
      sliderImages.assignAll(offers.map((o) => o.imageUrl).toList());
    } catch (e) {
      Get.snackbar('خطأ', 'فشل تحميل البيانات:\n$e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
      _startSliderAutoScroll();
    }
  }

  Future<void> loadData() async {
    await _loadData();
  }

  void _startSliderAutoScroll() {
    sliderTimer?.cancel();
    if (sliderImages.isEmpty) return;
    sliderTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!sliderController.hasClients) return;
      currentSlide = (currentSlide + 1) % sliderImages.length;
      sliderController.animateToPage(
        currentSlide,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void onClose() {
    sliderTimer?.cancel();
    sliderController.dispose();
    super.onClose();
  }
}

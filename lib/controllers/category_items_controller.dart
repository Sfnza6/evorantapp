// lib/controllers/category_items_controller.dart
import 'package:get/get.dart';
import '../models/food_item.dart';
import '../services/api_service.dart';

class CategoryItemsController extends GetxController {
  final int categoryId;
  CategoryItemsController(this.categoryId);

  var isLoading = false.obs;
  var items = <FoodItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    try {
      isLoading(true);
      items.assignAll(await ApiService().fetchItemsByCategory(categoryId));
    } finally {
      isLoading(false);
    }
  }
}

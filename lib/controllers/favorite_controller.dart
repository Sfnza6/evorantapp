import 'package:get/get.dart';
import '../models/food_item.dart';
import '../services/api_service.dart';
import 'user_session_controller.dart';

class FavoriteController extends GetxController {
  final api = ApiService();
  final session = Get.find<UserSessionController>();

  var isLoading = false.obs;
  var favorites = <FoodItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    ever(session.userId, (int? uid) {
      if (uid == null) {
        favorites.clear();
      } else {
        loadFavorites();
      }
    });
  }

  Future<void> loadFavorites() async {
    final uid = session.userId.value!;
    try {
      isLoading(true);
      favorites.assignAll(await api.fetchFavorites(uid));
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleFavorite(FoodItem item) async {
    final uid = session.userId.value!;
    final exists = favorites.any((f) => f.id == item.id);
    if (exists) {
      await api.removeFavorite(uid, item.id);
    } else {
      await api.addFavorite(uid, item.id);
    }
    // إعادة التحميل تلقائيًا
    await loadFavorites();
  }
}

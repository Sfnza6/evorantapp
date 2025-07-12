import 'package:get/get.dart';
import '../models/cart_item.dart';
import '../services/api_service.dart';
import 'user_session_controller.dart';

class CartController extends GetxController {
  final api = ApiService();
  final session = Get.find<UserSessionController>();

  var isLoading = false.obs;
  var items = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    // عند تغيّر المستخدم: إذا null فرّغ القوائم، وإلاّ حمّل السلة
    ever(session.userId, (int? uid) {
      if (uid == null) {
        items.clear();
      } else {
        loadCart();
      }
    });
  }

  /// جلب محتوى السلة
  Future<void> loadCart() async {
    final uid = session.userId.value!;
    try {
      isLoading(true);
      items.assignAll(await api.fetchCart(uid));
    } finally {
      isLoading(false);
    }
  }

  double get totalAmount =>
      items.fold(0.0, (sum, ci) => sum + ci.quantity * ci.item.price);

  /// إضافة صنف جديد للسلة
  Future<void> addToCart(int itemId) async {
    final uid = session.userId.value!;
    await api.addToCart(uid, itemId, 1);
    // إعادة التحميل فورًا
    await loadCart();
  }

  /// زيادة/نقصان الكمية أو حذف الصنف
  Future<void> changeQuantity(CartItem ci, int delta) async {
    // ignore: unused_local_variable
    final uid = session.userId.value!;
    final newQty = ci.quantity + delta;
    if (newQty <= 0) {
      await api.removeCartItem(ci.id);
    } else {
      await api.updateCartItem(ci.id, newQty);
    }
    // إعادة التحميل فورًا
    await loadCart();
  }
}

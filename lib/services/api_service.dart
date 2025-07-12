// lib/services/api_service.dart

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:iforenta_app/models/cart_item.dart';
import 'package:iforenta_app/models/user.dart';
import '../config.dart';
import '../models/category.dart';
import '../models/offer.dart';
import '../models/food_item.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: Config.apiBaseUrl, // e.g. 'http://10.0.2.2/iforenta_api/'
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
          validateStatus: (status) => status != null && status < 500,
        ));

  Future<User> loginWithPhone(String phone, String password) async {
    final resp = await _dio.post('login.php', data: {
      'phone': phone,
      'password': password,
    });
    if (resp.statusCode == 200 && resp.data['status'] == 'success') {
      return User.fromJson(resp.data['user']);
    }
    throw Exception(resp.data['message'] ?? 'Login failed');
  }

  /// --- Categories ---

  Future<List<Category>> fetchCategories() async {
    final resp = await _dio.get('get_categories.php');
    if (resp.statusCode == 200 && resp.data is List) {
      return (resp.data as List)
          .map((j) => Category.fromJson(j as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// --- Offers ---

  Future<List<Offer>> fetchOffers() async {
    final resp = await _dio.get('get_offers.php');
    if (resp.statusCode == 200 && resp.data is List) {
      return (resp.data as List)
          .map((j) => Offer.fromJson(j as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// --- Featured Items (if supported) ---

  // جلب الأصناف المميزة
  Future<List<FoodItem>> fetchFeaturedItems() async {
    final resp = await _dio.get('get_featured_items.php');
    if (resp.statusCode == 200 && resp.data is List) {
      return (resp.data as List)
          .map((j) => FoodItem.fromJson(j as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// --- All Items ---

  Future<List<FoodItem>> fetchAllItems() async {
    final resp = await _dio.get('get_items.php');
    if (resp.statusCode == 200 && resp.data is List) {
      return (resp.data as List)
          .map((j) => FoodItem.fromJson(j as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<List<FoodItem>> fetchItemsByCategory(int categoryId) async {
    final resp = await _dio.get('get_items.php', queryParameters: {
      'category_id': categoryId,
    });
    if (resp.statusCode == 200 && resp.data is List) {
      return (resp.data as List)
          .map((j) => FoodItem.fromJson(j as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<User?> fetchUser(int userId) async {
    final resp = await _dio.get(
      'get_user.php',
      queryParameters: {'user_id': userId},
    );
    print('👤 fetchUser → ${resp.statusCode} / ${resp.data}');
    if (resp.statusCode == 200 && resp.data is Map<String, dynamic>) {
      return User.fromJson(resp.data as Map<String, dynamic>);
    }
    return null;
  }
  // ===== Cart =====

  Future<List<CartItem>> fetchCart(int userId) async {
    final resp = await _dio.get('get_cart.php', queryParameters: {
      'user_id': userId,
    });
    if (resp.statusCode == 200 && resp.data is List) {
      return (resp.data as List)
          .map((j) => CartItem.fromJson(j as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<void> addToCart(int userId, int itemId, int qty) async {
    final resp = await _dio.post('add_to_cart.php', data: {
      'user_id': userId,
      'item_id': itemId,
      'quantity': qty,
    });
    if (resp.statusCode != 200 || resp.data['status'] != 'success') {
      throw Exception('Failed to add to cart: ${resp.data}');
    }
  }

  Future<void> updateCartItem(int cartItemId, int qty) async {
    final resp = await _dio.post('update_cart_item.php', data: {
      'cart_item_id': cartItemId,
      'quantity': qty,
    });
    if (resp.statusCode != 200 || resp.data['status'] != 'success') {
      throw Exception('Failed to update cart item: ${resp.data}');
    }
  }

  Future<void> removeCartItem(int cartItemId) async {
    final resp = await _dio.post('remove_cart_item.php', data: {
      'cart_item_id': cartItemId,
    });
    if (resp.statusCode != 200 || resp.data['status'] != 'success') {
      throw Exception('Failed to remove cart item: ${resp.data}');
    }
  }

  // ===== Favorites =====

  Future<List<FoodItem>> fetchFavorites(int userId) async {
    final resp = await _dio.get('get_favorites.php', queryParameters: {
      'user_id': userId,
    });
    if (resp.statusCode == 200 && resp.data is List) {
      return (resp.data as List)
          .map((j) => FoodItem.fromJson(j as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<void> addFavorite(int userId, int itemId) async {
    final resp = await _dio.post('add_favorite.php', data: {
      'user_id': userId,
      'item_id': itemId,
    });
    if (resp.statusCode != 200 || resp.data['status'] != 'success') {
      throw Exception('Failed to add favorite: ${resp.data}');
    }
  }

  Future<void> removeFavorite(int userId, int itemId) async {
    final resp = await _dio.post('remove_favorite.php', data: {
      'user_id': userId,
      'item_id': itemId,
    });
    if (resp.statusCode != 200 || resp.data['status'] != 'success') {
      throw Exception('Failed to remove favorite: ${resp.data}');
    }
  }

  /// جلب حالة الطلب
  Future<String> fetchOrderStatus(int orderId) async {
    try {
      final resp = await _dio
          .get('order_status.php', queryParameters: {'order_id': orderId});
      final data = resp.data;
      if (data is Map<String, dynamic> && data['status'] is String) {
        return data['status'] as String;
      }
      // لو رجع نص JSON
      if (data is String) {
        final m = jsonDecode(data);
        if (m is Map && m['status'] is String) {
          return m['status'] as String;
        }
      }
      return 'pending';
    } catch (_) {
      return 'pending';
    }
  }

  /// تنشئ الطلب في الـ backend وترجع رقمه
  Future<int> createOrder(
      int userId, List<CartItem> items, String address) async {
    final resp = await _dio.post(
      'create_order.php',
      data: {
        'user_id': userId,
        'items': items
            .map((ci) => {'item_id': ci.item.id, 'quantity': ci.quantity})
            .toList(),
        'address': address,
      },
    );
    // نتوقع resp.data['order_id'] هو int
    return resp.data['order_id'] as int;
  }
}

// lib/views/sections/home_content.dart
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          SizedBox(height: 16),
          Text("🔥 إعلانات العروض هنا (Slider)"),
          SizedBox(height: 24),
          Text("🍔 الفئات (مثل بيتزا، برجر...)"),
          SizedBox(height: 24),
          Text("📋 قائمة جميع الأصناف"),
        ],
      ),
    );
  }
}

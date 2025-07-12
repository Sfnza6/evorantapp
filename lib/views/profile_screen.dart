import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iforenta_app/controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('حسابي'),
        backgroundColor: Colors.redAccent,
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final u = ctrl.user.value;
        if (u == null) {
          return const Center(child: Text('لم يتم العثور على بيانات المستخدم'));
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('اسم المستخدم'),
                subtitle: Text(u.username),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('رقم الهاتف'),
                subtitle: Text(u.phone),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: ctrl.logout,
                  icon: const Icon(Icons.logout),
                  label: const Text('تسجيل الخروج'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

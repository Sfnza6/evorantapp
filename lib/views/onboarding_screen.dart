import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../controllers/onboarding_controller.dart';
import 'onboard_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ربط الكنترولر
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          // ✅ PageView بدون Obx، لأننا ما نستخدم Rx داخله مباشرة
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: (index) {
              controller.currentPage.value = index;
            },
            itemCount: controller.onboardingPages.length,
            itemBuilder: (context, index) {
              final page = controller.onboardingPages[index];
              return OnboardPage(
                image: page['image']!,
                title: page['title']!,
                description: page['desc']!,
              );
            },
          ),

          // ✅ زر "تخطي"
          Positioned(
            bottom: 40,
            left: 20,
            child: TextButton(
              onPressed: controller.skip,
              child: const Text("Skip", style: TextStyle(color: Colors.grey)),
            ),
          ),

          // ✅ مؤشر الصفحات (بدون Obx لأنه لا يعتمد على Rx)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: controller.pageController,
                count: controller.onboardingPages.length,
                effect: WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: Colors.green,
                  dotColor: Colors.grey.shade300,
                ),
              ),
            ),
          ),

          // ✅ زر السهم أو "ابدأ" - Obx لأننا نراقب currentPage
          Positioned(
            bottom: 40,
            right: 20,
            child: Obx(() => IconButton(
                  onPressed: controller.nextPage,
                  icon: Icon(
                    controller.currentPage.value ==
                            controller.onboardingPages.length - 1
                        ? Icons.check
                        : Icons.arrow_forward,
                    color: Colors.green,
                    size: 28,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

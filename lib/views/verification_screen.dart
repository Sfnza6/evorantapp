import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:get/get.dart';
import 'package:iforenta_app/controllers/forgetpassword/verification_controller.dart';
import 'package:iforenta_app/views/widgets/customtextbodyauth.dart';
import 'package:iforenta_app/views/widgets/customtexttitleauth.dart';

class Verifaycode extends StatelessWidget {
  const Verifaycode({super.key});

  @override
  Widget build(BuildContext context) {
    VerifiycodecontrollerImp controller = Get.put(VerifiycodecontrollerImp());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Verification Code",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              const SizedBox(height: 50),

              const Customtexttitle(text: "Check Code"),

              const SizedBox(height: 10),

              const Customtextbodyayth(
                text: "Please enter the 5-digit code sent to your email.",
              ),

              const SizedBox(height: 30),

              // ✅ OtpTextField
              OtpTextField(
                numberOfFields: 5,
                borderColor: const Color(0xFF512DA8),
                focusedBorderColor: Colors.green,
                borderRadius: BorderRadius.circular(10),
                fieldWidth: 50,
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) {
                  controller.goToResetpassword();
                },
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

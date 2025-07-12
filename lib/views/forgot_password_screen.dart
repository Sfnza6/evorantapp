import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iforenta_app/controllers/forgetpassword/forgot_password_controller.dart';
import 'package:iforenta_app/views/widgets/custombuttonauth.dart';
import 'package:iforenta_app/views/widgets/customtextbodyauth.dart';
import 'package:iforenta_app/views/widgets/customtextformauth.dart';
import 'package:iforenta_app/views/widgets/customtexttitleauth.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetPasswordControllerImp controller =
        Get.put(ForgetPasswordControllerImp());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Forget Password",
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
              const Customtexttitle(text: "Check sms"),
              const SizedBox(height: 10),
              const Customtextbodyayth(
                text: "Please Enter Your sms to Receive a Verification Code.",
              ),
              const SizedBox(height: 20),
              // Phone
              CustomAuthTextFormField(
                mycontroller: controller.phone,
                hinttext: "Enter your phone number",
                iconData: Icons.phone_android_outlined,
                labelttext: "Phone",
                isNumber: true,
                valid: (val) => val!.length < 9 ? "Invalid phone" : null,
              ),
              const SizedBox(height: 20),
              CustomButtomAuth(
                text: "Check",
                onPressed: () {
                  controller.goToVerifyCode();
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

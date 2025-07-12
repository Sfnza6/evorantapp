import 'package:flutter/material.dart';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:iforenta_app/controllers/auth/verifaycodesignup_controller.dart';
import 'package:iforenta_app/views/widgets/customtextbodyauth.dart';
import 'package:iforenta_app/views/widgets/customtexttitleauth.dart';

class Verifaycodesignup extends StatelessWidget {
  const Verifaycodesignup({super.key});

  @override
  Widget build(BuildContext context) {
    VerifiycodesignupcontrollerImp controller =
        Get.put(VerifiycodesignupcontrollerImp());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            "Verifacation Code",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Customtexttitle(text: "Check Code"),
              const SizedBox(
                height: 10,
              ),
              const Customtextbodyayth(
                text: "Please Enter The Digit Code Sent To ",
              ),
              const SizedBox(
                height: 15,
              ),
              OtpTextField(
                fieldWidth: 50.0,
                borderRadius: BorderRadius.circular(10),
                numberOfFields: 5,
                borderColor: const Color(0xFF512DA8),
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  controller.goTosuccesssignup();
                }, // end onSubmit
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        )));
  }
}

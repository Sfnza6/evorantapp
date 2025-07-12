import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iforenta_app/controllers/auth/successsignup_controller.dart';
import 'package:iforenta_app/views/widgets/custombuttonauth.dart';

class Successsignup extends StatelessWidget {
  const Successsignup({super.key});

  @override
  Widget build(BuildContext context) {
    Successsignupcontrollerimp controller =
        Get.put(Successsignupcontrollerimp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text('Success',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: Colors.grey)),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          const Center(
              child: Icon(Icons.check_circle_outline,
                  size: 200, color: Colors.blue)),
          Text("....",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 30)),
          const Text("...."),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: CustomButtomAuth(
                text: "Go to login",
                onPressed: () {
                  controller.gotopagelogin();
                }),
          ),
          const SizedBox(height: 30)
        ]),
      ),
    );
  }
}

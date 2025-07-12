import 'package:flutter/material.dart';

class CustomAuthTextFormField extends StatelessWidget {
  final TextEditingController mycontroller;
  final String hinttext;
  final String labelttext;
  final IconData? iconData;
  final bool? obscuretext;
  final void Function()? onTapicon;
  final String? Function(String?)? valid;
  final bool isNumber;

  const CustomAuthTextFormField({
    super.key,
    required this.mycontroller,
    required this.hinttext,
    required this.labelttext,
    this.iconData,
    this.obscuretext,
    this.onTapicon,
    this.valid,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: TextFormField(
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: valid,
        controller: mycontroller,
        obscureText: obscuretext ?? false,
        decoration: InputDecoration(
          hintText: hinttext,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          label: Text(labelttext),
          suffixIcon: iconData != null
              ? InkWell(
                  onTap: onTapicon,
                  child: Icon(iconData),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}

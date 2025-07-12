import 'package:flutter/material.dart';

class Customtexttitle extends StatelessWidget {
  final String text;
  const Customtexttitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    );
  }
}

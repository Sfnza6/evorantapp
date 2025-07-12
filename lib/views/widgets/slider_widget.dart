// lib/views/widgets/slider_widget.dart

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SliderWidget extends StatelessWidget {
  final List<String> images;
  const SliderWidget({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.9),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: images[index],
              fit: BoxFit.cover,
              placeholder: (_, __) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (_, __, ___) => const Icon(Icons.error_outline),
            ),
          );
        },
      ),
    );
  }
}

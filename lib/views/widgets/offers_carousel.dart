// lib/views/widgets/offers_carousel.dart

import 'dart:async';
import 'package:flutter/material.dart';

class OffersCarousel extends StatefulWidget {
  final List<String> images;
  const OffersCarousel({super.key, required this.images});

  @override
  _OffersCarouselState createState() => _OffersCarouselState();
}

class _OffersCarouselState extends State<OffersCarousel> {
  late final PageController _controller;
  late Timer _timer;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.9);

    if (widget.images.isNotEmpty) {
      // تمرير تلقائي كل 5 ثواني
      _timer = Timer.periodic(const Duration(seconds: 5), (_) {
        if (!_controller.hasClients) return;
        _current = (_current + 1) % widget.images.length;
        _controller.animateToPage(
          _current,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.images.length,
        itemBuilder: (ctx, index) {
          final url = widget.images[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

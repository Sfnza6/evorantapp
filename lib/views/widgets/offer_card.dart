// lib/views/widgets/offer_card.dart

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/offer.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;
  const OfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 180,
      child: Stack(
        children: [
          // الصورة مع الكاش والتحجيم
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: offer.imageUrl,
              width: 300,
              height: 180,
              fit: BoxFit.cover,
              placeholder: (context, url) => SizedBox(
                width: 300,
                height: 180,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => SizedBox(
                width: 300,
                height: 180,
                child: const Center(child: Icon(Icons.error_outline)),
              ),
            ),
          ),
          // تدرّج أسود في الأسفل لتحسين وضوح النص
          Container(
            width: 300,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // عنوان العرض
          Positioned(
            bottom: 16,
            left: 16,
            child: Text(
              offer.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

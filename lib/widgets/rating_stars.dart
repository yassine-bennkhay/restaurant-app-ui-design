import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int rating;
  const RatingStars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += "⭐";
    }
    return Text(
      stars,
      style: const TextStyle(fontSize: 18),
    );
  }
}

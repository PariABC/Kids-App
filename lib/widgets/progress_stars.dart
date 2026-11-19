import 'package:flutter/material.dart';

class ProgressStars extends StatelessWidget {
  final int stars; // 0 to 3
  final double size;

  const ProgressStars({
    super.key,
    required this.stars,
    this.size = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Icon(
          index < stars ? Icons.star_rounded : Icons.star_outline_rounded,
          color: index < stars ? Colors.amber : Colors.grey.shade400,
          size: size,
        );
      }),
    );
  }
}

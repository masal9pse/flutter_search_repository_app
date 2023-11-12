import 'package:flutter/material.dart';

class AngleCircleLargeImage extends StatelessWidget {
  const AngleCircleLargeImage({super.key, required this.image});
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 0.8,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: AspectRatio(
            aspectRatio: 3 / 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: image,
            ),
          ),
        ),
      ),
    );
  }
}

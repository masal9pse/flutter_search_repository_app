import 'package:flutter/material.dart';

class AngleCircleLargeImage extends StatelessWidget {
  const AngleCircleLargeImage({Key? key, required this.image})
      : super(key: key);
  final Image image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,      
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: image,
        ),
      ),
    );
  }
}

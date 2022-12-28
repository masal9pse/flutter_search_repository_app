import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/app_size_list.dart';

class AngleCircleLargeImage extends StatelessWidget {
  const AngleCircleLargeImage({Key? key, required this.image})
      : super(key: key);
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(AppSizeList.mediumSize),
      child: AspectRatio(
        aspectRatio: AppSizeList.largeImageAspect,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizeList.circleRadius),
          child: image,
        ),
      ),
    );
  }
}

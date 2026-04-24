import 'package:flutter/material.dart';
import '../utils/SizeConfig.dart';

class TriColorBackground extends StatelessWidget {
  const TriColorBackground({
    Key? key,
    required this.size,
    this.color,
    this.isLeft,
  }) : super(key: key);

  final Size size;
  final Color? color;
  final bool? isLeft;

  @override
  Widget build(BuildContext context) {
    return isLeft!
        ? Positioned(
            left: 0,
            width: size.width * 0.33,
            top: 0,
            height: size.height,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(SizeConfig.width(100)),
                bottomRight: Radius.circular(SizeConfig.width(100)),
              ),
              child: ColoredBox(color: color!),
            ),
          )
        : Positioned(
            right: 0,
            width: size.width * 0.33,
            top: 0,
            height: size.height,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(SizeConfig.width(100)),
                bottomLeft: Radius.circular(SizeConfig.width(100)),
              ),
              child: ColoredBox(color: color!),
            ),
          );
  }
}
import 'package:flutter/material.dart';
import '../utils/SizeConfig.dart';

class TopNBottomBackground extends StatelessWidget {
  const TopNBottomBackground({
    Key? key,
    required this.size,
    this.color,
    this.isTop,
  }) : super(key: key);

  final Size size;
  final Color? color;
  final bool? isTop;

  @override
  Widget build(BuildContext context) {
    return isTop!
        ? Positioned(
            top: 0,
            left: 0,
            width: size.width,
            height: size.height * 0.15,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(
                  SizeConfig.height(size.height / 2),
                ),
                bottomLeft: Radius.circular(
                  SizeConfig.height(size.height / 2),
                ),
              ),
              child: ColoredBox(color: color!),
            ),
          )
        : Positioned(
            left: 0,
            bottom: 0,
            width: size.width,
            height: size.height * 0.15,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                  SizeConfig.height(size.height / 2),
                ),
                topLeft: Radius.circular(
                  SizeConfig.height(size.height / 2),
                ),
              ),
              child: ColoredBox(color: color!),
            ),
          );
  }
}
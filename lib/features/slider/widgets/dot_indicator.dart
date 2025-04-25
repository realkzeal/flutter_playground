import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalDots;
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final double spacing;
  const DotIndicator({
    Key? key,
    required this.currentIndex,
    required this.totalDots,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.dotSize = 10.0, this.spacing = 8.0
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          totalDots,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: spacing/2),
                width: dotSize,
                height: dotSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentIndex == index ? activeColor : inactiveColor
                )
              )),
    );
  }
}

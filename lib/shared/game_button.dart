import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  const GameButton({
    super.key,
    this.child,
    required this.topColor,
    required this.bottomColor,
    this.borderRadius,
    this.elevation = 7,
    this.height,
    this.onTap,
    this.border,
    this.alignment,
    this.constraints,
    this.width,
  });

  final Widget? child;

  final Color topColor;

  final Color bottomColor;

  final BorderRadius? borderRadius;

  final double elevation;

  final double? height;

  final VoidCallback? onTap;

  final Border? border;

  final Alignment? alignment;

  final BoxConstraints? constraints;

  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        constraints: constraints,
        width: width,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: bottomColor,
                spreadRadius: 0.1,
                blurRadius: 0,
                offset: Offset(0, elevation),
              )
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: topColor,
              border: border,
              borderRadius: borderRadius,
            ),
            height: height,
            child: child,
          ),
        ),
      ),
    );
  }
}

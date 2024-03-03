import 'package:flutter/material.dart';

class WButton extends StatelessWidget {
  final double? width, height;
  final double? radius;
  final BoxShadow? shadow;
  final Widget? icon;
  final Widget? label;
  final Widget? child;
  final ButtonStyle? style;
  final Function() onPressed;

  const WButton({
    Key? key, // Thêm dòng này
    this.width,
    this.height,
    this.radius,
    this.shadow,
    this.icon,
    this.label,
    this.child,
    this.style,
    required this.onPressed, // Thay đổi dòng này
  }) : super(key: key); // Thêm dòng này
  // const WButton({super.key, this.width, this.height, this.radius, this.shadow, this.icon, this.label, this.child, this.style, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        boxShadow: [
          shadow ??
              const BoxShadow(
                color: Color.fromARGB(30, 0, 0, 0),
                blurRadius: 8.0,
                spreadRadius: 0,
                offset: Offset(0, 1),
              ),
        ],
      ),
      child: icon != null && label != null
          ? ElevatedButton.icon(
              onPressed: onPressed, // Thay đổi dòng này
              style: style,
              icon: icon!,
              label: label!,
            )
          : ElevatedButton(onPressed: onPressed, style: style, child: child),
    );
  }
}

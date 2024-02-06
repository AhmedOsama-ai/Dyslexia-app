import 'package:dyslexia/constants/colors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Widget icon;

  const MyButton({
    required this.text,
    required this.onPressed,
    icon,
    super.key,
  }) : icon = icon ?? const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: primaryColor,
      textColor: Colors.white,
      minWidth: 240,
      height: 44,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}

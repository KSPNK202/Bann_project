import 'package:flutter/material.dart';
import 'package:baan_app/user/theme/style.dart';

class ButtonContainerWidget extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final VoidCallback onTap;
  final bool hasIcon;
  final IconData icon;
  final TextStyle style;

  const ButtonContainerWidget({
    super.key,
    this.width = double.infinity,
    this.height = 40,
    required this.title,
    required this.onTap,
    this.hasIcon = false,
    this.icon = Icons.arrow_forward_ios,
    this.style = const TextStyle(color: whiteColor, fontSize: 16),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: primaryColorED6E1B,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: hasIcon
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: style,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      icon,
                      color: whiteColor,
                      size: 15,
                    ),
                  ],
                )
              : Text(
                  title,
                  style: style,
                ),
        ),
      ),
    );
  }
}
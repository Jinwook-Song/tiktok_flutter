import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class VideoButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? accentColor;
  const VideoButton({
    super.key,
    required this.icon,
    required this.text,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(
          icon,
          color: accentColor ?? Colors.white,
          size: Sizes.size36,
        ),
        Gaps.v5,
        Text(
          text,
          style: TextStyle(
              color: accentColor ?? Colors.white,
              fontSize: Sizes.size12,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

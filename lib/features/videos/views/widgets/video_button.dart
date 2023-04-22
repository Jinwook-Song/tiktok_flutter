import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class VideoButton extends StatelessWidget {
  final IconData icon;
  final String text;
  const VideoButton({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(
          icon,
          color: Colors.white,
          size: Sizes.size36,
        ),
        Gaps.v5,
        Text(
          text,
          style: const TextStyle(
              color: Colors.white,
              fontSize: Sizes.size12,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

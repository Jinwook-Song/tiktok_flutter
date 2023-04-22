import 'package:flutter/material.dart';

class VideoFlashButton extends StatelessWidget {
  final Color color;
  final void Function() onpressedFn;
  final IconData icon;

  const VideoFlashButton(
      {super.key,
      required this.color,
      required this.onpressedFn,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color,
      onPressed: onpressedFn,
      icon: Icon(icon),
    );
  }
}

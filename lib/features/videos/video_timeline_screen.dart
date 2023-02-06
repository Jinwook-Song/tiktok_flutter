import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;

  List<Color> colors = [
    Colors.amber,
    Colors.teal,
    Colors.purple,
    Colors.pink,
  ];

  void _onPageChanged(int page) {
    if (page == _itemCount - 1) {
      _itemCount += 4;
      colors = [...colors, ...colors];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged,
      itemCount: _itemCount,
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text(
            'Screen $index',
            style: const TextStyle(
              fontSize: Sizes.size60,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

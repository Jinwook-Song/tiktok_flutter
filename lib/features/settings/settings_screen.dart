import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
        ),
      ),
      body: ListWheelScrollView(
        diameterRatio: 1.5,
        offAxisFraction: -0.5,
        useMagnifier: true,
        magnification: 1.5,
        itemExtent: 200,
        children: [
          for (var _ in [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
            FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                color: Colors.cyan,
                alignment: Alignment.center,
                child: const Text(
                  'Options',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

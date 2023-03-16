import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
        ),
        children: [
          Gaps.v14,
          Text(
            'New',
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
          Gaps.v14,
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: Sizes.size52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border:
                    Border.all(color: Colors.grey.shade400, width: Sizes.size1),
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.bell,
                  size: Sizes.size20,
                  color: Colors.black,
                ),
              ),
            ),
            title: RichText(
              text: TextSpan(
                text: 'Account updates:',
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: Sizes.size16),
                children: [
                  const TextSpan(
                    text: ' Upload longer videos',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: ' 1h',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size16,
            ),
          )
        ],
      ),
    );
  }
}

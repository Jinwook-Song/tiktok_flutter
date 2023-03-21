import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class FollowState extends StatelessWidget {
  final String value, state;

  const FollowState({
    Key? key,
    required this.value,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w800,
          ),
        ),
        Gaps.v3,
        Text(
          state,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}

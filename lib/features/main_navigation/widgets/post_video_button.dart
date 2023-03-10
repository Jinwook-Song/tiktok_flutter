import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class PostVideoButton extends StatelessWidget {
  const PostVideoButton({
    Key? key,
    required this.isLight,
  }) : super(key: key);

  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: Sizes.size20,
          child: Container(
            width: 25,
            height: 30,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xff61D4F0),
              borderRadius: BorderRadius.circular(
                Sizes.size8,
              ),
            ),
          ),
        ),
        Positioned(
          left: Sizes.size20,
          child: Container(
            width: 25,
            height: 30,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(
                Sizes.size8,
              ),
            ),
          ),
        ),
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
          decoration: BoxDecoration(
            color: isLight ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(
              Sizes.size8,
            ),
          ),
          child: Center(
              child: FaIcon(
            FontAwesomeIcons.plus,
            color: isLight ? Colors.black : Colors.white,
            size: Sizes.size16 + Sizes.size2,
          )),
        )
      ],
    );
  }
}

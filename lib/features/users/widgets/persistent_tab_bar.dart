import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: Sizes.size1,
          ),
        ),
      ),
      child: const TabBar(
        labelPadding: EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size12),
            child: Icon(
              Icons.grid_4x4_outlined,
              color: Colors.black87,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size12),
            child: FaIcon(
              FontAwesomeIcons.heart,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

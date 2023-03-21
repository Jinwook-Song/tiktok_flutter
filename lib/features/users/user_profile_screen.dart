import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('JW'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.gear,
                size: Sizes.size20,
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const CircleAvatar(
                radius: Sizes.size52,
                foregroundColor: Colors.teal,
                foregroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/78011042?v=4',
                ),
                child: Text(
                  'JW',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Gaps.v20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "@JW",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gaps.h8,
                  FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    size: Sizes.size14,
                    color: Colors.cyan.withOpacity(0.6),
                  ),
                ],
              ),
              Gaps.v24,
              SizedBox(
                height: Sizes.size40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FollowState(
                      value: '37',
                      state: 'Following',
                    ),
                    VerticalDivider(
                      width: Sizes.size32,
                      thickness: Sizes.size1,
                      indent: Sizes.size12,
                      endIndent: Sizes.size12,
                      color: Colors.grey.shade200,
                    ),
                    const FollowState(
                      value: '10.5M',
                      state: 'Followers',
                    ),
                    VerticalDivider(
                      width: Sizes.size32,
                      thickness: Sizes.size1,
                      indent: Sizes.size12,
                      endIndent: Sizes.size12,
                      color: Colors.grey.shade200,
                    ),
                    const FollowState(
                      value: '149.3M',
                      state: 'Likes',
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

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

class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.pink,
      child: const FractionallySizedBox(
        heightFactor: 1,
        child: Center(
          child: Text(
            'subtitle',
            style: TextStyle(
              color: Colors.white,
              fontSize: Sizes.size16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 50;

  // maxExtent, minExtent 값을 변경하고 싶을 떄, true
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

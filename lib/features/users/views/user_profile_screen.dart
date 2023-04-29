import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:tiktok_flutter/features/settings/settings_screen.dart';
import 'package:tiktok_flutter/features/users/view_models/user_vm.dart';
import 'package:tiktok_flutter/features/users/views/widgets/avatar.dart';
import 'package:tiktok_flutter/features/users/views/widgets/follow_state.dart';
import 'package:tiktok_flutter/features/users/views/widgets/persistent_tab_bar.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  const UserProfileScreen({super.key, required this.username});

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(userProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              body: SafeArea(
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        title: Text(data.name),
                        actions: [
                          IconButton(
                            onPressed: _onGearPressed,
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
                            Gaps.v10,
                            Avatar(name: data.name),
                            Gaps.v20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "@${data.name}",
                                  style: const TextStyle(
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
                            Gaps.v14,
                            FractionallySizedBox(
                              widthFactor: 2 / 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Sizes.size48,
                                      vertical: Sizes.size12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(Sizes.size2),
                                      ),
                                    ),
                                    child: const Text(
                                      'Follow',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Gaps.h4,
                                  Container(
                                    padding: const EdgeInsets.all(Sizes.size10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: const Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.youtube,
                                        size: Sizes.size18,
                                      ),
                                    ),
                                  ),
                                  Gaps.h4,
                                  Container(
                                    padding: const EdgeInsets.all(Sizes.size10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: const Center(
                                      child: RotatedBox(
                                        quarterTurns: 45,
                                        child: Icon(
                                          Icons.play_arrow_sharp,
                                          size: Sizes.size18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gaps.v14,
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.size36),
                              child: Text(
                                'All highlights and where to watch live matches on FIFA+',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Gaps.v14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.link,
                                  size: Sizes.size16,
                                ),
                                Gaps.h10,
                                Text(
                                  'https://www.fifa.com/fifaplus/en/home',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            Gaps.v20,
                          ],
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: PersistentTabBar(),
                        pinned: true,
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: 20,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: Sizes.size2,
                          mainAxisSpacing: Sizes.size2,
                        ),
                        itemBuilder: (context, index) => Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 3 / 4,
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                placeholderFit: BoxFit.cover,
                                placeholder: 'assets/images/placeholder.jpeg',
                                image:
                                    'https://source.unsplash.com/random/200x${355 + index}',
                              ),
                            ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.play_arrow_outlined,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '4.1M',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const Center(
                        child: Text('tab 2'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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

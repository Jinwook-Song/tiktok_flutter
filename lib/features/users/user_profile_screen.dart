import 'package:flutter/material.dart';
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
          floating: true, // 스크롤을 올리면 최상단이 아니더라도 appbar가 나타남
          snap: true, // 스크롤을 올리면 expandedHeight 영역이까지 모두 나타남
          stretch: true, // 최상단에서 스크롤을 올리면 appbar를 늘릴 수 있음
          pinned: true, // 스크롤을 내리더라도 collapseHeight는 유지함
          backgroundColor: Colors.orange,
          collapsedHeight: 80,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
              StretchMode.zoomBackground,
            ],
            title: const Text(
              'Hello',
              style: TextStyle(
                color: Colors.yellow,
              ),
            ),
            background: Image.asset(
              'assets/images/placeholder.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              alignment: Alignment.center,
              color: Colors.amber[100 * (index % 9)],
              child: Text(
                'Item $index',
              ),
            ),
          ),
          itemExtent: 100,
        ),
        SliverPersistentHeader(
          delegate: CustomDelegate(),
          pinned: true,
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              alignment: Alignment.center,
              color: Colors.cyan[100 * (index % 9)],
              child: Text(
                'Item $index',
              ),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            mainAxisSpacing: Sizes.size20,
            crossAxisSpacing: Sizes.size20,
            childAspectRatio: 1,
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

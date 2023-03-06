import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Discover'),
            elevation: 1,
            bottom: TabBar(
              splashFactory: NoSplash.splashFactory,
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
              isScrollable: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade500,
              tabs: [
                for (var tab in tabs)
                  Tab(
                    child: Text(tab),
                  ),
              ],
            )),
        body: TabBarView(children: [
          GridView.builder(
            padding: const EdgeInsets.all(Sizes.size8),
            itemCount: 20,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 9 / 16,
              crossAxisSpacing: Sizes.size8,
              mainAxisSpacing: Sizes.size8,
            ),
            itemBuilder: (context, index) => AspectRatio(
              aspectRatio: 9 / 16,
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholderFit: BoxFit.cover,
                placeholder: 'assets/images/placeholder.jpeg',
                image: 'https://source.unsplash.com/random/200x${355 + index}',
              ),
            ),
          ),
          for (var tab in tabs.skip(1))
            Center(
              child: Text(
                tab,
                style: const TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            )
        ]),
      ),
    );
  }
}

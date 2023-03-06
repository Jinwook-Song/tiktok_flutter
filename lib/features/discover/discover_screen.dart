import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
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
              childAspectRatio: 9 / 20,
              crossAxisSpacing: Sizes.size8,
              mainAxisSpacing: Sizes.size8,
            ),
            itemBuilder: (context, index) => Column(
              children: [
                AspectRatio(
                  aspectRatio: 9 / 16,
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholderFit: BoxFit.cover,
                    placeholder: 'assets/images/placeholder.jpeg',
                    image:
                        'https://source.unsplash.com/random/200x${355 + index}',
                  ),
                ),
                Gaps.v10,
                const Text(
                  'Very long long caption for my image that i upload just now',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v4,
                DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: Sizes.size12,
                        backgroundImage: NetworkImage(
                          'https://avatars.githubusercontent.com/u/78011042?v=4',
                        ),
                      ),
                      Gaps.h4,
                      const Expanded(
                        child: Text(
                          'My avatar is going to be very long',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Gaps.h4,
                      FaIcon(
                        FontAwesomeIcons.heart,
                        size: Sizes.size16,
                        color: Colors.grey.shade600,
                      ),
                      Gaps.h2,
                      const Text(
                        '2.5M',
                      ),
                    ],
                  ),
                )
              ],
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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:tiktok_flutter/features/discover/discover_screen.dart';
import 'package:tiktok_flutter/features/inbox/inbox_screen.dart';
import 'package:tiktok_flutter/common/widget/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_flutter/common/widget/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_flutter/features/users/user_profile_screen.dart';
import 'package:tiktok_flutter/features/videos/views/video_timeline_screen.dart';
import 'package:tiktok_flutter/routes.dart';
import 'package:tiktok_flutter/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  final String tab;

  const MainNavigationScreen({super.key, required this.tab});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = ['home', 'discover', 'NONE', 'inbox', 'profile'];

  late int _selectedIndex = max(_tabs.indexOf(widget.tab), 0);

  void _check() {
    if (_selectedIndex != _tabs.indexOf(widget.tab)) {
      _selectedIndex = max(_tabs.indexOf(widget.tab), 0);
      setState(() {});
    }
  }

  void _onTap(int index) {
    context.goNamed(
      Routes.mainNavigationScreen['name']!,
      params: {
        'tab': _tabs[index],
      },
    );
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    context.pushNamed(Routes.videoRecordingScreen['name']!);
  }

  @override
  Widget build(BuildContext context) {
    _check();
    final isDark = isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(
              username: 'JW',
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: 'Home',
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTab: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: 'Discover',
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                onTab: () => _onTap(1),
                selectedIndex: _selectedIndex,
              ),
              Gaps.h24,
              GestureDetector(
                onTap: _onPostVideoButtonTap,
                child: PostVideoButton(
                  isLight: _selectedIndex == 0 || isDark,
                ),
              ),
              Gaps.h24,
              NavTab(
                text: 'Inbox',
                isSelected: _selectedIndex == 3,
                icon: (FontAwesomeIcons.message),
                selectedIcon: FontAwesomeIcons.solidMessage,
                onTab: () => _onTap(3),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: 'Profile',
                isSelected: _selectedIndex == 4,
                icon: (FontAwesomeIcons.user),
                selectedIcon: FontAwesomeIcons.solidUser,
                onTab: () => _onTap(4),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

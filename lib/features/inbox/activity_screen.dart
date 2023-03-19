import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _notifications = List.generate(20, (index) => '${index}h');

  final List<Map<String, dynamic>> _activityTabs = [
    {
      "title": "All activity",
      "icon": FontAwesomeIcons.solidMessage,
    },
    {
      "title": "Likes",
      "icon": FontAwesomeIcons.solidHeart,
    },
    {
      "title": "Comments",
      "icon": FontAwesomeIcons.solidComments,
    },
    {
      "title": "Mentions",
      "icon": FontAwesomeIcons.at,
    },
    {
      "title": "Followers",
      "icon": FontAwesomeIcons.solidUser,
    },
    {
      "title": "From TikTok",
      "icon": FontAwesomeIcons.tiktok,
    }
  ];

  bool _showBarrier = false;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 200,
    ),
  );

  late final Animation<double> _arrowAnimation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_animationController);

  late final Animation<Offset> _pannelAnimation = Tween(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(_animationController);

  late final Animation<Color?> _colorAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black26,
  ).animate(_animationController);

  void _onDismissed(String notification) {
    _notifications.remove(notification);
    setState(() {});
  }

  void _toggleAnimations() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward(); // modal barrier가 바로 나타나도록
    }
    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _toggleAnimations,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('All activity'),
              Gaps.h2,
              RotationTransition(
                turns: _arrowAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
            ),
            children: [
              Gaps.v14,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size16,
                ),
                child: Text(
                  'New',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Gaps.v14,
              for (var notification in _notifications)
                Dismissible(
                  key: Key(notification),
                  onDismissed: (direction) => _onDismissed(notification),
                  background: Container(
                    padding: const EdgeInsets.only(
                      left: Sizes.size16,
                    ),
                    alignment: Alignment.centerLeft,
                    color: Colors.green,
                    child: const FaIcon(
                      FontAwesomeIcons.checkDouble,
                      color: Colors.white,
                      size: Sizes.size32,
                    ),
                  ),
                  secondaryBackground: Container(
                    padding: const EdgeInsets.only(
                      right: Sizes.size16,
                    ),
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const FaIcon(
                      FontAwesomeIcons.trashCan,
                      color: Colors.white,
                      size: Sizes.size32,
                    ),
                  ),
                  child: ListTile(
                    minVerticalPadding: Sizes.size16,
                    leading: Container(
                      width: Sizes.size52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: Sizes.size1,
                        ),
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
                            text: ' $notification',
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
                  ),
                )
            ],
          ),
          if (_showBarrier)
            AnimatedModalBarrier(
              color: _colorAnimation,
              dismissible: true,
              onDismiss: _toggleAnimations,
            ),
          SlideTransition(
            position: _pannelAnimation,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.size5),
                  bottomRight: Radius.circular(Sizes.size5),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var activityTab in _activityTabs)
                    ListTile(
                      title: Row(
                        children: [
                          FaIcon(
                            activityTab['icon'],
                            color: Colors.black,
                            size: Sizes.size16,
                          ),
                          Gaps.h16,
                          Text(
                            activityTab['title'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

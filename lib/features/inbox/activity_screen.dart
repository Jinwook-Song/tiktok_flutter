import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final List<String> _notifications = List.generate(
    20,
    (index) => '${index}h',
  );

  void _onDismissed(String notification) {
    _notifications.remove(notification);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
      ),
      body: ListView(
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
    );
  }
}

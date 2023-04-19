import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/common/widget/video_configuration/video_config.dart';
import 'package:tiktok_flutter/utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotificationsChanged(bool? value) {
    if (value == null) return;
    setState(() {
      _notifications = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
        ),
      ),
      body: ListView(
        children: [
          ValueListenableBuilder(
            valueListenable: videoConfig,
            builder: (context, value, child) => SwitchListTile.adaptive(
              value: videoConfig.value,
              onChanged: (value) => videoConfig.value = !videoConfig.value,
              title: const Text('Videos wil be muted by default'),
            ),
          ),
          SwitchListTile.adaptive(
            value: _notifications,
            onChanged: _onNotificationsChanged,
            title: const Text('Enable notifications'),
          ),
          CheckboxListTile(
            value: _notifications,
            onChanged: _onNotificationsChanged,
            activeColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
            checkColor: Theme.of(context).primaryColor,
            title: const Text('Marketing emails'),
            subtitle: const Text("We won't spam you."),
          ),
          ListTile(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1970),
                lastDate: DateTime(2030),
              );
              if (kDebugMode) {
                print(date);
              }

              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (kDebugMode) {
                print(time);
              }
              final booking = await showDateRangePicker(
                context: context,
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                      appBarTheme: AppBarTheme(
                          foregroundColor: isDark ? Colors.black : Colors.white,
                          backgroundColor:
                              isDark ? Colors.white : Colors.black),
                    ),
                    child: child!,
                  );
                },
                firstDate: DateTime(1970),
                lastDate: DateTime(2030),
              );
              if (kDebugMode) {
                print(booking);
              }
            },
            title: const Text('What is your birthday?'),
          ),
          ListTile(
            onTap: () => showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text(
                  'Are you sure to logout?',
                ),
                content: const Text('This action cannot be undone'),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'No',
                    ),
                  ),
                  CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(),
                    isDestructiveAction: true,
                    child: const Text(
                      'Yes',
                    ),
                  ),
                ],
              ),
            ),
            title: const Text(
              'Log out(iOS)',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          ListTile(
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text(
                  'Are you sure to logout?',
                ),
                content: const Text('This action cannot be undone'),
                actions: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const FaIcon(FontAwesomeIcons.xmark),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Yes',
                    ),
                  ),
                ],
              ),
            ),
            title: const Text(
              'Log out(Android)',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          ListTile(
            onTap: () => showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                title: const Text(
                  'Are you sure to logout?',
                ),
                actions: [
                  CupertinoActionSheetAction(
                    isDefaultAction: true,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'No',
                    ),
                  ),
                  CupertinoActionSheetAction(
                    isDestructiveAction: true,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Yes',
                    ),
                  ),
                ],
              ),
            ),
            title: const Text(
              'Log out(iOS / Bottom)',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          const AboutListTile()
        ],
      ),
    );
  }
}

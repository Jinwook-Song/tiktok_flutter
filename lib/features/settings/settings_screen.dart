import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_flutter/common/widget/theme_configuration/theme_config.dart';
import 'package:tiktok_flutter/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_flutter/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_flutter/utils.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            valueListenable: useDarkThemeConfig,
            builder: (context, value, child) => SwitchListTile.adaptive(
              value: useDarkThemeConfig.value,
              onChanged: (value) =>
                  useDarkThemeConfig.value = !useDarkThemeConfig.value,
              title: const Text('Use dark mode'),
            ),
          ),
          SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).muted,
            onChanged: (value) => {
              ref.read(playbackConfigProvider.notifier).setMuted(value),
            },
            title: const Text('Auto mute'),
          ),
          SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).autoPlay,
            onChanged: (value) => {
              ref.read(playbackConfigProvider.notifier).setAutoPlay(value),
            },
            title: const Text('Auto play'),
          ),
          CheckboxListTile(
            value: false,
            onChanged: (value) {},
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
                    onPressed: () {
                      ref.read(authenticationRepository).signOut();
                      context.go('/');
                    },
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

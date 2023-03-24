import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
        ),
      ),
      body: ListView(
        children: [
          CheckboxListTile(
            value: _notifications,
            onChanged: _onNotificationsChanged,
            activeColor: Colors.black,
            title: const Text('Enable notifications'),
          ),
          ListTile(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1970),
                lastDate: DateTime(2030),
              );
              print(date);

              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              print(time);
              final booking = await showDateRangePicker(
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                      appBarTheme: const AppBarTheme(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black),
                    ),
                    child: child!,
                  );
                },
                context: context,
                firstDate: DateTime(1970),
                lastDate: DateTime(2030),
              );
              print(booking);
            },
            title: const Text('What is your birthday?'),
          ),
          const AboutListTile()
        ],
      ),
    );
  }
}

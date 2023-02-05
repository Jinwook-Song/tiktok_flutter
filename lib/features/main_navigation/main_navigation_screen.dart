import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens = [
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Search'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[_selectedIndex],
        bottomNavigationBar: NavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onTap,
            destinations: const [
              NavigationDestination(
                  icon: FaIcon(
                    FontAwesomeIcons.house,
                    color: Colors.white,
                  ),
                  selectedIcon: FaIcon(
                    FontAwesomeIcons.house,
                    color: Colors.black,
                  ),
                  label: 'Home'),
              NavigationDestination(
                  icon: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Colors.white,
                  ),
                  selectedIcon: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Colors.black,
                  ),
                  label: 'Search'),
            ]));
  }
}

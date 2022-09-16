import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/restaurant_favorite_page.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [
    const RestaurantListPage(),
    const RestaurantFavoritePage(),
    const SettingsPage(),
  ];

  int _buttomNavIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _buttomNavIndex = index;
    });
  }

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.restaurant_menu_rounded),
      label: 'Restoran',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite_rounded),
      label: 'Favorit',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings_rounded),
      label: 'Pengaturan',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_buttomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.onBackground,
        unselectedItemColor: Colors.white38,
        currentIndex: _buttomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onItemTapped,
      ),
    );
  }
}

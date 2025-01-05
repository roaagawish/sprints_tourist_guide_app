import 'package:flutter/material.dart';
import '../../models/bottom_nav_bar_entity.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/styles_manager.dart';
import 'taps/favorites_tab.dart';
import 'taps/governments_tab.dart';
import 'taps/home_tab.dart';
import 'taps/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;

  List<BottomNavIconEntity> get _navigationItems => [
        BottomNavIconEntity(icon: Icons.home, label: 'Home'),
        BottomNavIconEntity(icon: Icons.public, label: 'Governments'),
        BottomNavIconEntity(icon: Icons.favorite, label: 'Favorites'),
        BottomNavIconEntity(icon: Icons.account_circle, label: 'Profile'),
      ];

  void onTabTapped(int index) {
    if (_currentPage != index) {
      setState(() {
        _currentPage = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tourist Guide'),
      ),
      body: IndexedStack(
        index: _currentPage,
        children: const [
          HomeTab(),
          GovernmentsTab(),
          FavoritesTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: onTabTapped,
        selectedItemColor: ColorsManager.white,
        unselectedItemColor: ColorsManager.black,
        items: _navigationItems.map((e) {
          return BottomNavigationBarItem(
              icon: Icon(e.icon),
              label: e.label,
              backgroundColor: ColorsManager.darkGreen);
        }).toList(),
        selectedLabelStyle: Styles.style14Medium(),
        unselectedLabelStyle: Styles.style12Medium(),
      ),
    );
  }
}

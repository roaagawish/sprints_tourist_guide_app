import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/bottom_nav_bar_entity.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/styles_manager.dart';
import 'blocs/favorite_places/favorite_places_bloc.dart';
import 'blocs/popular_places/popular_places_bloc.dart';
import 'blocs/suggested_places/suggested_places_bloc.dart';
import 'taps/favorites_tab.dart';
import 'taps/governments_tab.dart';
import 'taps/home_tab.dart';
import 'taps/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<BottomNavIconEntity> get _navigationItems => [
        BottomNavIconEntity(icon: Icons.home, label: "taps.homeLabel"),
        BottomNavIconEntity(icon: Icons.public, label: "taps.governmentsLabel"),
        BottomNavIconEntity(icon: Icons.favorite, label: "taps.favLabel"),
        BottomNavIconEntity(
            icon: Icons.account_circle, label: "taps.profileLabel"),
      ];

  void onTabTapped(int index) {
    if (_currentPage != index) {
      //if the user is on the first page and clicks on the last page, jump to the last page
      //also just jump for going from the last page to the first page.
      if ((_currentPage == 0 && index == _navigationItems.length - 1) ||
          (_currentPage == _navigationItems.length - 1 && index == 0)) {
        _pageController.jumpToPage(
          index,
        );
      } else {
        //otherwise animate to the page
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInQuad,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PopularPlacesBloc()..add(LoadPopularPlaces()),
        ),
        BlocProvider(
          create: (_) => SuggestedPlacesBloc()..add(LoadSuggestedPlaces()),
        ),
        BlocProvider(
          create: (_) => FavoritePlacesBloc()..add(LoadFavoritePlaces()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(tr("appBarTitle")),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          children: const [
            HomeTab(),
            GovernrateTab(),
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
                label: context.tr(e.label),
                backgroundColor: ColorsManager.darkGreen);
          }).toList(),
          selectedLabelStyle: Styles.style14Medium(),
          unselectedLabelStyle: Styles.style12Medium(),
        ),
      ),
    );
  }
}

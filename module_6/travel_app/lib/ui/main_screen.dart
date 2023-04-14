import 'package:flutter/material.dart';
import 'package:travel_app/ui/booking/booking_screen.dart';
import 'package:travel_app/ui/favourite/favourite_screen.dart';
import 'package:travel_app/ui/profile/profile_screen.dart';

import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {
  final int? initialPageIndex;

  const MainScreen({Key? key, this.initialPageIndex}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    /// if [initialPageIndex] is specified, show that page instead.
    /// if not, show the first page
    _pageController = PageController(initialPage: widget.initialPageIndex ?? 0);
    _currentPage = widget.initialPageIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          ///Todo: Implement UI layout for each screen in assigned folder.
          ///For starter just try to complete the design by using helper widgets in build methods (_buildMainSection()).
          ///Later you can refactor to individual widgets in separate files. Whatever makes it easy for you.
          HomeScreen(),
          FavouriteScreen(),
          BookingScreen(),
          ProfileScreen()
        ],
      ),

      ///Todo: Fix the bottom navigation bar item with correct icons + styling
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPage,
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          selectedLabelStyle: const TextStyle(color: Colors.orange),
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,

          ///Todo: Currently use setState to transition between pageviews. But later migrate to Bloc to make state mgmt uniform accross app.
          onTap: (navItem) {
            setState(() {
              _currentPage = navItem;
              _pageController.jumpToPage(
                navItem,
              );
            });
          },
          items: _navItems),
    );
  }

  //Helper widgets
  final List<BottomNavigationBarItem> _navItems = [
    const BottomNavigationBarItem(
      label: "Travel",
      icon: Icon(
        Icons.airplanemode_active,
        color: Colors.grey,
      ),
      activeIcon: Icon(
        Icons.airplanemode_active,
        color: Colors.orange,
      ),
    ),
    const BottomNavigationBarItem(
      label: "Saved",
      icon: Icon(
        Icons.favorite,
        color: Colors.grey,
      ),
      activeIcon: Icon(
        Icons.favorite,
        color: Colors.orange,
      ),
    ),
    const BottomNavigationBarItem(
      label: "Booking",
      icon: Icon(
        Icons.book_online,
        color: Colors.grey,
      ),
      activeIcon: Icon(
        Icons.book_online,
        color: Colors.orange,
      ),
    ),
    const BottomNavigationBarItem(
      label: "Profile",
      icon: Icon(
        Icons.person,
        color: Colors.grey,
      ),
      activeIcon: Icon(
        Icons.person,
        color: Colors.orange,
      ),
    ),
    // BottomNavigationBarItem(
    //   label: "Buy Cars",
    //   icon: SvgPicture.asset(
    //     'assets/common/icon_buy_cars.svg',
    //     color: kGrayColor500,
    //   ),
    //   activeIcon: SvgPicture.asset(
    //     'assets/common/icon_buy_cars.svg',
    //     color: kPrimaryColor700,
    //   ),
    // ),
    // BottomNavigationBarItem(
    //   label: "Sell Cars",
    //   icon: SvgPicture.asset(
    //     'assets/common/icon_sell_cars.svg',
    //     color: kGrayColor500,
    //   ),
    //   activeIcon: SvgPicture.asset(
    //     'assets/common/icon_sell_cars.svg',
    //     color: kPrimaryColor700,
    //   ),
    // ),
    // BottomNavigationBarItem(
    //   label: "More",
    //   icon: SvgPicture.asset(
    //     'assets/common/icon_more.svg',
    //     color: kGrayColor500,
    //   ),
    //   activeIcon: SvgPicture.asset(
    //     'assets/common/icon_more.svg',
    //     color: kPrimaryColor700,
    //   ),
    // ),
  ];
}

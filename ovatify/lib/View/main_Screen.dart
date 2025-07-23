import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/appColor.dart';
import 'RightsManagement_Screen.dart';
import 'home_Screen.dart';
import 'investment_Screen.dart';
import 'marketing_Screen.dart';
import 'me_Screen.dart';
import 'mytracks_Screen.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    MytracksScreen(),
    InvestmentScreen(),
    RightsmanagementScreen(),
    MarketingScreen(),
    MeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: AppColors.black,
        selectedItemColor: AppColors.magenta,
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,


        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: 'Home'),
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: 'My Tracks'),
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: 'Investments'),
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: 'Rights'),
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: 'Marketplace'),
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: 'Me'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:green_oil_seekers/home_screen/home_screen.dart';
import 'package:green_oil_seekers/profile_screen/profile_screen.dart';
import 'package:green_oil_seekers/schedule_screen/schedule_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});
  @override
  State<NavBar> createState() {
    return _NavBar();
  }
}

class _NavBar extends State<NavBar> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomeScreen();

    if (_selectedPageIndex == 1) {
      activePage = const ScheduleScreen();
    } else if (_selectedPageIndex == 2) {
      activePage = const ProfileScreen();
    }

    return Scaffold(
      body: activePage,
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 0,
              blurRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            onTap: _selectPage,
            currentIndex: _selectedPageIndex,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            iconSize: 30,
            selectedFontSize: 16,
            unselectedFontSize: 14,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.schedule,
                ),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

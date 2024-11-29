import 'package:flutter/material.dart';
import 'package:green_oil_seekers/home_screen/home_screen.dart';
import 'package:green_oil_seekers/profile_screen/profile_screen.dart';
import 'package:green_oil_seekers/schedule_screen/schedule_screen.dart';

// Stateful widget for implementing a navigation bar that switches between different main screens of the app.
class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    required this.wantedPage, // Initial page index to be displayed.
  });

  final int wantedPage;

  @override
  State<NavBar> createState() {
    return _NavBar();
  }
}

class _NavBar extends State<NavBar> {
  late int _selectedPageIndex; // Index of the currently selected page.

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = widget
        .wantedPage; // Initialize the selected page index from the widget's wantedPage.
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex =
          index; // Update the index when a new navigation item is selected.
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomeScreen(); // Default to HomeScreen.

    if (_selectedPageIndex == 1) {
      activePage =
          const ScheduleScreen(); // Display the ScheduleScreen if the selected index is 1.
    } else if (_selectedPageIndex == 2) {
      activePage =
          const ProfileScreen(); // Display the ProfileScreen if the selected index is 2.
    }

    return Scaffold(
      body: activePage, // Show the active page based on the selected index.
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
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
            onTap: _selectPage, // Function to handle page selection.
            currentIndex:
                _selectedPageIndex, // Index of the currently selected page.
            selectedItemColor: Theme.of(context)
                .colorScheme
                .primary, // Color for the selected item.
            unselectedItemColor: Theme.of(context)
                .disabledColor, // Color for the unselected items.
            iconSize: 30,
            selectedFontSize: 16,
            unselectedFontSize: 14,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context)
                .colorScheme
                .onPrimary, // Background color of the navigation bar.
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.schedule),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

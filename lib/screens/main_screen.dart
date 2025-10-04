import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'reports_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ReportsScreen(), // Placeholder screen
    ProfileScreen(), // Placeholder screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Handle new transaction/entry
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.bar_chart, 'Reports', 1),
            const SizedBox(width: 40), // The space for the FAB
            _buildNavItem(Icons.inventory_2, 'Stock', 2),
            _buildNavItem(Icons.person, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    // A simple hack to make the placeholder items work with our 3 screens
    final effectiveIndex = index > 1 ? (index - 1) : index;

    return IconButton(
      icon: Icon(
        icon,
        color: _selectedIndex == effectiveIndex
            ? Theme.of(context).primaryColor
            : Colors.grey,
      ),
      onPressed: () => _onItemTapped(effectiveIndex),
      tooltip: label,
    );
  }
}

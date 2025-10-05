// lib/screens/main_screen.dart

import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'reports_list_screen.dart';
import 'stock_dashboard_screen.dart';
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
    ReportsListScreen(),
    StockDashboardScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // --- MOBILE LAYOUT (< 700 pixels wide) ---
        if (constraints.maxWidth < 700) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Company'),
              actions: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: const Text('Create Invoice'),
                ),
              ],
            ),
            drawer: const Drawer(),
            body: _widgetOptions.elementAt(_selectedIndex),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.add, color: Colors.white),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 8.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildMobileNavItem(icon: Icons.home, index: 0),
                  _buildMobileNavItem(icon: Icons.bar_chart, index: 1),
                  const SizedBox(width: 48), // Space for FAB
                  _buildMobileNavItem(icon: Icons.inventory_2, index: 2),
                  _buildMobileNavItem(icon: Icons.person, index: 3),
                ],
              ),
            ),
          );
        } 
        // --- DESKTOP/TABLET LAYOUT (>= 700 pixels wide) ---
        else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Company'),
              actions: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: const Text('Create Invoice'),
                ),
              ],
            ),
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onItemTapped,
                  labelType: NavigationRailLabelType.all,
                  leading: FloatingActionButton(
                    elevation: 0,
                    onPressed: () {
                      // Add new transaction
                    },
                    child: const Icon(Icons.add),
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.bar_chart_outlined),
                      selectedIcon: Icon(Icons.bar_chart),
                      label: Text('Reports'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.inventory_2_outlined),
                      selectedIcon: Icon(Icons.inventory_2),
                      label: Text('Stock'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildMobileNavItem({required IconData icon, required int index}) {
    return IconButton(
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Theme.of(context).primaryColor : Colors.grey,
      ),
      onPressed: () => _onItemTapped(index),
    );
  }
}
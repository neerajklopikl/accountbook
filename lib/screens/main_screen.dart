// lib/screens/main_screen.dart

import 'package:accountbook/screens/add_txn_bottom_sheet.dart';
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

  void _showAddTxnBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      builder: (context) => const AddTxnBottomSheet(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('My Company'),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/createInvoice');
            },
            icon: const Icon(Icons.add_circle_outline),
            label: const Text('Create'),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // --- MOBILE LAYOUT (< 700 pixels wide) ---
        if (constraints.maxWidth < 700) {
          return Scaffold(
            appBar: _buildAppBar(context), 
            drawer: const Drawer(), 
            body: _widgetOptions.elementAt(_selectedIndex),
            floatingActionButton: FloatingActionButton(
              onPressed: _showAddTxnBottomSheet,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.add, color: Colors.white),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 8.0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1.0))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildMobileNavItem(icon: Icons.home, label: 'Home', index: 0),
                    _buildMobileNavItem(icon: Icons.bar_chart, label: 'Reports', index: 1),
                    const SizedBox(width: 48), // Space for FAB
                    _buildMobileNavItem(icon: Icons.inventory_2, label: 'Stock', index: 2),
                    _buildMobileNavItem(icon: Icons.person, label: 'Profile', index: 3),
                  ],
                ),
              ),
            ),
          );
        } 
        // --- DESKTOP/TABLET LAYOUT (>= 700 pixels wide) ---
        else {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onItemTapped,
                  labelType: NavigationRailLabelType.all,
                  backgroundColor: Colors.white,
                  indicatorColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  leading: Column(
                    children: [
                      const SizedBox(height: 20),
                      FloatingActionButton.extended(
                        elevation: 1,
                        onPressed: _showAddTxnBottomSheet,
                        icon: const Icon(Icons.add),
                        label: const Text('New'),
                      ),
                      const SizedBox(height: 40),
                    ],
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
                  child: Scaffold(
                    appBar: _buildAppBar(context),
                    body: _widgetOptions.elementAt(_selectedIndex),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // FIX: Reduced vertical padding and spacing to prevent overflow on mobile.
  Widget _buildMobileNavItem({required IconData icon, required String label, required int index}) {
    final bool isSelected = _selectedIndex == index;
    final color = isSelected ? Theme.of(context).primaryColor : Colors.grey.shade600;

    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0), // Reduced from 8.0
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 2), // Reduced from 4
              Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}
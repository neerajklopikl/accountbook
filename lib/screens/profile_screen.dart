import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using a Scaffold to provide the basic app structure
    return Scaffold(
      // Using a custom background color to match the modern theme
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // The AppBar at the top of the screen
      appBar: AppBar(
        title: const Text('My Profile'),
        // Setting the background color of the AppBar to match the app's primary color
        backgroundColor: Theme.of(context).primaryColor,
        // Making the AppBar text white for better contrast
        foregroundColor: Colors.white,
        // Removing the shadow for a flatter look
        elevation: 0,
      ),
      // The body of the screen, wrapped in a SingleChildScrollView to prevent overflow on smaller devices
      // while designing it to fit on a typical screen.
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section with user's avatar and name
            _buildProfileHeader(context),
            const SizedBox(height: 20),
            // Menu items for profile management
            _buildProfileMenu(context),
            const SizedBox(height: 30),
            // Logout button at the bottom of the screen
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  // Widget for the profile header section
  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      // Styling the header with a gradient that matches the app's theme
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: const Column(
        children: [
          // User's avatar
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 12),
          // User's name
          Text(
            'John Doe',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          // User's email
          Text(
            'john.doe@example.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  // Widget for the list of profile menu options
  Widget _buildProfileMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            // Each menu item is a ListTile for consistent styling
            _buildMenuOption(
              icon: Icons.edit,
              title: 'Edit Profile',
              onTap: () {
                // TODO: Navigate to Edit Profile screen
              },
            ),
            const Divider(height: 0),
            _buildMenuOption(
              icon: Icons.lock,
              title: 'Change Password',
              onTap: () {
                // TODO: Show Change Password dialog or screen
              },
            ),
            const Divider(height: 0),
            _buildMenuOption(
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () {
                // TODO: Navigate to Notification Settings screen
              },
            ),
            const Divider(height: 0),
            _buildMenuOption(
              icon: Icons.language,
              title: 'Language',
              onTap: () {
                // TODO: Show Language selection dialog
              },
            ),
             const Divider(height: 0),
            _buildMenuOption(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {
                // TODO: Navigate to Help screen
              },
            ),
          ],
        ),
      ),
    );
  }

  // Reusable widget for a single menu option
  Widget _buildMenuOption(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  // Widget for the logout button
  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          // TODO: Implement logout functionality
        },
        icon: const Icon(Icons.logout, color: Colors.white),
        label: const Text('Logout', style: TextStyle(color: Colors.white, fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}


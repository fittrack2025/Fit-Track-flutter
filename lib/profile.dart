import 'package:flutter/material.dart';
import 'reminder.dart'; // Import the ReminderPage here

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Profile Picture
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  AssetImage('assets/blum.png'), // Add your profile image
            ),
            const SizedBox(height: 10),
            // User Name
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            // Records Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _recordCard('1200', 'Total Calories'),
                _recordCard('150', 'Duration (min)'),
              ],
            ),
            const SizedBox(height: 20),
            // Settings Section
            _sectionHeader('Settings'),
            _settingsSection(context), // Pass context here
            const SizedBox(height: 20),
            // My Workouts Section

            const SizedBox(height: 20),
            // Awards Section
            _sectionHeader('Awards'),
            _awardsSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper to create record cards
  Widget _recordCard(String value, String label) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  // Section Header
  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // Settings Section
  Widget _settingsSection(BuildContext context) {
    // Accept context here
    return Column(
      children: [
        _settingsItem(context, Icons.account_circle, 'Edit Profile'),
        _settingsItem(
            context, Icons.watch, 'Set reminder'), // Pass context here
        _settingsItem(context, Icons.notifications, 'Notifications'),
        _settingsItem(context, Icons.logout, 'Log Out'),
      ],
    );
  }

  Widget _settingsItem(BuildContext context, IconData icon, String title) {
    // Accept context here
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Navigate to the reminder setting page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReminderSettingPage()),
        );
      },
    );
  }

  // Awards Section
  Widget _awardsSection() {
    return Column(
      children: [
        _awardTile('3 Days With Us', Icons.emoji_events),
        _awardTile('10 Days With Us', Icons.emoji_events),
        _awardTile('30 Days With Us', Icons.star),
      ],
    );
  }

  Widget _awardTile(String title, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.amber, size: 40),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class ReminderSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Reminder'),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}

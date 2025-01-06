import 'package:flutter/material.dart';
import 'package:trial/complaints.dart';
import 'package:trial/feedback.dart';
import 'package:trial/login.dart';
import 'package:trial/services/getProfile.dart';
import 'edit_profile.dart';
import 'reminder.dart'; 

Future<Map<String, dynamic>>? userProfile;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    userProfile = getUserProfile(); // Fetch user profile data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: userProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('Failed to load profile data'),
            );
          }

          final data = snapshot.data!;
          final userName = data['name'] ?? 'Unknown';
          final profileImage = data['profileImage'] ??
              'https://www.bing.com/th?id=OIP.CNIPJOPWQ1tiTLX1WxEx3QHaH_&w=150&h=162&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2'; // Placeholder if no image
          final totalCalories = (data['calorie'] != null)
              ? double.parse(data['calorie'].toString()).toStringAsFixed(2)
              : '0.00';
          final id = data["id"];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(profileImage),
                ),
                const SizedBox(height: 10),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _recordCard( 'Maintanance Calorie',totalCalories,),
                    // _recordCard(duration, 'Duration (min)'),
                  ],
                ),
                const SizedBox(height: 20),
                _sectionHeader('Settings'),
                _settingsSection(context, data),
                const SizedBox(height: 20),
                // _sectionHeader('Awards'),
                // _awardsSection(),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _recordCard(String value, String label) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(width: 15),
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

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

  Widget _settingsSection(BuildContext context, Map<String, dynamic> data) {
    final name = data['name'] ?? '';
    final email = data['email'] ?? '';
    final gender = data['gender'] ?? '';
    final id = data["id"];

    return Column(
      children: [
        _settingsItem(
          context,
          Icons.account_circle,
          'Edit Profile',
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfilePage(
                name: name,
                email: email,
                gender: gender,
                id: id.toString(),
              ),
            ),
          ),
        ),
        _settingsItem(
          context,
          Icons.watch,
          'Set Reminder',
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlarmSettingScreen(),
            ),
          ),
        ),
        _settingsItem(context, Icons.upload, 'Feedback', () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FeedbackPage(
                  userId: id.toString(),
                ),
              ));
        }),
        _settingsItem(context, Icons.upload, 'Complaints', () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ComplaintPage(
                  userId: id.toString(),
                ),
              ));
        }),
        _settingsItem(context, Icons.logout, 'Log Out', () {
          _showLogoutConfirmationDialog(context);
        }),
      ],
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Logout"),
          content: Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Handle logout logic here
                // For example, navigate to the login screen or clear user data
                Navigator.of(context).pop(); // Close the dialog
                _logout(); // Call the logout function
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    // Implement your logout logic here
    // For example, navigate to the login screen
    print("User logged out");
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Loginpage(),
        ));
  }
}

Widget _settingsItem(
    BuildContext context, IconData icon, String title, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon, color: Colors.blueAccent),
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: onTap,
  );
}

// Widget _awardsSection() {
//   return Column(
//     children: [
//       _awardTile('3 Days With Us', Icons.emoji_events),
//       _awardTile('10 Days With Us', Icons.emoji_events),
//       _awardTile('30 Days With Us', Icons.star),
//     ],
//   );
// }

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

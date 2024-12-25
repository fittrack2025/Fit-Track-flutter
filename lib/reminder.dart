import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
import 'profile.dart';  // Import ProfilePage

class ReminderApp extends StatelessWidget {
  const ReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ReminderPage(),
      routes: {
        '/reminder': (context) => const ReminderPage(),
      },
    );
  }
}

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    tz.initializeTimeZones(); // Initialize timezones
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _notificationsPlugin.initialize(initializationSettings);
  }

  void _scheduleNotification(
      String title, String description, DateTime dateTime) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'reminder_channel',
      'Reminders',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    final tz.TZDateTime tzDateTime = tz.TZDateTime.from(dateTime, tz.local);

    await _notificationsPlugin.zonedSchedule(
      0,
      title,
      description,
      tzDateTime,
      platformDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void _pickDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _createReminder() {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    _scheduleNotification(
      _titleController.text,
      _descriptionController.text,
      _selectedDateTime!,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Reminder Set Successfully!")),
    );

    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedDateTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Reminder'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to ProfilePage when back arrow is pressed
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Reminder Title"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: "Reminder Description"),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDateTime == null
                      ? "No Date Selected"
                      : DateFormat("yyyy-MM-dd HH:mm").format(_selectedDateTime!),
                  style: const TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: _pickDateTime,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                  child: const Text("Pick Date & Time"),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _createReminder,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Set Reminder"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const ReminderApp());
}

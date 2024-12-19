import 'package:flutter/material.dart';

class WorkoutDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final List<Map<String, String>> setsAndReps;
  final String image;
  final Function(bool) onCompletionUpdate; // Add this callback

  WorkoutDetailPage({
    required this.title,
    required this.description,
    required this.setsAndReps,
    required this.image,
    required this.onCompletionUpdate, // Pass the callback here
  });

  @override
  Widget build(BuildContext context) {
    bool isCompleted = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Image.asset(image),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(description),
          ),
          Column(
            children: setsAndReps.map((set) {
              return ListTile(
                title: Text("${set['set']} - ${set['reps']} reps"),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                isCompleted = !isCompleted;
                onCompletionUpdate(isCompleted); // Call the callback to update completion status
                Navigator.pop(context);
              },
              child: Text(isCompleted ? 'Mark as Incomplete' : 'Mark as Completed'),
            ),
          ),
        ],
      ),
    );
  }
}

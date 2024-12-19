import 'package:flutter/material.dart';
import 'workdetails.dart'; // Import the WorkoutDetailPage

class WorkoutListPage extends StatefulWidget {
  @override
  _WorkoutListPageState createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  // Track the completion of workouts for each day and workout
  Map<String, bool> workoutCompletion = {};

  // Generate 12 days starting from today (including 18, 19, etc.)
  final DateTime currentDate = DateTime.now();
  final List<Map<String, dynamic>> dayWorkouts = [
    {
      'date': DateTime.now(),
      'categoryImage': 'assets/dumbbell.jpg',
      'workouts': [
        {'title': 'Push-Up', 'description': 'A great exercise for your chest and arms.', 'image': 'assets/dumbbell.jpg'},
        {'title': 'Pull-Up', 'description': 'Strengthens your back and biceps.', 'image': 'assets/dumbbell.jpg'},
      ],
      'title': 'Upper Body',
    },
    {
      'date': DateTime.now().add(Duration(days: 1)),
      'categoryImage': 'assets/dumbbell.jpg',
      'workouts': [
        {'title': 'Squat', 'description': 'Targets thighs, hips, and buttocks.', 'image': 'assets/dumbbell.jpg'},
        {'title': 'Lunges', 'description': 'Engages quads, glutes, and hamstrings.', 'image': 'assets/dumbbell.jpg'},
      ],
      'title': 'Lower Body',
    },
    {
      'date': DateTime.now().add(Duration(days: 2)),
      'categoryImage': 'assets/dumbbell.jpg',
      'workouts': [
        {'title': 'Plank', 'description': 'Targets core strength.', 'image': 'assets/dumbbell.jpg'},
        {'title': 'Crunches', 'description': 'Engages your abdominal muscles.', 'image': 'assets/dumbbell.jpg'},
      ],
      'title': 'Abs',
    },
    {
      'date': DateTime.now().add(Duration(days: 3)),
      'categoryImage': 'assets/dumbbell.jpg',
      'workouts': [], // Rest Day
      'restMessage': 'Rest day! Take time to recover.',
      'title': 'Rest',
    },
    {
      'date': DateTime.now().add(Duration(days: 4)),
      'categoryImage': 'assets/dumbbell.jpg',
      'workouts': [
        {'title': 'Push-Up', 'description': 'A great exercise for your chest and arms.', 'image': 'assets/dumbbell.jpg'},
        {'title': 'Pull-Up', 'description': 'Strengthens your back and biceps.', 'image': 'assets/dumbbell.jpg'},
      ],
      'title': 'Upper Body',
    },
    {
      'date': DateTime.now().add(Duration(days: 5)),
      'categoryImage': 'assets/dumbbell.jpg',
      'workouts': [
        {'title': 'Squat', 'description': 'Targets thighs, hips, and buttocks.', 'image': 'assets/dumbbell.jpg'},
        {'title': 'Lunges', 'description': 'Engages quads, glutes, and hamstrings.', 'image': 'assets/dumbbell.jpg'},
      ],
      'title': 'Lower Body',
    },
    {
      'date': DateTime.now().add(Duration(days: 6)),
      'categoryImage': 'assets/dumbbell.jpg',
      'workouts': [], // Rest Day
      'restMessage': 'Rest day! Take time to recover.',
      'title': 'Rest',
    },
    {
      'date': DateTime.now().add(Duration(days: 7)),
      'categoryImage': 'assets/dumbbell.jpg',
      'workouts': [
        {'title': 'Push-Up', 'description': 'A great exercise for your chest and arms.', 'image': 'assets/dumbbell.jpg'},
        {'title': 'Pull-Up', 'description': 'Strengthens your back and biceps.', 'image': 'assets/dumbbell.jpg'},
      ],
      'title': 'Upper Body',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize all workouts as not completed
    for (var day in dayWorkouts) {
      for (var workout in day['workouts']) {
        workoutCompletion[workout['title']] = false; // Assume workouts are not completed initially
      }
    }
  }

  // Callback to update workout completion status
  void _updateWorkoutCompletion(String title, bool completed) {
    setState(() {
      workoutCompletion[title] = completed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: dayWorkouts.length, // Set the number of tabs (days)
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your Workout Plan'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0), // Set horizontal padding to 0 to remove gap
              height: 60,
              child: TabBar(
                isScrollable: true,
                indicator: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue, // Color of the active tab bubble
                ),
                unselectedLabelColor: const Color.fromARGB(255, 0, 101, 209), // Color for unselected tabs
                labelColor: Colors.white, // Color for the selected tab
                tabs: dayWorkouts.map((day) {
                  bool isCurrentDay = day['date'].day == DateTime.now().day;
                  return Tab(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isCurrentDay ? Colors.blueAccent : Colors.lightBlueAccent[200],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          day['date'].day.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: dayWorkouts.map((day) {
            return ListView(
              children: [
                // Category Card for each day
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  child: Column(
                    children: [
                      // Category Header
                      ListTile(
                        contentPadding: EdgeInsets.all(10),
                        title: Text(
                          day['title'],
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(day['workouts'].isEmpty ? 'Rest day' : 'Click to see the workouts for this day'),
                      ),
                      // Category Image
                      Image.asset(
                        day['categoryImage'],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      // If it's a rest day, show the rest message
                      if (day['workouts'].isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            day['restMessage'] ?? '',
                            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                          ),
                        ),
                      // List of workouts with tick marks
                      if (day['workouts'].isNotEmpty)
                        ExpansionTile(
                          title: Text("Workouts"),
                          children: day['workouts'].map<Widget>((workout) {
                            bool isCompleted = workoutCompletion[workout['title']] ?? false;
                            return Column(
                              children: [
                                ListTile(
                                  title: Row(
                                    children: [
                                      Expanded(child: Text(workout['title'])),
                                      Icon(
                                        isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                                        color: isCompleted ? Colors.green : Colors.grey,
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(workout['description']),
                                  onTap: () {
                                    // Navigate to the WorkoutDetailPage when tapped
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WorkoutDetailPage(
                                          title: workout['title'],
                                          description: workout['description'],
                                          setsAndReps: [
                                            {'set': 'Set 1', 'reps': '10-12'},
                                            {'set': 'Set 2', 'reps': '8-10'},
                                            {'set': 'Set 3', 'reps': '6-8'},
                                          ],
                                          image: workout['image'],
                                          onCompletionUpdate: (bool completed) {
                                            // Call the callback to update the completion status
                                            _updateWorkoutCompletion(workout['title'], completed);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Divider( // Add a thin divider between items
                                  height: 1,
                                  color: Colors.grey, // Divider color
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:trial/profile.dart';
import 'package:trial/services/loginapi.dart';
import 'workdetails.dart'; // Import the WorkoutDetailPage

class WorkoutListPage extends StatefulWidget {
  const WorkoutListPage({super.key});

  @override
  _WorkoutListPageState createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {


  Map<String, bool> workoutCompletion = {};
  List<Map<String, dynamic>> dayWorkouts = [];
  bool isLoading = true; // Loading state
  String? errorMessage; // Error message for API errors
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _fetchWorkoutData();
  }

  Future<void> _fetchWorkoutData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
    
      final response = await _dio.get('$baseUrl/ViewPostAPIbytrainerid/2');
print(response.data);
      if (response.statusCode == 200 && response.data is List) {
        dayWorkouts=  List<Map<String, dynamic>>.from(response.data);
        // setState(() {
          // dayWorkouts = response.data.map<Map<String, dynamic>>;
          // ((workout) {
          //   return {
          //     workout
            //   'date': DateTime.now(), // Set to current date; modify as needed
            //   'categoryImage': 'assets/dumbbell.jpg', // Default image
            //   'workouts': [
            //     {
            //       'title': workout['name'] ?? 'Untitled Workout',
            //       'description': workout['description'] ?? 'No description available',
            //       'image': 'assets/dumbbell.jpg', // Default image
            //       'video': workout['videos'] ?? '',
            //     },
            //   ],
            //   'title': workout['name'] ?? 'Day Workout',
            // };
          // }).toList();

          // for (var workout in response.data) {
          //   workoutCompletion[workout['name'] ?? ''] = false;
          // }
        // });
      } else {
        throw Exception("Failed to load workouts");
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching workouts: $e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _updateWorkoutCompletion(String title, bool completed) {
    setState(() {
      workoutCompletion[title] = completed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: dayWorkouts.isNotEmpty ? dayWorkouts.length : 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Workout Plan'),
          bottom: isLoading || dayWorkouts.isEmpty
              ? null
              : PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: TabBar(
                    isScrollable: true,
                    indicator: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    unselectedLabelColor: Colors.blueGrey,
                    labelColor: Colors.white,
                    tabs: dayWorkouts.map((day) {
                      return Tab(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent[200],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              day['workoutday'].toString() ?? '-',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null
                ? Center(child: Text(errorMessage!))
                : dayWorkouts.isEmpty
                    ? const Center(child: Text('No workouts available'))
                    : TabBarView(
                        children: dayWorkouts.map((day) {
                          return ListView(
                            padding: const EdgeInsets.all(10),
                            children: [
                              Card(
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                elevation: 5,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        day['type'] ?? 'No Title',
                                        style: const TextStyle(
                                            fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      // subtitle: const Text('Click to see the workouts for this day'),
                                    ),
                                    Image.asset(
                                       'assets/dumbbell.jpg',
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    ExpansionTile(
                                      title: const Text('Workouts'),
                                      children: (day['videos'] ?? []).map<Widget>((workout) {
                                        final isCompleted =
                                            workoutCompletion[workout['name'] ?? ''] ?? false;
                                        return Column(
                                          children: [
                                            ListTile(
                                              title: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(workout['name'] ?? 'Unnamed Workout'),
                                                  ),
                                                  Icon(
                                                    isCompleted
                                                        ? Icons.check_circle
                                                        : Icons.radio_button_unchecked,
                                                    color:
                                                        isCompleted ? Colors.green : Colors.grey,
                                                  ),
                                                ],
                                              ),
                                              subtitle: Text(workout['description'] ?? ''),
                                              onTap: () {
                                                // image=workout['videos'];
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => WorkoutDetailPage(
                                                      title: workout['name'] ?? 'No Title',
                                                      description:
                                                          workout['description'] ?? 'No description',
                                                      setsAndReps: [
                                                      //   {'set': 'Set 1', 'reps': '10-12'},
                                                      //   {'set': 'Set 2', 'reps': '8-10'},
                                                      //   {'set': 'Set 3', 'reps': '6-8'},
                                                      ],
                                                      image: workout['videos'] ,
                                                      onCompletionUpdate: (bool completed) {
                                                        _updateWorkoutCompletion(
                                                            workout['name'] ?? '', completed);
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            const Divider(height: 1, color: Colors.grey),
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

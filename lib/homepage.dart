import 'package:flutter/material.dart';
import 'diet.dart';
import 'workout.dart';
import 'suggestfood.dart'; // Import FoodSuggestionsPage
import 'profile.dart'; // Import ProfilePage
import 'package:intl/intl.dart'; // Import package for date formatting

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Format the date to "Day, Date" (e.g., "Tuesday, 19 December")
    String formattedDate = DateFormat('dd MMMM').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center),
            SizedBox(width: 10),
            Text("Fit-Track"),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Date
              Text(
                "$formattedDate",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Search Box
              _buildSearchBox(context),
              SizedBox(height: 20),

              // Progress Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCircularProgressCard(
                    context,
                    label: "Workout Progress",
                    progress: 0.6, // Example value (60%)
                    color: Colors.blueAccent,
                  ),
                  _buildCircularProgressCard(
                    context,
                    label: "Calories Intake",
                    progress: 0.3, // Example value (30%)
                    color: Colors.green,
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Swipeable Cards
              SizedBox(
                height: 300, // Adjusted height for larger cards
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCard(
                      context,
                      color: Colors.blueAccent,
                      icon: Icons.fitness_center,
                      label: "Workout",
                      destination: WorkoutListPage(),
                    ),
                    _buildCard(
                      context,
                      color: Colors.green,
                      icon: Icons.restaurant,
                      label: "Diet Plan",
                      destination: FoodSuggestionsPage(),
                    ),
                    _buildCard(
                      context,
                      color: Colors.orange,
                      icon: Icons.chat,
                      label: "Chat",
                      destination: Scaffold(
                        appBar: AppBar(title: Text("Chat Section")),
                        body: Center(child: Text("Chat functionality coming soon!")),
                      ),
                    ),
                    _buildCard(
                      context,
                      color: Colors.purple,
                      icon: Icons.person,
                      label: "Profile",
                      destination: ProfilePage(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Famous Workouts List
              Text(
                "Master these Workouts",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildWorkoutList(),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build circular progress cards
  Widget _buildCircularProgressCard(BuildContext context,
      {required String label, required double progress, required Color color}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80, // Decreased height
              width: 80, // Increased width
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    color: color,
                    backgroundColor: Colors.grey[200],
                    strokeWidth: 6.0,
                  ),
                  Center(
                    child: Text(
                      "${(progress * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build swipeable cards
  Widget _buildCard(BuildContext context,
      {required Color color, required IconData icon, required String label, required Widget destination}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        width: MediaQuery.of(context).size.width * 0.9, // Full screen width
        height: 300, // Increased height for larger cards
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16), // Slightly more rounded
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 70), // Larger icon size
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18, // Larger font size
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build the famous workouts list
  Widget _buildWorkoutList() {
    List<String> workouts = [
      "Push-Ups",
      "Pull-Ups",
      "Squats",
      "Lunges",
      "Plank",
      "Deadlifts",
      "Bench Press",
      "Bicep Curls",
      "Burpees",
      "Mountain Climbers",
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            leading: Icon(Icons.fitness_center, color: Colors.blueAccent),
            title: Text(workouts[index]),
          ),
        );
      },
    );
  }

  // Helper method to build search box
  Widget _buildSearchBox(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Full screen width
      height: 35, // Decreased height
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search workouts,plans...",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onChanged: (value) {
          // Add search functionality here
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:trial/services/regApi.dart';

// class SelectTrainerDietitianPage extends StatefulWidget {
//   const SelectTrainerDietitianPage(
//       {super.key,
//       required this.name,
//       required this.password,
//       required this.email,
//       required this.bmi,
//       required this.height,
//       required this.weight,
//       required this.age});
//   final name;
//   final password;
//   final email;
//   final bmi;
//   final height;
//   final weight;
//   final age;

//   @override
//   _SelectTrainerDietitianPageState createState() =>
//       _SelectTrainerDietitianPageState();
// }

// class _SelectTrainerDietitianPageState
//     extends State<SelectTrainerDietitianPage> {
//   String? selectedTrainer;
//   String? selectedDietitian;
//   Map<dynamic, dynamic> datas = {};

//   final List<Map<String, String>> trainers = [
//     {
//       "name": "Trainer 1",
//       "certification": "Certified Strength Trainer",
//       "experience": "5 years experience",
//     },
//     {
//       "name": "Trainer 2",
//       "certification": "Yoga Instructor",
//       "experience": "3 years experience",
//     },
//     {
//       "name": "Trainer 3",
//       "certification": "CrossFit Level 1",
//       "experience": "7 years experience",
//     },
//   ];

//   final List<Map<String, String>> dietitians = [
//     {
//       "name": "Dietitian A",
//       "certification": "Registered Dietitian",
//       "experience": "10 years experience",
//     },
//     {
//       "name": "Dietitian B",
//       "certification": "Sports Nutritionist",
//       "experience": "4 years experience",
//     },
//     {
//       "name": "Dietitian C",
//       "certification": "Clinical Nutritionist",
//       "experience": "6 years experience",
//     },
//   ];

//   void onContinue() {
//     if (selectedTrainer == null || selectedDietitian == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text("Please select both a trainer and a dietitian")),
//       );
//       return;
//     }
//     print('object');
//     datas = {
//       'name': widget.name,
//       'age': widget.age,
//       'email': widget.email,
//       'username': widget.email,
//       'password': widget.password,
//       'height': widget.height,
//       'weight': widget.weight,
//       'bmi': widget.bmi,
//       'calorie': widget.bmi,
//       'preference': widget.bmi,
//       'health_issue': widget.bmi,
//       'trainerid': 1,
//       'dietitionid': 1
//     };
//     registerApi(datas, context);
//   }

//   Widget buildListItem(
//       {required String name,
//       required String certification,
//       required String experience,
//       required bool isSelected,
//       required Function() onSelect}) {
//     return GestureDetector(
//       onTap: onSelect,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.blueAccent.withOpacity(0.2) : Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: isSelected ? Colors.blueAccent : Colors.grey.shade300,
//             width: 2,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               name,
//               style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               certification,
//               style: const TextStyle(fontSize: 14, color: Colors.black54),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               experience,
//               style: const TextStyle(fontSize: 14, color: Colors.black54),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Select Trainer & Dietitian"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const Text(
//               "Choose a Trainer:",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: trainers.length,
//                 itemBuilder: (context, index) {
//                   final trainer = trainers[index];
//                   return buildListItem(
//                     name: trainer['name']!,
//                     certification: trainer['certification']!,
//                     experience: trainer['experience']!,
//                     isSelected: selectedTrainer == trainer['name'],
//                     onSelect: () {
//                       setState(() {
//                         selectedTrainer = trainer['name'];
//                       });
//                     },
//                   );
//                 },
//               ),
//             ),
//             const Text(
//               "Choose a Dietitian:",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: dietitians.length,
//                 itemBuilder: (context, index) {
//                   final dietitian = dietitians[index];
//                   return buildListItem(
//                     name: dietitian['name']!,
//                     certification: dietitian['certification']!,
//                     experience: dietitian['experience']!,
//                     isSelected: selectedDietitian == dietitian['name'],
//                     onSelect: () {
//                       setState(() {
//                         selectedDietitian = dietitian['name'];
//                       });
//                     },
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 onContinue();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blueAccent,
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//               child: const Text("Continue"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:trial/services/loginapi.dart';
import 'package:trial/services/regApi.dart';

class SelectTrainerDietitianPage extends StatefulWidget {
  const SelectTrainerDietitianPage({
    super.key,
    required this.name,
    required this.password,
    required this.email,
    required this.bmi,
    required this.height,
    required this.weight,
    required this.age,
    required this.maintenanceCalories,
  });

  final String name;
  final String password;
  final String email;
  final double bmi;
  final String height;
  final String weight;
  final String age;
  final maintenanceCalories;

  @override
  _SelectTrainerDietitianPageState createState() =>
      _SelectTrainerDietitianPageState();
}

class _SelectTrainerDietitianPageState
    extends State<SelectTrainerDietitianPage> {
      int? trainerId;
      int? dietitianId;
  String? selectedTrainer;
  String? selectedDietitian;
  Map<dynamic, dynamic> datas = {};
  List<Map<String, dynamic>> trainers = [];
  List<Map<String, dynamic>> dietitians = [];
  bool isLoading = true;

  final Dio _dio = Dio(
    
  );

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      print("Fetching trainer and dietitian data...");
      final response = await _dio.get('$baseUrl/ViewTrainerAPI');

      print("Response: ${response.data}");

      if (response.statusCode == 200) {
        setState(() {
          trainers = List<Map<String, dynamic>>.from(response.data['trainer']);
          dietitians = List<Map<String, dynamic>>.from(response.data['dietition']);
          
          print(trainers);
          print(dietitians);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch data from server');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching data: $e")),
      );
    }
  }

  void onContinue() {
    if (selectedTrainer == null || selectedDietitian == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please select both a trainer and a dietitian")),
      );
      return;
    }

    datas = {
      'name': widget.name,
      'age': widget.age,
      'email': widget.email,
      'username': widget.email,
      'password': widget.password,
      'height': widget.height,
      'weight': widget.weight,
      'bmi': widget.bmi,
      'calorie': widget.maintenanceCalories,
      'preference': widget.bmi,
      'health_issue': widget.bmi,
      'trainerid': trainerId,
      'dietitionid': dietitianId,
    };

    registerApi(datas, context);
  }

  Widget buildListItem({
    required String name,
    required String? certification, // Allow this to be nullable
    required String? experience, // Allow this to be nullable
    required bool isSelected,
    required Function() onSelect,
  }) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent.withOpacity(0.2) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blueAccent : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name.isNotEmpty ? name : "No Name", // Use a default value if name is empty
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              certification ?? "No Certification", // Handle null case
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 4),
            Text(
              experience ?? "No Experience", // Handle null case
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Trainer & Dietitian"),
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "Choose a Trainer:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: trainers.length,
                      itemBuilder: (context, index) {
                        final trainer = trainers[index];
                        return buildListItem(
                          name: trainer['name'] ?? "No Name", // Handle null case
                          certification: trainer['certificate'], // This can be null
                          experience: trainer['experience'] ?? "No Experience", // Provide a default if experience is null
                          isSelected: selectedTrainer == trainer['name'],
                          onSelect: () {
                            setState(() {
                              selectedTrainer = trainer['name'];
                              trainerId = trainer['id'];
                            });
                          },
                        );
                      },
                    ),
                  ),
                  const Text(
                    "Choose a Dietitian:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dietitians.length,
                      itemBuilder: (context, index) {
                        final dietitian = dietitians[index];
                        return buildListItem(
                          name: dietitian['name'] ?? "No Name", // Handle null case
                          certification: dietitian['certificate'], // This can be null
                          experience: dietitian['experience'] ?? "No Experience", // Provide a default if experience is null
                          isSelected: selectedDietitian == dietitian['name'],
                          onSelect: () {
                            setState(() {
                              selectedDietitian = dietitian['name'];
                              dietitianId = dietitian['id'];
                            });
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: onContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Continue"),
                  ),
                ],
              ),
            ),
    );
  }
}


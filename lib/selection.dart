import 'package:flutter/material.dart';
import 'package:trial/services/regApi.dart';

class SelectTrainerDietitianPage extends StatefulWidget {
  const SelectTrainerDietitianPage(
      {super.key,
      required this.name,
      required this.password,
      required this.email,
      required this.bmi,
      required this.height,
      required this.weight,
      required this.age});
  final name;
  final password;
  final email;
  final bmi;
  final height;
  final weight;
  final age;

  @override
  _SelectTrainerDietitianPageState createState() =>
      _SelectTrainerDietitianPageState();
}

class _SelectTrainerDietitianPageState
    extends State<SelectTrainerDietitianPage> {
  String? selectedTrainer;
  String? selectedDietitian;
  Map<dynamic, dynamic> datas = {};

  final List<Map<String, String>> trainers = [
    {
      "name": "Trainer 1",
      "certification": "Certified Strength Trainer",
      "experience": "5 years experience",
    },
    {
      "name": "Trainer 2",
      "certification": "Yoga Instructor",
      "experience": "3 years experience",
    },
    {
      "name": "Trainer 3",
      "certification": "CrossFit Level 1",
      "experience": "7 years experience",
    },
  ];

  final List<Map<String, String>> dietitians = [
    {
      "name": "Dietitian A",
      "certification": "Registered Dietitian",
      "experience": "10 years experience",
    },
    {
      "name": "Dietitian B",
      "certification": "Sports Nutritionist",
      "experience": "4 years experience",
    },
    {
      "name": "Dietitian C",
      "certification": "Clinical Nutritionist",
      "experience": "6 years experience",
    },
  ];

  void onContinue() {
    if (selectedTrainer == null || selectedDietitian == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please select both a trainer and a dietitian")),
      );
      return;
    }
    print('object');
    datas = {
      'name': widget.name,
      'age': widget.age,
      'email': widget.email,
      'username': widget.email,
      'password': widget.password,
      'height': widget.height,
      'weight': widget.weight,
      'bmi': widget.bmi,
      'calorie': widget.bmi,
      'preference': widget.bmi,
      'health_issue': widget.bmi,
      'trainerid': 1,
      'dietitionid': 1
    };
    registerApi(datas, context);
  }

  Widget buildListItem(
      {required String name,
      required String certification,
      required String experience,
      required bool isSelected,
      required Function() onSelect}) {
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
              name,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              certification,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 4),
            Text(
              experience,
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
      body: Padding(
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
                    name: trainer['name']!,
                    certification: trainer['certification']!,
                    experience: trainer['experience']!,
                    isSelected: selectedTrainer == trainer['name'],
                    onSelect: () {
                      setState(() {
                        selectedTrainer = trainer['name'];
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
                    name: dietitian['name']!,
                    certification: dietitian['certification']!,
                    experience: dietitian['experience']!,
                    isSelected: selectedDietitian == dietitian['name'],
                    onSelect: () {
                      setState(() {
                        selectedDietitian = dietitian['name'];
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onContinue();
              },
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

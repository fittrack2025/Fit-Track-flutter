import 'package:flutter/material.dart';
import 'dietlist.dart';

class DietPlanPage extends StatefulWidget {
  final List<Map<String, dynamic>> selectedFoods;
  final Function(Map<String, dynamic>) onSaveDietPlan;

  DietPlanPage({required this.selectedFoods, required this.onSaveDietPlan});

  @override
  _DietPlanPageState createState() => _DietPlanPageState();
}

class _DietPlanPageState extends State<DietPlanPage> {
  late List<Map<String, dynamic>> selectedFoods;

  final Map<String, int> foodCalories = {
    'Apple': 95,
    'Banana': 105,
    'Rice': 206,
    'Chicken Breast': 165,
    'Salmon': 232,
    'Eggs': 78,
    'Broccoli': 55,
    'Oats': 154,
  };

  @override
  void initState() {
    super.initState();
    selectedFoods = widget.selectedFoods;
  }

  int _calculateTotalCalories() {
    int totalCalories = 0;
    for (var food in selectedFoods) {
      String foodName = food['food'];
      int quantity = food['quantity'];
      if (foodCalories.containsKey(foodName)) {
        totalCalories += foodCalories[foodName]! * quantity;
      }
    }
    return totalCalories;
  }

  void _removeFood(int index) {
    setState(() {
      selectedFoods.removeAt(index);
    });
  }

  void _saveDietPlan() {
    Map<String, dynamic> dietPlan = {
      'title': 'My Diet Plan',
      'foods': selectedFoods,
    };

    widget.onSaveDietPlan(dietPlan);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DietListPage(dietPlans: [dietPlan]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalCalories = _calculateTotalCalories();

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Diet Plan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected Foods:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: selectedFoods.length,
                itemBuilder: (context, index) {
                  var food = selectedFoods[index]['food'];
                  var quantity = selectedFoods[index]['quantity'];
                  return ListTile(
                    title: Text(food),
                    subtitle: Text('Quantity: $quantity'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _removeFood(index);
                      },
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total Estimated Calories: $totalCalories kcal',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveDietPlan,
              child: Text('Save Diet Plan'),
            ),
          ],
        ),
      ),
    );
  }
}

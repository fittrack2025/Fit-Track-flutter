import 'package:flutter/material.dart';
import 'diet.dart';
import 'dietlist.dart';

class FoodSuggestionsPage extends StatefulWidget {
  @override
  _FoodSuggestionsPageState createState() => _FoodSuggestionsPageState();
}

class _FoodSuggestionsPageState extends State<FoodSuggestionsPage> {
  final List<String> commonFoods = [
    'Apple',
    'Banana',
    'Rice',
    'Chicken Breast',
    'Salmon',
    'Eggs',
    'Broccoli',
    'Oats',
  ];

  List<Map<String, dynamic>> selectedFoods = [];
  List<Map<String, dynamic>> dietPlans = []; // Shared diet plan list

  TextEditingController foodController = TextEditingController();

  void _addCustomFood() {
    String enteredFood = foodController.text.trim();
    if (enteredFood.isNotEmpty) {
      setState(() {
        selectedFoods.add({'food': enteredFood, 'quantity': 1});
      });
      foodController.clear();
    }
  }

  void _addFoodFromSuggestion(String food) {
    setState(() {
      selectedFoods.add({'food': food, 'quantity': 1});
    });
  }

  void _saveDietPlan(Map<String, dynamic> dietPlan) {
    setState(() {
      dietPlans.add(dietPlan);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Foods'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: foodController,
              decoration: InputDecoration(
                labelText: 'Enter food item',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addCustomFood,
                ),
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: commonFoods.map((food) {
                return ActionChip(
                  label: Text(food),
                  onPressed: () {
                    _addFoodFromSuggestion(food);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: selectedFoods.length,
                itemBuilder: (context, index) {
                  var food = selectedFoods[index]['food'];
                  var quantity = selectedFoods[index]['quantity'];

                  return ListTile(
                    title: Text(food),
                    subtitle: Row(
                      children: [
                        Text('Quantity: $quantity'),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) {
                                selectedFoods[index]['quantity'] = quantity - 1;
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              selectedFoods[index]['quantity'] = quantity + 1;
                            });
                          },
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.delete, color: Colors.red),
                    onLongPress: () {
                      setState(() {
                        selectedFoods.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DietPlanPage(
                      selectedFoods: selectedFoods,
                      onSaveDietPlan: _saveDietPlan,
                    ),
                  ),
                );
              },
              child: Text('View Full Diet Plan'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DietListPage(
                      dietPlans: dietPlans,
                    ),
                  ),
                );
              },
              child: Text('View Created Diet Plans'),
            ),
          ],
        ),
      ),
    );
  }
}

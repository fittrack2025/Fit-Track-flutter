import 'package:flutter/material.dart';
import 'suggestfood.dart'; // Import the FoodSuggestionsPage

class DietListPage extends StatefulWidget {
  final List<Map<String, dynamic>> dietPlans;

  DietListPage({required this.dietPlans});

  @override
  _DietListPageState createState() => _DietListPageState();
}

class _DietListPageState extends State<DietListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet Plans'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            widget.dietPlans.isEmpty
                ? Expanded(child: Center(child: Text('No Diet Plans Saved')))
                : Expanded(
                    child: ListView.builder(
                      itemCount: widget.dietPlans.length,
                      itemBuilder: (context, index) {
                        var dietPlan = widget.dietPlans[index];
                        return Card(
                          elevation: 4,
                          child: ListTile(
                            title: Text(dietPlan['title']),
                            subtitle: Text('Foods: ${dietPlan['foods'].length}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  widget.dietPlans.removeAt(index);
                                });
                              },
                            ),
                            onTap: () {
                              // View details if needed
                            },
                          ),
                        );
                      },
                    ),
                  ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodSuggestionsPage(),
                  ),
                );
              },
              child: Text('Create your Diet plan'),
            ),
          ],
        ),
      ),
    );
  }
}

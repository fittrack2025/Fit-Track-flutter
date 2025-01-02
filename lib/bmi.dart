import 'package:flutter/material.dart';
import 'package:trial/selection.dart';

class BMICalculator extends StatefulWidget {
  final email;
  final name;
  final password;

  const BMICalculator(
      {super.key,
      required this.email,
      required this.name,
      required this.password});

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  double _bmi = 0.0;

  void _calculateBMI() {
    final double? height = double.tryParse(heightController.text);
    final double? weight = double.tryParse(weightController.text);

    if (height != null && height > 0 && weight != null && weight > 0) {
      setState(() {
        _bmi = weight /
            ((height / 100) * (height / 100)); // Height is converted to meters
      });
    } else {
      setState(() {
        _bmi = 0.0;
      });
    }
  }

  void _onContinuePressed() {
    // Handle the action when the "Continue" button is pressed
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => SelectTrainerDietitianPage(
                  bmi: _bmi,
                  age: ageController.text,
                  height: heightController.text,
                  weight: weightController.text,
                  email: widget.email,
                  password: widget.password,
                  name: widget.name,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _calculateBMI(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _calculateBMI(),
            ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  const Text(
                    'Your BMI:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _bmi > 0 ? _bmi.toStringAsFixed(2) : '--',
                    style:
                        const TextStyle(fontSize: 32, color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                _bmi == 0
                    ? 'Enter valid height and weight to calculate BMI.'
                    : _bmi < 18.5
                        ? 'Underweight'
                        : _bmi < 24.9
                            ? 'Normal weight'
                            : _bmi < 29.9
                                ? 'Overweight'
                                : 'Obesity',
                style: const TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _onContinuePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                      fontSize: 16, color: Colors.white), // White text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

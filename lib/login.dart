import 'package:flutter/material.dart';
import 'register.dart'; // Import the Sign class

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/blue.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to FitTrack',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 62, 128), // Darker blue shade
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(200, 255, 255, 255), // Lighter white
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: isPasswordVisible,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(200, 255, 255, 255),
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.blueAccent,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Action for login
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white, // White text
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  // Action for forgot password
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 52, 79, 119),
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Color.fromARGB(179, 42, 42, 42),
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Sign()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

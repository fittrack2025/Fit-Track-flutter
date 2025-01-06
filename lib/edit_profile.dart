// import 'package:flutter/material.dart';

// class EditProfilePage extends StatefulWidget {
//   final String name;
//   final String email;
//   final String gender;
//   const EditProfilePage({Key? key, required this.name, required this.email, required this.gender}) : super(key: key);

//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   final _formKey = GlobalKey<FormState>();

//   // Example fields for the user profile
//   String? _name;
//   String? _email;
//   String? _phone;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Profile'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Update your profile information",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),

//               // Name Field
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 initialValue: "John Doe", // Default value
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _name = value,
//               ),
//               const SizedBox(height: 20),

//               // Email Field
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 initialValue: "johndoe@example.com", // Default value
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _email = value,
//               ),
//               const SizedBox(height: 20),

//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Gender',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 initialValue: "John Doe", // Default value
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _name = value,
//               ),
//               const SizedBox(height: 20),

 

//               // Save Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blueAccent,
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                   ),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       // Simulate saving the data
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                             content: Text('Profile updated successfully')),
//                       );
//                     }
//                   },
//                   child: const Text(
//                     'Save Changes',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';

// class EditProfilePage extends StatefulWidget {
//   final String name;
//   final String email;
//   final String gender;

//   const EditProfilePage({
//     Key? key,
//     required this.name,
//     required this.email,
//     required this.gender,
//   }) : super(key: key);

//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   final _formKey = GlobalKey<FormState>();

//   // State variables to store updated values
//   late String _name;
//   late String _email;
//   late String _gender;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize with the values passed from the constructor
//     _name = widget.name;
//     _email = widget.email;
//     _gender = widget.gender;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Profile'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Update your profile information",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),

//               // Name Field
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 initialValue: _name,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _name = value!,
//               ),
//               const SizedBox(height: 20),

//               // Email Field
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 initialValue: _email,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _email = value!,
//               ),
//               const SizedBox(height: 20),

//               // Gender Field
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Gender',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 initialValue: _gender,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your gender';
//                   } else if (!['Male', 'Female', 'Other'].contains(value)) {
//                     return 'Please enter a valid gender (Male, Female, or Other)';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _gender = value!,
//               ),
//               const SizedBox(height: 20),

//               // Save Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blueAccent,
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                   ),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       // Simulate saving the data
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Profile updated successfully'),
//                         ),
//                       );

//                       // Navigate back with updated data
//                       Navigator.pop(context, {
//                         'name': _name,
//                         'email': _email,
//                         'gender': _gender,
//                       });
//                     }
//                   },
//                   child: const Text(
//                     'Save Changes',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:trial/services/loginapi.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String gender;
  final String id;

  const EditProfilePage({
    Key? key,
    required this.name,
    required this.email,
    required this.gender, required this.id,
  }) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // State variables to store updated values
  late String _name;
  late String _email;
  late String _gender;
  late String _id;

String? _selectedval;
  @override
  void initState() {
    super.initState();
    // Initialize with the values passed from the constructor
    _name = widget.name;
    _email = widget.email;
    _gender = widget.gender;
    _id= widget.id.toString();
    _selectedval=widget.gender;
  }

  // Function to send data to the API using Dio
  Future<void> _updateProfile() async {
    const String apiUrl = 'http://192.168.1.196:5000/EditProfile'; // Replace with your API endpoint

    Dio dio = Dio();

    try {
      final response = await dio.post(
        apiUrl,
        data: {
          'name': _name,
          'email': _email,
          'gender': _gender,
          'id':_id,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Successfully updated profile
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data['message'] ?? 'Profile updated successfully')),
        );

        // Navigate back with updated data
        Navigator.pop(context, {
          'name': _name,
          'email': _email,
          'gender': _gender,
        });
      } else {
        // API error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: ${response.statusMessage}')),
        );
      }
    } on DioError catch (error) {
      // Handle Dio-specific errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.response?.data['message'] ?? error.message}')),
      );
    } catch (error) {
      // Handle other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Update your profile information",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Name Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                initialValue: _name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              const SizedBox(height: 20),

              // Email Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                initialValue: _email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 20),

              // Gender Field
              // TextFormField(
              //   decoration: InputDecoration(
              //     labelText: 'Gender',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   initialValue: _gender,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your gender';
              //     } else if (!['Male', 'Female', 'Other'].contains(value)) {
              //       return 'Please enter a valid gender (Male, Female, or Other)';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) => _gender = value!,
              // ),



RadioListTile<String>(
                title: const Text('Male'),
                value: 'male',
                groupValue: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                  // Navigator.of(context).pop(); // Close dialog
                },
              ),
              RadioListTile<String>(
                title: const Text('Female'),
                value: 'female',
                groupValue: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                  // Navigator.of(context).pop(); // Close dialog
                },
              ),
              RadioListTile<String>(
                title: const Text('Other'),
                value: 'other',
                groupValue: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                  // Navigator.of(context).pop(); // Close dialog
                },
              ),




              const SizedBox(height: 20),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _updateProfile(); // Call the API function
                    }
                  },
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

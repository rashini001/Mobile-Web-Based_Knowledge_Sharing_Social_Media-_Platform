import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
// Import the LoginPage
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _selectedFileName = 'No file chosen'; // Initially, no file chosen
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false; // Password visibility state
  bool _isConfirmPasswordVisible = false; // Confirm password visibility state

  // Method to handle file picking
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        _selectedFileName = file.name; // Update file name after selection
      });
    } else {
      // User canceled the picker
      setState(() {
        _selectedFileName = 'No file chosen';
      });
    }
  }

  // Method to validate the form and proceed with registration
  void _register() {
    if (_formKey.currentState!.validate()) {
      // Perform registration actions here (e.g., API call)

      // Show a success message or navigate to another page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful!')),
      );

       // Navigate to the Login Page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        iconTheme: const IconThemeData(color: Colors.white), // Set back button arrow color to white
        backgroundColor: const Color.fromARGB(255, 38, 27, 102), // Brown app bar
      ),
      body: Container(
        color: Colors.grey[300], // Light gray background
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.brown[50], // Light brown background for card
                child: Form(
                  key: _formKey, // Assign the form key here
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Create Your Account', // Updated title
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(197, 0, 0, 0)),
                      ),
                      
                      const SizedBox(height: 20),
                      // Row for name and password fields
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Your Name',
                                labelStyle: const TextStyle(color: Colors.brown),
                                hintText: 'Enter your name',
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown[200]!),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null; // Valid input
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Your Password',
                                labelStyle: const TextStyle(color: Colors.brown),
                                hintText: 'Enter your password',
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown[200]!),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.brown,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                                    });
                                  },
                                ),
                              ),
                              obscureText: !_isPasswordVisible,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null; // Valid input
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Row for email and confirm password fields
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Your Email',
                                labelStyle: const TextStyle(color: Colors.brown),
                                hintText: 'Enter your email',
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown[200]!),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                // Simple email validation
                                String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                                RegExp regex = RegExp(pattern);
                                if (!regex.hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null; // Valid input
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle: const TextStyle(color: Colors.brown),
                                hintText: 'Confirm your password',
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown[200]!),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isConfirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.brown,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible; // Toggle visibility
                                    });
                                  },
                                ),
                              ),
                              obscureText: !_isConfirmPasswordVisible,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null; // Valid input
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Select Image field (Updated to browse file)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Select Image',
                              style: TextStyle(color: Colors.brown),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: _pickFile, // Trigger file picker when tapped
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    // The "Choose File" button
                                    Container(
                                      color: const Color.fromARGB(47, 190, 29, 29), // Light gray background for button
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                      child: const Text(
                                        'Choose File',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // Display the chosen file name
                                    Expanded(
                                      child: Text(
                                        _selectedFileName!,
                                        style: const TextStyle(color: Colors.black), // Black text for file name
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Register button
                      ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0), 
                          foregroundColor: Colors.white, // White text for button
                        ), // Call register method
                        child: const Text(
                          'Register Now',
                          style: TextStyle(color: Colors.white), // Set button text color to white
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text(
                          'Already have an account? Login here',
                         style: TextStyle(color: Color.fromARGB(255, 2, 1, 10), fontWeight: FontWeight.bold), // Changed to bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

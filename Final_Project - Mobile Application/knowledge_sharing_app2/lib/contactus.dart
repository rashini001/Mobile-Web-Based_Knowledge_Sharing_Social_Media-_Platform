import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Connect With Us',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 38, 27, 102),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Main content area
            Row(
              children: [
                // Left side image container
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 245, 245, 245),
                    child: Center(
                      child: Image.asset(
                        'assets/contact.png', // Path to your asset image
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                // Right side form container
                Expanded(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Connect With Us',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          _buildTextField(
                              'Enter your name', 'Please enter your name',
                              isNameField: true),
                          const SizedBox(height: 20),
                          _buildTextField('Enter your email',
                              'Please enter a valid email'),
                          const SizedBox(height: 20),
                          _buildTextField('Enter your number',
                              'Please enter your number'),
                          const SizedBox(height: 20),
                          _buildTextField('Enter your message',
                              'Please enter your message',
                              maxLines: 5),
                          const SizedBox(height: 30),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Message Sent Successfully!')),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 47, 10, 148),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Send Message',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Contact Info Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoCard(
                    icon: Icons.phone,
                    title: 'Phone Number',
                    details: ['0773605287', '0913934587'],
                    iconColor: const Color.fromARGB(255, 47, 10, 148),
                  ),
                  _buildInfoCard(
                    icon: Icons.email,
                    title: 'Email Address',
                    details: ['rashini@gmail.com', 'imangana@gmail.com'],
                    iconColor: const Color.fromARGB(255, 47, 10, 148),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Footer
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              child: const Text(
                'privacy policy | all rights reserved!',
                style: TextStyle(color: Color.fromARGB(226, 0, 0, 0), fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, String errorMessage,
      {bool isNameField = false, int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      cursorColor: const Color.fromARGB(255, 47, 10, 148),
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 47, 10, 148)),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(251, 0, 0, 0)),
          borderRadius: BorderRadius.circular(8),
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        if (isNameField && value.length < 3) {
          return 'Name must be at least 3 characters';
        }
        if (!isNameField && hint == 'Enter your email') {
          const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
          final regex = RegExp(pattern);
          if (!regex.hasMatch(value)) {
            return 'Please enter a valid email';
          }
        }
        return null;
      },
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required List<String> details,
    required Color iconColor,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: iconColor),
            const SizedBox(height: 10),
            Text(
              title.toLowerCase(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            for (String detail in details)
              Text(
                detail,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
          ],
        ),
      ),
    );
  }
}

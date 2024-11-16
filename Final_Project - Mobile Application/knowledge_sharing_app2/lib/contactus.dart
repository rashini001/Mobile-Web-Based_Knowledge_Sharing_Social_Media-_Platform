import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Key to manage the form state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Connect With Us',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 38, 27, 102), // Brown background color
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigate back when pressed
          },
        ),
      ),
      body: Row(
        children: [
          // Left side image container
          Expanded(
            child: Container(
               color: Colors.grey[300],// Light gray background color
              child: Center(
                child: Image.network(
                  'https://media.istockphoto.com/id/1305608421/vector/technical-support-or-call-center-concept-vector-hotline-in-company-24-on-7-manager-working.jpg?s=612x612&w=0&k=20&c=542nvP6imZn4tooVaWykWkaZig3DcfUGRfDXrQfFk9s=', // URL of your image
                  fit: BoxFit.cover, // Make the image cover the entire container
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    return Center(child: Text('Image failed to load'));
                  },
                ),
              ),
            ),
          ),

          // Right side form container
          Expanded(
            child: SingleChildScrollView( // Added ScrollView to prevent overflow
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey, // Set the form key
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center( // Center the title
                        child: Text(
                          'Connect With Us',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                             color: Colors.brown[800], // Brown text color
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildTextField('Enter your name', 'Please enter your name', isNameField: true),
                      SizedBox(height: 16),
                      _buildTextField('Enter your email', 'Please enter a valid email'),
                      SizedBox(height: 16),
                      _buildTextField('Enter your number', 'Please enter your number'),
                      SizedBox(height: 16),
                      _buildTextField('Enter your message', 'Please enter your message', maxLines: 5),
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, proceed with your action (e.g., sending the message)
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Sending message...')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 0, 0), //  button color
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                          ),
                          child: Text(
                            'Send Message',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, String errorMessage, {bool isNameField = false, int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      cursorColor: Color.fromARGB(255, 6, 1, 29), // Change cursor color to brown
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 47, 10, 148))), // Change border color to brown
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 47, 10, 148))), // Change enabled border color to brown
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 47, 10, 148))), // Change focused border color to brown
        fillColor: Colors.grey[100],
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
        return null; // Return null if valid
      },
    );
  }
}

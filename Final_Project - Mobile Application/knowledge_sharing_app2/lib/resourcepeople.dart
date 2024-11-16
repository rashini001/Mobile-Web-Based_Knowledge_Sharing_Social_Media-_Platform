import 'package:flutter/material.dart';

class ResourcePeoplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resource People',
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
       backgroundColor: Color.fromARGB(255, 38, 27, 102), // Set AppBar color 
        elevation: 0, // Remove AppBar shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Set back arrow color to white
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
              color: Colors.grey[300], // light gray background color
              child: Image.network(
                'https://static.vecteezy.com/system/resources/previews/048/232/022/non_2x/online-courses-illustration-illustrated-online-courses-concept-with-woman-on-laptop-illustration-vector.jpg', // URL of your image
                fit: BoxFit.cover, // Make the image cover the entire container
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          // Right side text container
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
                mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                children: [
                  Text(
                    "\"Connect with Experts and Mentors\"",
                    textAlign: TextAlign.center, // Center the text
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[800], // Set text color to brown
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Our platform connects you with a diverse group of industry experts, educators, and mentors. Whether you\'re seeking guidance on your projects, looking for career advice, or expanding your professional network, our resource people are here to help you succeed.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]), // Set gray text color
                    textAlign: TextAlign.center, // Center the text
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Join the conversation, collaborate on ideas, and gain insights from experienced professionals across the globe. Our experts are just a click away!',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]), // Set gray text color
                    textAlign: TextAlign.center, // Center the text
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Action for "Connect"
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 18, 4, 49), // Dark brown button color
                      padding: EdgeInsets.symmetric(
                          horizontal: 50, vertical: 16),
                    ),
                    child: Text(
                      'Connect',
                      style: TextStyle(fontSize: 16, color: Colors.white), // Button text color set to white
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text(
          'Contact With Us',
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
      body: Container(
        color: const Color.fromARGB(255, 94, 106, 212), // Background color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Larger illustration at the top
            Expanded(
              flex: 4, // Increased flex value to make the image section larger
              child: Center(
                child: Image.asset(
                  'assets/chat.jpg', // Replace with your image asset
                  height: 350, // Increased height for a larger image
                  fit: BoxFit.contain, // Ensures the image scales properly
                ),
              ),
            ),

            // Buttons at the bottom
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200, // Set a specific width for the button
                      child: ElevatedButton(
                        onPressed: () {
                          // Action for "I'm a Resource People"
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 90, 117, 139),
                          padding: const EdgeInsets.symmetric(vertical: 10), // Reduced vertical padding
                          minimumSize: Size(0, 60), // Button height
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "I'm a Resource People",
                          style: TextStyle(
                            fontSize: 16, // Adjusted font size
                            color: Colors.black, // Black text color
                            fontWeight: FontWeight.bold, // Bold text
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30), // Reduced spacing between buttons
                    SizedBox(
                      width: 200, // Set a specific width for the button
                      child: ElevatedButton(
                        onPressed: () {
                          // Action for "I'm a Student"
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 90, 117, 139),
                          padding: const EdgeInsets.symmetric(vertical: 10), // Reduced vertical padding
                          minimumSize: Size(0, 60), // Button height
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "I'm a Student",
                          style: TextStyle(
                            fontSize: 16, // Adjusted font size
                            color: Colors.black, // Black text color
                            fontWeight: FontWeight.bold, // Bold text
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ACADEMIST...',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[200], // Light grey background
        elevation: 0, // Remove shadow
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 600, // Set the desired width of the search bar
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'search courses...',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search, color: Colors.grey),
                        onPressed: () {
                          // Action when the search icon is clicked
                          print("Search icon clicked!");
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // All Courses Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Colors.grey[200],
            child: const Text(
              'All Courses',
              style: TextStyle(
                fontSize: 24.0, // Increased font size
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 38, 77), // Dark blue color
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text(
                  'no courses added yet!',
                  style: TextStyle(color: Colors.red, fontSize: 16.0),
                ),
              ),
            ),
          ),
          // Footer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            color: Colors.grey[200],
            child: const Text(
              'privacy policy | all rights reserved!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CoursesPage(),
  ));
}

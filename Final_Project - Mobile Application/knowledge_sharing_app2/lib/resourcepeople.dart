import 'package:flutter/material.dart';
import 'package:knowledge_sharing_app2/resregister.dart';

class ResourcePeoplePage extends StatelessWidget {
  const ResourcePeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resource People',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[200], // Light gray background
        elevation: 0, // Remove AppBar shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back when pressed
          },
        ),
      ),
      body: Column(
        children: [
          // Expertise Search Section
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Expertise',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 38, 77), // Dark blue color
                  ),
                ),
                const Divider(color: Colors.grey),
                const SizedBox(height: 16.0),
                Center(
                  child: SizedBox(
                    width: 600, // Minimized search bar width
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'search resource person...',
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          height: 48.0,
                          width: 48.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.search, color: Color.fromARGB(255, 0, 38, 77)),
                            onPressed: () {
                              // Search action
                              print("Search clicked!");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 400, // Minimized the width of the box
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Become A Resource Person',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 38, 77), // Dark blue color
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '"Join Us and Inspire the Next Generation of Software Engineers!" Become a part of our growing community of experts dedicated to sharing knowledge and shaping future tech leaders. Let’s work together to bridge the gap between theory and practice, empowering learners to achieve their career goals. Start making an impact today!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
              onPressed: () {
                   print("Get Access clicked!");
                   Navigator.push(
                   context,
                  MaterialPageRoute(builder: (context) => ResRegisterPage()),
              );
          },
               style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 16, 3, 61), // Dark blue color
              padding: const EdgeInsets.symmetric(
              horizontal: 40, vertical: 12),
     ),
           child: const Text(
            'Get Access',
            style: TextStyle(fontSize: 16, color: Colors.white),
      ),
     ),
                  ],
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
              style: TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 8, 8, 8)),
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
    home: ResourcePeoplePage(),
  ));
}

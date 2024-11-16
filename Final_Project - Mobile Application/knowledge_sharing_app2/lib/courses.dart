import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Courses',
          style: TextStyle(color: Colors.white), // Set title color to white for better contrast
        ),
         backgroundColor: Color.fromARGB(255, 38, 27, 102), // Set AppBar color to brown
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
              color: Colors.grey[300], // Light gray background color
              child: Center(
                child: Image.network(
                  'https://thumbs.dreamstime.com/b/online-learning-lessons-webinar-education-courses-teacher-teaches-group-students-vector-illustration-131437671.jpg', // URL of your image
                  fit: BoxFit.cover, // Make the image cover the entire container
                  height: double.infinity, // Set the height to fill the container
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
          // Right side text container
          Expanded(
            child: Container(
              color: Colors.brown[50], // Light brown background color
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
                mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                children: [
                  Text(
                    "\"Expand Your Skills with Our Courses\"",
                    textAlign: TextAlign.center, // Center the text within the widget
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900], // Dark brown text color
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Our courses are carefully crafted to provide you with practical knowledge and hands-on experience in the world of technology. Whether you\'re a beginner or an experienced professional, we have something for everyone.',
                    textAlign: TextAlign.center, // Center the text within the widget
                    style: TextStyle(fontSize: 16, color: Colors.brown[700]), // Darker brown for text
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Join a community of learners and experts, and take your skills to the next level with our comprehensive learning materials, interactive sessions, and real-world projects.',
                    textAlign: TextAlign.center, // Center the text within the widget
                    style: TextStyle(fontSize: 16, color: Colors.brown[700]), // Darker brown for text
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Action for "Start Learning"
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 0, 0), // Dark brown button color
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                      ),
                      child: Text(
                        'Start Learning',
                        style: TextStyle(fontSize: 16, color: Colors.white), // White text on button
                      ),
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

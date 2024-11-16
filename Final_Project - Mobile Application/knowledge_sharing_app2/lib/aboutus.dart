import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
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
                  'https://media.istockphoto.com/id/1318094843/vector/a-team-of-analysts-holds-a-meeting-and-develops-a-marketing-strategy-based-on-statistical.jpg?s=612x612&w=0&k=20&c=NRXC2IBNwaA4urA8KuYSmGgZj8bn63C0FNVDYoriYZI=', // URL of your image
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
          // Right side text container
          Expanded(
            child: Container(
              color: Colors.brown[50], // Light brown background color
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
                mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                children: [
                  Text(
                    "\"Empowering Learning, Connecting Minds\"",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900], // Dark brown text color
                    ),
                    textAlign: TextAlign.center, // Center the text
                  ),
                  SizedBox(height: 20),
                  Text(
                    'We are a vibrant knowledge-sharing platform where students and experts come together to learn, grow, and innovate. Our mission is to bridge the gap between education and real-world experience, fostering a collaborative community that encourages lifelong learning.',
                    style: TextStyle(fontSize: 16, color: Colors.brown[700]), // Darker brown for text
                    textAlign: TextAlign.center, // Center the text
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Whether you\'re here to share your expertise or expand your skills, our platform offers the tools and connections you need to succeed in the ever-evolving world of software engineering.',
                    style: TextStyle(fontSize: 16, color: Colors.brown[700]), // Darker brown for text
                    textAlign: TextAlign.center, // Center the text
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Action for "View Courses"
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 0, 0), //  button color
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                      ),
                      child: Text(
                        'View Courses',
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

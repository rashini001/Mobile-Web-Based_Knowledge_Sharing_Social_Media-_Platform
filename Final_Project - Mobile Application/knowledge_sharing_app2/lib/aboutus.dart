import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white), // Set title color to white for better contrast
        ),
        backgroundColor: const Color.fromARGB(255, 38, 27, 102), // Set AppBar color
        elevation: 0, // Remove AppBar shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Set back arrow color to white
          onPressed: () {
            Navigator.pop(context); // Navigate back when pressed
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3, // Make this section take 3/4 of the screen height
            child: Row(
              children: [
                // Left side image container
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 255, 255, 255), // Light gray background color
                    child: Center(
                      child: SizedBox(
                        width: 500, // Adjust width of the image
                        height: 500, // Adjust height of the image
                        child: Image.asset(
                          'assets/about.png', // Path to your asset image
                          fit: BoxFit.cover, // Make the image cover the specified box
                        ),
                      ),
                    ),
                  ),
                ),
                // Right side text container
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 253, 253, 253), // Light brown background color
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
                      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                      children: [
                        Text(
                          "\"Empowering Learning, Connecting Minds\"",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[900], // Dark brown text color
                          ),
                          textAlign: TextAlign.center, // Center the text
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'We are a vibrant knowledge-sharing platform where students and experts come together to learn, grow, and innovate. Our mission is to bridge the gap between education and real-world experience, fostering a collaborative community that encourages lifelong learning.',
                          style: TextStyle(fontSize: 16, color: Colors.brown[700]), // Darker brown for text
                          textAlign: TextAlign.center, // Center the text
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Whether you\'re here to share your expertise or expand your skills, our platform offers the tools and connections you need to succeed in the ever-evolving world of software engineering.',
                          style: TextStyle(fontSize: 16, color: Colors.brown[700]), // Darker brown for text
                          textAlign: TextAlign.center, // Center the text
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Action for "View Courses"
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 0, 0, 0), // Button color
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                            ),
                            child: const Text(
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
          ),
          Expanded(
            flex: 1, // Make this section take 1/4 of the screen height
            child: Container(
              color: const Color.fromARGB(255, 255, 254, 254), // Light background color
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatCard(Icons.school, "+1k", "Online Courses"),
                      _buildStatCard(Icons.person, "+25k", "Brilliant Students"),
                      _buildStatCard(Icons.laptop, "+5k", "Expert Resource People"),
                      _buildStatCard(Icons.star, "100%", "Satisfaction"),
                    ],
                  ),
                  Text(
                    'Privacy Policy | All Rights Reserved!',
                    style: TextStyle(color: Colors.grey[800], fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String count, String label) {
    return Container(
      width: 230, // Increased width
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Reduced height padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8), // Adjusted corner radius for a cleaner look
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 255, 254, 254).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: Colors.indigo[900]), // Adjusted icon size
          const SizedBox(height: 6), // Reduced spacing
          Text(
            count,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo[900]),
          ),
          const SizedBox(height: 4), // Reduced spacing
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey[800]), // Slightly smaller font
          ),
        ],
      ),
    );
  }
}

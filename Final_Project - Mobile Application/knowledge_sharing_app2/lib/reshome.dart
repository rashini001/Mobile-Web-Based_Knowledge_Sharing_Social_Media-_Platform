import 'package:flutter/material.dart';
import 'package:knowledge_sharing_app2/chat.dart';
import 'package:knowledge_sharing_app2/contactus.dart';
import 'package:knowledge_sharing_app2/resquiz.dart';
import 'aboutus.dart'; // Import the About Us page

class ResHomePage extends StatefulWidget {
  @override
  _ResHomePageState createState() => _ResHomePageState();
}

class _ResHomePageState extends State<ResHomePage> {
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ACADEMIST...',
          style: TextStyle(color: Color.fromARGB(255, 238, 231, 231), fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: const Color.fromARGB(255, 117, 63, 63),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color.fromARGB(255, 204, 199, 199)),
          onPressed: () {
            setState(() {
              isDrawerOpen = !isDrawerOpen;
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main Content
          Container(
            color: const Color(0xFFEFEFEF), // Background color
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                QuickOptionsSection(), // Add Quick Options Section
                const SizedBox(height: 16),
                TopCategoriesSection(), // Add Top Categories Section
                const SizedBox(height: 16),
                PopularTopicsSection(), // Add Popular Topics Section
              ],
            ),
          ),

          // Navigation Drawer
          if (isDrawerOpen)
            Align(
              alignment: Alignment.topLeft,
              child: Material(
                color: const Color.fromARGB(225, 255, 255, 255),
                elevation: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2, // Reduced width
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            _buildDrawerItem(
                              Icons.dashboard,
                              'Dashboard',
                              addPaddingTop: true, // Add top padding for Dashboard
                            ),
                            _buildDrawerItem(
                              Icons.info,
                              'About Us',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                                );
                              },
                            ),
                            _buildDrawerItem(Icons.school, 'Courses'),
                            _buildDrawerItem(Icons.quiz, 'Quiz',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ResQuizPage()),
                                );
                              },
                            ),
                            _buildDrawerItem(Icons.chat, 'Chat',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ChatScreen()),
                                );
                              },
                            ),
                            _buildDrawerItem(Icons.contact_mail, 'Contact Us',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ContactUsPage()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title,
      {bool addPaddingTop = false, VoidCallback? onTap}) {
    return Padding(
      padding: EdgeInsets.only(top: addPaddingTop ? 90.0 : 0.0), // Add padding if specified
      child: ListTile(
        leading: Icon(icon, color: const Color.fromARGB(255, 4, 3, 105)), // Custom color
        title: Text(title, style: const TextStyle(color: Colors.black)),
        onTap: onTap ?? () {
          setState(() {
            isDrawerOpen = false;
          });
        },
      ),
    );
  }
}

// Quick Options Section Class (remains unchanged)
class QuickOptionsSection extends StatelessWidget {
  const QuickOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(158, 238, 238, 238),
        borderRadius: BorderRadius.circular(8),
      ),
      
    );
  }
}

// Updated Top Categories Section with buttons
class TopCategoriesSection extends StatelessWidget {
  const TopCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Top Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              CategoryButton(title: 'DevOps'),
              CategoryButton(title: 'FullStack'),
              CategoryButton(title: 'Mobile'),
              CategoryButton(title: 'UI/UX'),
              CategoryButton(title: 'Cloud'),
              CategoryButton(title: 'BackEnd'),
              CategoryButton(title: 'FrontEnd'),
              CategoryButton(title: 'Networking'),
            ],
          ),
        ],
      ),
    );
  }
}

// Category button widget
class CategoryButton extends StatelessWidget {
  final String title;

  const CategoryButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Placeholder for navigation action
        print('$title button pressed');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 194, 188, 185),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(title, style: TextStyle(color: Color.fromARGB(255, 7, 2, 31))),
    );
  }
}

// Updated Popular Topics Section with buttons
class PopularTopicsSection extends StatelessWidget {
  const PopularTopicsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Popular Topics', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              TopicButton(title: 'HTML'),
              TopicButton(title: 'CSS'),
              TopicButton(title: 'Flutter'),
              TopicButton(title: 'JavaScript'),
              TopicButton(title: 'Dart'),
              TopicButton(title: 'NodeJS'),
              TopicButton(title: 'AI/ML'),
              TopicButton(title: 'Data Science'),
            ],
          ),
        ],
      ),
    );
  }
}

// Topic button widget
class TopicButton extends StatelessWidget {
  final String title;

  const TopicButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Placeholder for navigation action
        print('$title button pressed');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 204, 204, 204),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(title, style: TextStyle(color: Color.fromARGB(255, 7, 2, 31))),
    );
  }
}

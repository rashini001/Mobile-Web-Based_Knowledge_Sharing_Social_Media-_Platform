import 'package:flutter/material.dart';
import 'package:knowledge_sharing_app2/contactus.dart';
import 'package:knowledge_sharing_app2/courses.dart';
import 'package:knowledge_sharing_app2/resourcepeople.dart';

// Import the LoginPage, RegisterPage, and AboutUsPage classes
import 'login.dart'; // Assuming the LoginPage code is in login_page.dart
import 'register.dart'; // Assuming the RegisterPage code is in register_page.dart
import 'home.dart';
import 'aboutus.dart'; // Import AboutUsPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academist',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const HomePage(), // Set HomePage as the initial page
    );
  }
}

// Dashboard Page Class
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // Set background color to light gray
      drawer: const SideNavigation(), // Placeholder for Side Navigation
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('ACADEMIST...'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: TextField(
                  style: const TextStyle(color: Color.fromARGB(181, 77, 3, 3)), // Set entered text color to white
                  cursorColor: Colors.brown, // Set cursor color to brown
                  decoration: InputDecoration(
                    hintText: "Search Courses...",
                    hintStyle: const TextStyle(color: Color.fromARGB(255, 248, 243, 243)), // Set placeholder text color to white
                    filled: true,
                    fillColor: Colors.brown[200], // Set background color of the search bar to light brown
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.search, color: Colors.white), // Set icon color to white
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Color.fromARGB(216, 170, 31, 7)), // Set profile icon color to brown
            onPressed: () {
              // Add action for profile button
              print('Profile icon pressed');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Color.fromARGB(204, 170, 5, 5)), // Set settings icon color to brown
            onPressed: () {
              // Add action for settings button
              print('Settings icon pressed');
            },
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: QuickOptionsSection(),
                ),
                SizedBox(width: 8), // Spacing between sections
                Expanded(
                  child: TopCategoriesSection(), // Updated Top Categories Section
                ),
                SizedBox(width: 8), // Spacing between sections
                Expanded(
                  child: PopularTopicsSection(), // Updated Popular Topics Section
                ),
                SizedBox(width: 8), // Spacing between sections
                Expanded(
                  child: ResourcePersonSection(), // Placeholder for Resource Persons
                ),
              ],
            ),
            Spacer(), // This will push the footer to the bottom
            Footer(), // Add footer
          ],
        ),
      ),
    );
  }
}

// Side Navigation Class
class SideNavigation extends StatelessWidget {
  const SideNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.brown,
            ),
            child: Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Color.fromARGB(255, 4, 3, 105)),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Color.fromARGB(255, 4, 3, 105)),
            title: const Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUsPage()), // Navigate to AboutUsPage
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.school,color: Color.fromARGB(255, 4, 3, 105)),
            title: const Text('Courses'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CoursesPage()), // Navigate to CoursesPage
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.people, color: Color.fromARGB(255, 4, 3, 105)),
            title: const Text('Resource People'),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ResourcePeoplePage()), // Navigate to ResourcePage
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail, color: Color.fromARGB(255, 4, 3, 105)),
            title: const Text('Contact Us'),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUsPage()), // Navigate to CntactUsPage
              );
            },
          ),
        ],
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
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Please Login or Register',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  const Color.fromARGB(255, 131, 8, 8),
                  ),
                  child: const Text('Login', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.brown),
                    backgroundColor:  const Color.fromARGB(255, 131, 8, 8),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Register', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Top Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
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
      }, // Button text color set to blue
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 194, 188, 185), // Set button color to gray
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(title, style: const TextStyle(color: Color.fromARGB(255, 7, 2, 31))),
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Popular Topics', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              TopicButton(title: 'HTML'),
              TopicButton(title: 'CSS'),
              TopicButton(title: 'JavaScript'),
              TopicButton(title: 'React'),
              TopicButton(title: 'Flutter'),
              TopicButton(title: 'Dart'),
              TopicButton(title: 'NodeJS'),
              TopicButton(title: 'Python'),
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
      }, // Button text color set to white
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 194, 188, 185),  // Set button color to brown
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(title, style: const TextStyle(color: Color.fromARGB(255, 7, 2, 31))),
    );
  }
}

// Placeholder for Resource Persons Section
class ResourcePersonSection extends StatelessWidget {
  const ResourcePersonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Set section background color to light gray
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Centering title
        children: [
          const Text(
            'Become A Resource Person',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center, // Centering the text
          ),
          const SizedBox(height: 10),
          const Text(
            'Join us and inspire the next generation of software engineers! Become a part of our growing community '
            'of experts dedicated to sharing knowledge and shaping future tech leaders. Let’s work together to bridge '
            'the gap between theory and practice, empowering learners to achieve their career goals. Start making an impact today!',
            textAlign: TextAlign.center, // Centering the content text
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Add action for becoming a resource person button
              print('Become a Resource Person button pressed');
            }, // Button text color set to white
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(248, 15, 1, 48), // Set button color to brown
            ),
            child: const Text('Get Started', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}



// Footer (remains unchanged)
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color.fromARGB(255, 78, 4, 4),
      child: const Center(
        child: Text(
          '© 2024 Academist. All rights reserved.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

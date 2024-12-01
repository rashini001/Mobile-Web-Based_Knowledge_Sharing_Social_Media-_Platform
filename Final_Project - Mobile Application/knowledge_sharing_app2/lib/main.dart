import 'package:flutter/material.dart';
import 'package:knowledge_sharing_app2/chat.dart';
import 'package:knowledge_sharing_app2/contactus.dart';
import 'package:knowledge_sharing_app2/courses.dart';
import 'package:knowledge_sharing_app2/quize.dart';
import 'package:knowledge_sharing_app2/resourcepeople.dart';
import 'package:knowledge_sharing_app2/resregister.dart';
import 'login.dart'; // Assuming the LoginPage code is in login_page.dart
import 'register.dart'; // Assuming the RegisterPage code is in register_page.dart
import 'home.dart';
import 'aboutus.dart'; // Import AboutUsPage

void main() {
  runApp(MyApp());
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
      home: HomePage(), // Set HomePage as the initial page
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: SideNavigation(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              'ACADEMIST...',
              style: TextStyle(
                color: Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 550,
              child: TextField(
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "search courses...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                     iconSize: 30, // Set a larger size for the icon
                     icon: const Icon(Icons.account_circle, color: Colors.black),
                     onPressed: () {
                     print('Profile icon pressed');
                },
             ),
             

                IconButton(
                   iconSize: 30,
                  icon: const Icon(Icons.settings, color: Colors.black),
                  onPressed: () {
                    print('Settings icon pressed');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: QuickOptionsSection(),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TopCategoriesSection(),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PopularTopicsSection(),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ResourcePersonSection(),
                ),
              ],
            ),
            const Spacer(),
            Footer(),
          ],
        ),
      ),
    );
  }
}


class SideNavigation extends StatelessWidget {
  const SideNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          Container(
            color: Colors.white, // Background color for the header
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'please login or register',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[900],
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Register Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[900],
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Navigation Items
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
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.school, color: Color.fromARGB(255, 4, 3, 105)),
            title: const Text('Courses'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CoursesPage()),
              );
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.people, color: Color.fromARGB(255, 4, 3, 105)),
            title: const Text('Resource People'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResourcePeoplePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.quiz, color: Color.fromARGB(255, 4, 3, 105)),
            title: const Text('Quiz'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat, color: Color.fromARGB(255, 4, 3, 105)),
            title: const Text('Chat'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail, color: Color.fromARGB(255, 4, 3, 105)),
            title: const Text('Contact Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUsPage()),
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
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  const Color.fromARGB(255, 131, 8, 8),
                  ),
                  child: Text('Login', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.brown),
                    backgroundColor:  const Color.fromARGB(255, 131, 8, 8),
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Register', style: TextStyle(color: Colors.white)),
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
      }, // Button text color set to blue
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 194, 188, 185), // Set button color to gray
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
      child: Text(title, style: TextStyle(color: Color.fromARGB(255, 7, 2, 31))),
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
    // Navigate to the ResRegisterPage when the button is pressed
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResRegisterPage()),
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(248, 15, 1, 48), // Set button color
  ),
  child: Text('Get Started', style: TextStyle(color: Colors.white)),
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

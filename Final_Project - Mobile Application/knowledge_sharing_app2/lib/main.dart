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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

// Dashboard Page Class
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // Set background color to light gray
      drawer: SideNavigation(), // Placeholder for Side Navigation
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ACADEMIST...'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: TextField(
                  style: TextStyle(color: Color.fromARGB(181, 77, 3, 3)), // Set entered text color to white
                  cursorColor: Colors.brown, // Set cursor color to brown
                  decoration: InputDecoration(
                    hintText: "Search Courses...",
                    hintStyle: TextStyle(color: Color.fromARGB(255, 248, 243, 243)), // Set placeholder text color to white
                    filled: true,
                    fillColor: Colors.brown[200], // Set background color of the search bar to light brown
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Icon(Icons.search, color: Colors.white), // Set icon color to white
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Color.fromARGB(216, 170, 31, 7)), // Set profile icon color to brown
            onPressed: () {
              // Add action for profile button
              print('Profile icon pressed');
            },
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Color.fromARGB(204, 170, 5, 5)), // Set settings icon color to brown
            onPressed: () {
              // Add action for settings button
              print('Settings icon pressed');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
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
            leading: Icon(Icons.dashboard, color: Color.fromARGB(255, 4, 3, 105)),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: Color.fromARGB(255, 4, 3, 105)),
            title: Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()), // Navigate to AboutUsPage
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.school,color: Color.fromARGB(255, 4, 3, 105)),
            title: Text('Courses'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CoursesPage()), // Navigate to CoursesPage
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.people, color: Color.fromARGB(255, 4, 3, 105)),
            title: Text('Resource People'),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResourcePeoplePage()), // Navigate to ResourcePage
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail, color: Color.fromARGB(255, 4, 3, 105)),
            title: Text('Contact Us'),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Please Login or Register',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
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
                  child: Text('Login', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color.fromARGB(255, 131, 8, 8),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text('Register', style: TextStyle(color: Colors.white)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.brown),
                    backgroundColor:  Color.fromARGB(255, 131, 8, 8),
                    foregroundColor: Colors.white,
                  ),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
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

  CategoryButton({required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Placeholder for navigation action
        print('$title button pressed');
      },
      child: Text(title, style: TextStyle(color: Color.fromARGB(255, 7, 2, 31))), // Button text color set to blue
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 194, 188, 185), // Set button color to gray
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// Updated Popular Topics Section with buttons
class PopularTopicsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
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

  TopicButton({required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Placeholder for navigation action
        print('$title button pressed');
      },
      child: Text(title, style: TextStyle(color: Color.fromARGB(255, 7, 2, 31))), // Button text color set to white
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 194, 188, 185),  // Set button color to brown
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// Placeholder for Resource Persons Section
class ResourcePersonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Set section background color to light gray
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Centering title
        children: [
          Text(
            'Become A Resource Person',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center, // Centering the text
          ),
          SizedBox(height: 10),
          Text(
            'Join us and inspire the next generation of software engineers! Become a part of our growing community '
            'of experts dedicated to sharing knowledge and shaping future tech leaders. Let’s work together to bridge '
            'the gap between theory and practice, empowering learners to achieve their career goals. Start making an impact today!',
            textAlign: TextAlign.center, // Centering the content text
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Add action for becoming a resource person button
              print('Become a Resource Person button pressed');
            },
            child: Text('Get Started', style: TextStyle(color: Colors.white)), // Button text color set to white
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(248, 15, 1, 48), // Set button color to brown
            ),
          ),
        ],
      ),
    );
  }
}



// Footer (remains unchanged)
class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Color.fromARGB(255, 78, 4, 4),
      child: Center(
        child: Text(
          '© 2024 Academist. All rights reserved.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

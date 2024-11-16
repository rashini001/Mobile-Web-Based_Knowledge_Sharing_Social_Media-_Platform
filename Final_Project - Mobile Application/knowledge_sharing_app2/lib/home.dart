import 'package:flutter/material.dart';
import 'register.dart'; // Import the Register Page
import 'aboutus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey discoverKey = GlobalKey();
  final GlobalKey careerKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();
  final GlobalKey joinKey = GlobalKey();

  bool isSearching = false;
  bool isAboutUsSelected = false;

  void scrollToSection(GlobalKey key, BuildContext context, bool isAboutUs) {
    setState(() {
      isAboutUsSelected = isAboutUs;
    });
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/blog-6.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Container(
                color: isAboutUsSelected ? Colors.black : Colors.brown[900]?.withOpacity(0.7),
                
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: isSearching
                    ? Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                isSearching = false;
                              });
                            },
                          ),
                          
                          Expanded(
                            child: TextField(
                              autofocus: true,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle: TextStyle(color: Colors.white54),
                                border: InputBorder.none,
                              ),
                              onSubmitted: (value) {
                                setState(() {
                                  isSearching = false;
                                });
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.search, color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ACADEMIST...',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              NavButton(text: 'Home', onTap: () => scrollToSection(homeKey, context, false)),
                              NavButton(text: 'About Us', onTap: () => scrollToSection(aboutKey, context, true)),
                              NavButton(text: 'Discover', onTap: () => scrollToSection(discoverKey, context, false)),
                              NavButton(text: 'Career', onTap: () => scrollToSection(careerKey, context, false)),
                              NavButton(text: 'Contact Us', onTap: () => scrollToSection(contactKey, context, false)),
             // Updated Join Us button
                      NavButton(
                        text: 'Join Us',
                        onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()), // Navigate to RegisterPage
                               );
                          },
                      ),
                              IconButton(
                                icon: Icon(Icons.search, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    isSearching = true;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      
              ),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        key: homeKey,
                        height: MediaQuery.of(context).size.height,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 150.0),
                                child: Text(
                                  "Empowering Tomorrow's\nSoftware Engineers",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Transforming Education with Social Learning and Smart Career Guidance',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: const Color.fromARGB(193, 255, 255, 255),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              SignInButton(onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegisterPage()),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      // About Us Section with Gray Box Under Description
                      SectionContainer(
                        key: aboutKey,
                        text: 'About Us',
                        color: Colors.black,
                        image: 'assets/about.jpg',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start, // Adjusted alignment to start
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0), // Move text up a bit
                              child: Text(
                                '" Empowering Learning,\n  Connecting Minds "',
                                style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0), // Adjusted the top padding
                              child: Text(
                                "We are a vibrant knowledge-sharing platform where students and experts come together to learn, grow, and innovate. Our mission is to bridge the gap between education and real-world experience, fostering a collaborative community that encourages lifelong learning.whether you're here to share your expertise or expand your skills,our platform offers the tools and connections you need to succeed in the over-evolving world of software engineering.",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                                textAlign: TextAlign.justify, // Justify the paragraph
                              ),
                            ),
                            SizedBox(height: 20),
                            // Gray Box for Statistics
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 20.0),
                                      color: Colors.grey[800],
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "+25k",
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "Brilliant Students",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "+5k",
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "Expert Resource People",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "100%",
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "Satisfaction",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                            SizedBox(height: 20),
                            SignInButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                                );
                              },
                              text: 'Read More',
                            ),
                          ],
                        ),
                      ),
 SectionContainer(
  key: discoverKey,
  text: 'Discover the different modules',
  color: const Color.fromARGB(255, 0, 0, 0),
  child: SingleChildScrollView(
    child: Column(
      children: [
        Text(
          "Discover the Different Modules",
          style: TextStyle(fontSize: 38, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        Text(
          "Achieve More with Seamless Learning and Expert Guidance in One Platform...",
          style: TextStyle(fontSize: 18, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DiscoverCard(
              title: "Machine Learning",
              description: "Machine learning allows computers to learn from data and make decisions with minimal programming. It's the technology behind recommendations, smart assistants, and more, transforming data into intelligent insights.",
              image: 'assets/discover-1.jpg',
            ),
            DiscoverCard(
              title: "Statistics",
              description: "Statistics involves gathering and analyzing data to find patterns and make predictions. It's essential for making informed decisions in areas like healthcare, economics, and research.",
              image: 'assets/discover-2.jpg',
            ),
            DiscoverCard(
              title: "Electronics",
              description: "Electronics is the study of electron flow in devices, forming the backbone of modern gadgets. From phones to medical devices, electronics power innovation across industries.",
              image: 'assets/discover-3.jpg',
            ),
          ],
        ),
        SizedBox(height: 50),


        //Latest Module
        Text(
          'Our Latest Modules',
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30), // Space between the title and Discover More button
        Text(
          'Bridge the Gap Between Theory and Practice with Our Interactive Learning Platform...',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ModuleCard(
              imageAsset: 'assets/blog-1.jpg',
              description: '10 Common Mistakes Every Beginner Programmer Makes and How to Avoid Them!',
            ),
            ModuleCard(
              imageAsset: 'assets/blog-2.jpg',
              description: 'What’s It Really Like to Transition into Data Science Without a Math Background?',
            ),
            ModuleCard(
              imageAsset: 'assets/blog-3.jpg',
              description: 'Exploring the Impact of IoT on Everyday Life | Innovations Around the Globe',
            ),
            ModuleCard(
              imageAsset: 'assets/blog-4.jpg',
              description: '11 Key Things to Know Before Starting a Career in Cybersecurity...',
            ),
          ],
        ),
        SizedBox(height: 100), // Add spacing at the bottom for a long page feel
      ],
    ),
  ),
),


 SectionContainer(
          key: careerKey,
          text: 'Career',
          color: const Color.fromARGB(255, 0, 0, 0),
          child: Column(
           mainAxisAlignment: MainAxisAlignment.start, // Align content to the top,
            children: [
              Text(
                "Predict Your Future Career",
                style: TextStyle(fontSize: 38, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Your Personalized Learning Experience, Now Smarter with AI and Predictive Analytics...",
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              
              Container(
                    width: 350,
                    child: Column(
                      children: [
                        Container(
                          width: 350,
                          height: 250,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/blog-5.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
           
                        ),
                        SizedBox(height: 5),
                        Container(
                          padding: EdgeInsets.all(16),
                          color: Colors.grey[800],
                          child: Text(
                            "\"A Beginner's Guide to Mapping Your Career Path in Software Engineering\"",
                            style: TextStyle(color: Color.fromARGB(172, 250, 249, 255), fontSize: 16 , fontWeight: FontWeight.bold) ,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Action for predicting career path
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor:Color.fromARGB(83, 39, 0, 146), // Change the text color to white
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // No rounded corners (box type)
                  ),
                    ),
                    child: Text(
                      "Predict Career Path ➔",
                      style: TextStyle(fontSize: 16 ,),
                    ),
                  ),
                ],
              ),
            ),
      

SectionContainer(
  key: contactKey,
  text: 'Contact Us',
  color: Colors.black,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        "Contact us",
        style: TextStyle(
          fontSize: 46,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 8),
      Text(
        "We always aim to reply within 24 hours...",
        style: TextStyle(
          fontSize: 20,
          color: Colors.white70,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20), // Reduced height for spacing between text and circles
      Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center alignment
        children: [
          ContactOption(
            icon: Icons.phone,
            title: "Call us",
            subtitle: "0773605287",
            description: "We are online now",
          ),
          SizedBox(width: 80), // Reduced width to minimize distance between circles
          ContactOption(
            icon: Icons.email,
            title: "Send us an enquiry",
            subtitle: "",
            description: "We are online now",
          ),
        ],
      ),
      SizedBox(height: 45), // Spacing between ContactOption and "Academist" title
      Text(
        "ACADEMIST",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 127, 0, 158),
        ),
      ),
      SizedBox(height: 10), // Spacing between "ACADEMIST" title and social icons
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            
            icon: FaIcon(FontAwesomeIcons.facebookF),
            color: Colors.white, // White color for the icon
            onPressed: () {
              // Add your Facebook link or action here
            },
          ),
          SizedBox(width: 20),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.instagram),
            color: Colors.white, // White color for the icon
            onPressed: () {
              // Add your Instagram link or action here
            },
          ),
          SizedBox(width: 20),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.twitter),
            color: Colors.white, // White color for the icon
            onPressed: () {
              // Add your Twitter link or action here
            },
          ),
          SizedBox(width: 20),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.linkedinIn),
            color: Colors.white, // White color for the icon
            onPressed: () {
              // Add your LinkedIn link or action here
            },
          ),
        ],
      ),
       Divider(color: Colors.white38),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Copyright © 2024. All rights reserved.",
                style: TextStyle(color: Colors.white54),
              ),
            ),
    ],
  ),
),

                    ],
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

// ModuleCard Widget with Description on Image
class ModuleCard extends StatelessWidget {
  final String imageAsset;
  final String description; // Added description parameter

  ModuleCard({
    required this.imageAsset,
    required this.description, // Receiving description parameter
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Stack(
            children: [
              // Background image
              Container(
                height: 230,
                width: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageAsset),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // Description overlay
              Positioned(
                bottom: 20,  // Position the description at the bottom of the image
                left: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    description,
                    style: TextStyle(
                      color: Color.fromARGB(221, 252, 248, 248),
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          
        ],
      ),
    );
  }
}

// Section Container Widget with Custom Child
class SectionContainer extends StatelessWidget {
  final GlobalKey key;
  final String text;
  final Color color;
  final String? image;
  final Color? textColor;
  final Widget? child;

  SectionContainer({
    required this.key,
    required this.text,
    required this.color,
    this.image,
    this.textColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      height: MediaQuery.of(context).size.height,
      color: color,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: child ?? Center(child: Text(text, style: TextStyle(fontSize: 36, color: textColor ?? Colors.white))),
            ),
          ),
          if (image != null)
            Expanded(
              flex: 3,
              child: Image.asset(
                image!,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.6,
              ),
            ),
        ],
      ),
    );
  }
}

// Contact Option Widget (Circular Button)
class ContactOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;

  ContactOption({required this.icon, required this.title, required this.subtitle, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundColor: Colors.white12,
          child: Icon(icon, color: Colors.white, size: 100),
          
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          subtitle,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        Text(
          description,
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ],
    );
  }
}



// Discover Card Widget for Discover Section
class DiscoverCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  DiscoverCard({required this.title, required this.description, required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(image, height: 200),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 35, 27, 112)),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16), // Space between description and button
              ElevatedButton(
                onPressed: () {
                  // Action for the button, you can customize it later
                },
               style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, // Black background
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Button padding
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // Box shape (no rounded corners)
             ),
              side: BorderSide(color: Colors.white, width: 2), // Optional: white border for contrast
           ),
                 child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Discover More',
        style: TextStyle(color: Colors.white),
      ),
      SizedBox(width: 8), // Space between text and icon
      Icon(
        Icons.arrow_forward_ios, // Arrow icon
        color: Colors.white,
        size: 16, // Adjust the size of the arrow as needed
      ),
    ],
 
),
                
              ),
              
           ],
          ),
        ),
      ),
    );
  }
}

// Navigation Button Widget
class NavButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  NavButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      
    );
  }
}



// Sign In Button Widget with Custom Text
class SignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  SignInButton({required this.onPressed, this.text = 'Sign In'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        width: 130,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 35, 6, 131),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 19),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: TextStyle(color: Colors.white)),
              Icon(Icons.arrow_forward, color: Colors.white),
            ],
          ),
          
        ),
      ),
    );
    
  }
}



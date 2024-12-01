import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 38, 27, 102), // Dark purple background color
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      backgroundColor: const Color(0xFFE0ECF8), // Light blue background color
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center alignment for the column
            children: [
              // Centered Text Section
              Center(
                child: Column(
                  children: [
                    const Text(
                      'Test Your Knowledge with Quizzes....',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your knowledge can be tested to learn new skills and enhance discipline in various domains.',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                      textAlign: TextAlign.center, // Ensure text is centered
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Search Bar Section
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Categories Section
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCategoryCard(Icons.html, 'HTML', Colors.orange),
                  _buildCategoryCard(Icons.javascript, 'JAVASCRIPT', Colors.yellow),
                  _buildCategoryCard(Icons.developer_mode, 'REACT', Colors.blue),
                  _buildCategoryCard(Icons.code, 'C++', Colors.indigo),
                  _buildCategoryCard(Icons.code, 'PYTHON', Colors.green),
                ],
              ),
              const SizedBox(height: 16),

              // Recent Activity Section
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  _buildRecentActivityCard('HTML', '30 Questions', 26, 30, Colors.orange),
                  _buildRecentActivityCard('JAVASCRIPT', '30 Questions', 20, 30, Colors.yellow),
                  _buildRecentActivityCard('REACT', '30 Questions', 25, 30, Colors.blue),
                  _buildRecentActivityCard('C++', '30 Questions', 27, 30, Colors.indigo),
                  _buildRecentActivityCard('PYTHON', '30 Questions', 22, 30, Colors.green),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(IconData icon, String title, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildRecentActivityCard(
      String title, String subtitle, int completed, int total, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          CircleAvatar(
            radius: 25,
            backgroundColor: color.withOpacity(0.2),
            child: Text(
              '$completed/$total',
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

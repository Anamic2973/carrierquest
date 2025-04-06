import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tetsing/auth/loginn.dart';
import 'package:tetsing/mbti_result.dart';
import 'package:tetsing/mbtitest.dart';
import 'package:tetsing/resumebuilder.dart';
import 'package:tetsing/widget/geminiai.dart';
import 'package:tetsing/widget/profile.dart';
import 'package:tetsing/widget/questionscreen.dart';
import 'q1.dart'; // Import the new question pages
import 'q2.dart'; // Import QuestionPage2
import 'q3.dart'; // Import QuestionPage3
// Import the LoginPage

class CareerQuestApp extends StatefulWidget {
  CareerQuestApp({super.key});

  @override
  State<CareerQuestApp> createState() => _CareerQuestAppState();
}

class _CareerQuestAppState extends State<CareerQuestApp> {
  bool _isDarkMode = false;

  // Toggle the dark mode setting
  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primaryColor: Colors.green, // Customize primary color if needed
              textTheme:
                  GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme)
                      .apply(
                bodyColor: Colors.white, // Ensure text is white in dark mode
              ),
            )
          : ThemeData.light().copyWith(
              primaryColor: Colors.blue, // Customize primary color if needed
              textTheme:
                  GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme)
                      .apply(
                bodyColor: Colors.black, // Ensure text is black in light mode
              ),
            ),
      home: Scaffold(
        backgroundColor: _isDarkMode ? Colors.black : Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Profile image
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/profileman.webp'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Logo and text
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/CareerQuest.png',
                          height: 80,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GenerativeAISample(),
                              ),
                            );
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                )
                              ],
                              borderRadius: BorderRadius.circular(50),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/ai.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Tagline
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Intrest Not Known',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 0),
              // Cards
              _buildCard(
                context: context,
                title: 'Uncover Your Carrier?',
                description:
                    'Take our quick assessment to get\npersonalized recommendations.',
                color: Colors.blue,
                imagePath: 'assets/images/p1.png',
                isImageLeft: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 250),
                child: Text(
                  'Personality Test',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              _buildCard(
                context: context,
                title: 'Mbti test',
                description:
                    'Our comprehensive assessment will help you uncover your hidden passions.',
                color: Colors.orange,
                imagePath: 'assets/images/p2.png',
                isImageLeft: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MBTIQuestionScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'skill development',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              _buildCard(
                context: context,
                title: 'Ready to level up?',
                description:
                    'Take our capability assessment to find your next steps.',
                color: Colors.green,
                imagePath: 'assets/images/p3.png',
                isImageLeft: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SkillAssessmentScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 250),
                child: Text(
                  'Resume builder',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              _buildCard(
                context: context,
                title: 'Build Resume',
                description:
                    'Our comprehensive assessment will help you uncover your hidden passions.',
                color: Colors.cyan,
                imagePath: 'assets/images/p2.png',
                isImageLeft: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResumeBuilderApp(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }

  Widget _buildCard({
    required BuildContext context,
    required String title,
    required String description,
    required Color color,
    required String imagePath,
    required bool isImageLeft,
    required VoidCallback onPressed,
  }) {
    final titleParts = title.split(' ');
    final highlightedWord = titleParts.last;
    final regularTitle = titleParts.take(titleParts.length - 1).join(' ');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 190,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: isImageLeft ? 120 : 20,
              right: isImageLeft ? 20 : 100,
              top: 20,
            ),
            child: Column(
              crossAxisAlignment: isImageLeft
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: isImageLeft ? TextAlign.right : TextAlign.left,
                  text: TextSpan(
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(text: '$regularTitle '),
                      TextSpan(
                        text: highlightedWord,
                        style: const TextStyle(
                          color: Color(0xFFFFF176),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: isImageLeft ? TextAlign.right : TextAlign.left,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: isImageLeft
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    child: Text(
                      ' TAKE - A - STEP 〉',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: isImageLeft ? null : 0, // Reduced the right margin
            left: isImageLeft ? -20 : null, // Reduced the left margin
            top: -20, // Adjusted the top margin to bring the image closer
            child: Image.asset(
              imagePath,
              height: 160, // Reduced the height of the image
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.info_rounded,
                    color: Colors.white, size: 28),
                onPressed: () {
                  _showInfo(context);
                },
              ),
              const SizedBox(width: 60),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white, size: 28),
                onPressed: () {
                  _showSettings(context);
                },
              ),
            ],
          ),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.home, color: Colors.white, size: 32),
          ),
        ],
      ),
    );
  }

  // Show settings bottom sheet with dark mode toggle and logout button
  void _showSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Settings',
              style: GoogleFonts.nunito(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              title: Text(
                'Dark Mode',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              trailing: Switch(
                value: _isDarkMode,
                onChanged: _toggleDarkMode,
                activeColor: Colors.green,
              ),
            ),
            const SizedBox(height: 30),
            // Logout button
            ElevatedButton(
              onPressed: () {
                // Remove all previous screens and push the LoginPage as the root
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) =>
                      false, // This ensures that all previous routes are removed
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red color for logout
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: Text(
                'Logout',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show information bottom sheet
  void _showInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/CareerQuest.png',
              height: 120,
            ),
            const SizedBox(height: 20),
            Text(
              'Welcome to CareerQuest!',
              style: GoogleFonts.nunito(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'CareerQuest is your personal guide to discovering your ideal career path. '
              'Our assessments help you identify your passions, interests, and skills, '
              'so you can make informed career decisions that align with your goals.',
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: Colors.black54,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              'Contributors:',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Sarthak Sulakhe, Utkarsha Todkar, Sanskruti Sokande',
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Guide: Rahane Sir',
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: Text(
                'Close',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

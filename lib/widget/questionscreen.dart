// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tetsing/recommendation_screen.dart';

// class Question {
//   final String text;
//   final List<String> tags;
//   final String imagePath;

//   Question({
//     required this.text,
//     required this.tags,
//     required this.imagePath,
//   });
// }

// /// List of questions with example associated tags.
// /// (You can adjust the tags to match your specific recommendation logic.)
// final List<Question> questions = [
//   // Existing questions
//   Question(
//     text: "Do you enjoy working with data and analyzing information?",
//     tags: ['Investigative', 'Statistics', 'Data Analysis', 'Python', 'SQL'],
//     imagePath: 'assets/images/q1.png',
//   ),
//   Question(
//     text: "Are you interested in building or designing things?",
//     tags: ['Realistic', 'Design', 'Architecture', 'Engineering'],
//     imagePath: 'assets/images/q2.png',
//   ),
//   Question(
//     text: "Do you like solving complex problems or puzzles?",
//     tags: ['Problem-Solving', 'Analytical', 'Critical Thinking'],
//     imagePath: 'assets/images/q3.png',
//   ),

//   // New questions
//   Question(
//     text:
//         "Are you passionate about artificial intelligence and machine learning?",
//     tags: ['AI Algorithms', 'Machine Learning', 'Deep Learning', 'TensorFlow'],
//     imagePath: 'assets/images/q4.png',
//   ),
//   Question(
//     text: "Do you enjoy protecting systems from cyber threats?",
//     tags: [
//       'Cybersecurity',
//       'Network Security',
//       'Ethical Hacking',
//       'Risk Management'
//     ],
//     imagePath: 'assets/images/q5.png',
//   ),
//   Question(
//     text: "Are you interested in medical surgery and patient care?",
//     tags: ['Neurosurgery', 'Patient Care', 'Healthcare', 'Medical'],
//     imagePath: 'assets/images/q6.png',
//   ),
//   Question(
//     text: "Do you want to work in criminal investigations?",
//     tags: ['Forensic', 'Criminal Investigation', 'DNA Analysis', 'Chemistry'],
//     imagePath: 'assets/images/q7.png',
//   ),
//   Question(
//     text: "Are you fascinated by space exploration?",
//     tags: [
//       'Space Science',
//       'Astronomy',
//       'Celestial Objects',
//       'Planetary Science'
//     ],
//     imagePath: 'assets/images/q8.png',
//   ),
//   Question(
//     text: "Do you enjoy creating video games?",
//     tags: ['Game Development', 'Programming', 'Creative', 'Problem-Solving'],
//     imagePath: 'assets/images/q9.png',
//   ),
//   Question(
//     text: "Are you interested in predicting weather patterns?",
//     tags: [
//       'Meteorology',
//       'Weather Prediction',
//       'Data Analysis',
//       'General Analytical'
//     ],
//     imagePath: 'assets/images/q10.png',
//   ),
//   Question(
//     text: "Do you want to design sustainable energy solutions?",
//     tags: [
//       'Renewable Energy',
//       'Sustainability',
//       'Engineering',
//       'Environmental'
//     ],
//     imagePath: 'assets/images/q11.png',
//   ),
//   Question(
//     text: "Are you interested in mental performance optimization?",
//     tags: [
//       'Sports Psychology',
//       'Mental Health',
//       'Performance Enhancement',
//       'Communication'
//     ],
//     imagePath: 'tetsing/assets/images/q1.png',
//   ),
//   Question(
//     text: "Do you care about ethical technology development?",
//     tags: [
//       'AI Ethics',
//       'Responsible AI',
//       'Ethical Decision Making',
//       'Critical Thinking'
//     ],
//     imagePath: 'assets/images/q13.png',
//   ),
//   Question(
//     text: "Are you interested in biotechnology research?",
//     tags: ['Biotech', 'Medical Research', 'Lab Skills', 'Chemistry'],
//     imagePath: 'assets/images/q14.png',
//   ),
//   Question(
//     text: "Do you enjoy composing music?",
//     tags: ['Music Composition', 'Artistic', 'Creative', 'Sound Design'],
//     imagePath: 'assets/images/q15.png',
//   ),
//   Question(
//     text: "Are you interested in financial markets?",
//     tags: [
//       'Investment Banking',
//       'Finance',
//       'Risk Management',
//       'Strategic Planning'
//     ],
//     imagePath: 'assets/images/q16.png',
//   ),
//   Question(
//     text: "Do you want to study marine ecosystems?",
//     tags: ['Marine Biology', 'Ecology', 'Environmental Science', 'Research'],
//     imagePath: 'assets/images/q17.png',
//   ),
//   Question(
//     text: "Are you interested in user experience design?",
//     tags: [
//       'UX Research',
//       'User-Centered Design',
//       'Psychology',
//       'Communication'
//     ],
//     imagePath: 'assets/images/q18.png',
//   ),
//   Question(
//     text: "Do you want to build robotic systems?",
//     tags: ['Robotics', 'Engineering', 'AI Algorithms', 'Problem-Solving'],
//     imagePath: 'assets/images/q19.png',
//   ),
//   Question(
//     text: "Are you interested in disease prevention?",
//     tags: ['Epidemiology', 'Public Health', 'Data Analysis', 'Research'],
//     imagePath: 'assets/images/q20.png',
//   ),
//   Question(
//     text: "Do you enjoy urban planning?",
//     tags: [
//       'Architecture',
//       'Urban Design',
//       'Civil Engineering',
//       'Sustainability'
//     ],
//     imagePath: 'assets/images/q21.png',
//   ),
//   Question(
//     text: "Are you interested in psychological research?",
//     tags: [
//       'Psychology',
//       'Behavioral Analysis',
//       'Research Methods',
//       'Critical Thinking'
//     ],
//     imagePath: 'assets/images/q22.png',
//   ),
//   Question(
//     text: "Do you want to work with advanced AI systems?",
//     tags: ['Machine Learning', 'Deep Learning', 'AI Algorithms', 'Python'],
//     imagePath: 'assets/images/q23.png',
//   ),
//   Question(
//     text: "Are you interested in DNA analysis?",
//     tags: ['Genetics', 'DNA Sequencing', 'Forensic Science', 'Chemistry'],
//     imagePath: 'assets/images/q24.png',
//   ),
//   Question(
//     text: "Do you enjoy optimizing systems efficiency?",
//     tags: [
//       'Process Optimization',
//       'Analytical Skills',
//       'Problem-Solving',
//       'Engineering'
//     ],
//     imagePath: 'assets/images/q25.png',
//   ),
// ];

// /// A stateful widget that displays one question at a time.
// class QuestionScreen extends StatefulWidget {
//   @override
//   _QuestionScreenState createState() => _QuestionScreenState();
// }

// class _QuestionScreenState extends State<QuestionScreen> {
//   int _currentQuestionIndex = 0;
//   List<String> _selectedQuestions = [];

//   /// Called when the user answers a question.
//   void _onAnswer(bool answer) {
//     // If the user answers "Yes", record the question text.
//     if (answer) {
//       _selectedQuestions.add(questions[_currentQuestionIndex].text);
//     }

//     // Move to the next question if available.
//     setState(() {
//       if (_currentQuestionIndex < questions.length - 1) {
//         _currentQuestionIndex++;
//       } else {
//         // All questions have been answered.
//         // Navigate to the Recommendation Screen and pass the selected questions.
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => RecommendationScreen(
//               selectedQuestions: _selectedQuestions,
//             ),
//           ),
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentQuestion = questions[_currentQuestionIndex];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CareerQuest'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Display the question text.
//             Text(
//               currentQuestion.text,
//               style: TextStyle(fontSize: 24),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 40),
//             // "Yes" button.
//             ElevatedButton(
//               onPressed: () => _onAnswer(true),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor:
//                     const Color.fromARGB(255, 100, 209, 103), // Button color
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(
//                       15), // Rectangular button (no rounding)
//                 ),
//               ),
//               child: Text(
//                 'Yes ',
//                 style: GoogleFonts.nunito(
//                   fontSize: 20,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             // "No" button.
//             ElevatedButton(
//               onPressed: () => _onAnswer(false),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red, // Button color
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(
//                       15), // Rectangular button (no rounding)
//                 ),
//               ),
//               child: Text(
//                 'No',
//                 style: GoogleFonts.nunito(
//                   fontSize: 20,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ),
//             SizedBox(height: 40),
//             // Optional: Display question progress.
//             Text(
//               'Question ${_currentQuestionIndex + 1} of ${questions.length}',
//               style: TextStyle(fontSize: 16, color: Colors.black54),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tetsing/recommendation_screen.dart';

class Question {
  final String text;
  final List<String> tags;
  final String imagePath;

  Question({
    required this.text,
    required this.tags,
    required this.imagePath,
  });
}

/// List of questions with example associated tags.
/// (You can adjust the tags to match your specific recommendation logic.)
final List<Question> questions = [
  // Existing questions
  Question(
    text: "Do you enjoy working with data and analyzing information?",
    tags: ['Investigative', 'Statistics', 'Data Analysis', 'Python', 'SQL'],
    imagePath: 'assets/images/q1.png',
  ),
  Question(
    text: "Are you interested in building or designing things?",
    tags: ['Realistic', 'Design', 'Architecture', 'Engineering'],
    imagePath: 'assets/images/q2.png',
  ),
  Question(
    text: "Do you like solving complex problems or puzzles?",
    tags: ['Problem-Solving', 'Analytical', 'Critical Thinking'],
    imagePath: 'assets/images/q3.png',
  ),
  // New questions
  Question(
    text:
        "Are you passionate about artificial intelligence and machine learning?",
    tags: ['AI Algorithms', 'Machine Learning', 'Deep Learning', 'TensorFlow'],
    imagePath: 'assets/images/q4.png',
  ),
  Question(
    text: "Do you enjoy protecting systems from cyber threats?",
    tags: [
      'Cybersecurity',
      'Network Security',
      'Ethical Hacking',
      'Risk Management'
    ],
    imagePath: 'assets/images/q5.png',
  ),
  Question(
    text: "Are you interested in medical surgery and patient care?",
    tags: ['Neurosurgery', 'Patient Care', 'Healthcare', 'Medical'],
    imagePath: 'assets/images/q6.png',
  ),
  Question(
    text: "Do you want to work in criminal investigations?",
    tags: ['Forensic', 'Criminal Investigation', 'DNA Analysis', 'Chemistry'],
    imagePath: 'assets/images/q7.png',
  ),
  Question(
    text: "Are you fascinated by space exploration?",
    tags: [
      'Space Science',
      'Astronomy',
      'Celestial Objects',
      'Planetary Science'
    ],
    imagePath: 'assets/images/q8.png',
  ),
  Question(
    text: "Do you enjoy creating video games?",
    tags: ['Game Development', 'Programming', 'Creative', 'Problem-Solving'],
    imagePath: 'assets/images/q9.png',
  ),
  Question(
    text: "Are you interested in predicting weather patterns?",
    tags: [
      'Meteorology',
      'Weather Prediction',
      'Data Analysis',
      'General Analytical'
    ],
    imagePath: 'assets/images/q10.png',
  ),
  Question(
    text: "Do you want to design sustainable energy solutions?",
    tags: [
      'Renewable Energy',
      'Sustainability',
      'Engineering',
      'Environmental'
    ],
    imagePath: 'assets/images/q11.png',
  ),
  Question(
    text: "Are you interested in mental performance optimization?",
    tags: [
      'Sports Psychology',
      'Mental Health',
      'Performance Enhancement',
      'Communication'
    ],
    imagePath: 'assets/images/q12.png',
  ),
  Question(
    text: "Do you care about ethical technology development?",
    tags: [
      'AI Ethics',
      'Responsible AI',
      'Ethical Decision Making',
      'Critical Thinking'
    ],
    imagePath: 'assets/images/q13.png',
  ),
  Question(
    text: "Are you interested in biotechnology research?",
    tags: ['Biotech', 'Medical Research', 'Lab Skills', 'Chemistry'],
    imagePath: 'assets/images/q14.png',
  ),
  Question(
    text: "Do you enjoy composing music?",
    tags: ['Music Composition', 'Artistic', 'Creative', 'Sound Design'],
    imagePath: 'assets/images/q15.png',
  ),
  Question(
    text: "Are you interested in financial markets?",
    tags: [
      'Investment Banking',
      'Finance',
      'Risk Management',
      'Strategic Planning'
    ],
    imagePath: 'assets/images/q16.png',
  ),
  Question(
    text: "Do you want to study marine ecosystems?",
    tags: ['Marine Biology', 'Ecology', 'Environmental Science', 'Research'],
    imagePath: 'assets/images/q17.png',
  ),
  Question(
    text: "Are you interested in user experience design?",
    tags: [
      'UX Research',
      'User-Centered Design',
      'Psychology',
      'Communication'
    ],
    imagePath: 'assets/images/q18.png',
  ),
  Question(
    text: "Do you want to build robotic systems?",
    tags: ['Robotics', 'Engineering', 'AI Algorithms', 'Problem-Solving'],
    imagePath: 'assets/images/q19.png',
  ),
  Question(
    text: "Are you interested in disease prevention?",
    tags: ['Epidemiology', 'Public Health', 'Data Analysis', 'Research'],
    imagePath: 'assets/images/q20.png',
  ),
  Question(
    text: "Do you enjoy urban planning?",
    tags: [
      'Architecture',
      'Urban Design',
      'Civil Engineering',
      'Sustainability'
    ],
    imagePath: 'assets/images/q21.png',
  ),
  Question(
    text: "Are you interested in psychological research?",
    tags: [
      'Psychology',
      'Behavioral Analysis',
      'Research Methods',
      'Critical Thinking'
    ],
    imagePath: 'assets/images/q22.png',
  ),
  Question(
    text: "Do you want to work with advanced AI systems?",
    tags: ['Machine Learning', 'Deep Learning', 'AI Algorithms', 'Python'],
    imagePath: 'assets/images/q23.png',
  ),
  Question(
    text: "Are you interested in DNA analysis?",
    tags: ['Genetics', 'DNA Sequencing', 'Forensic Science', 'Chemistry'],
    imagePath: 'assets/images/q24.png',
  ),
  Question(
    text: "Do you enjoy optimizing systems efficiency?",
    tags: [
      'Process Optimization',
      'Analytical Skills',
      'Problem-Solving',
      'Engineering'
    ],
    imagePath: 'assets/images/q25.png',
  ),
];

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _currentQuestionIndex = 0;
  List<String> _selectedQuestions = [];
  double _progress = 0.0;

  /// Called when the user answers a question.
  void _onAnswer(bool answer) {
    if (answer) {
      _selectedQuestions.add(questions[_currentQuestionIndex].text);
    }
    setState(() {
      if (_currentQuestionIndex < questions.length - 1) {
        _currentQuestionIndex++;
        _progress = (_currentQuestionIndex + 1) / questions.length;
      } else {
        // All questions answered: navigate to RecommendationScreen.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecommendationScreen(
              selectedQuestions: _selectedQuestions,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Know Your Career',
          style: GoogleFonts.nunito(
            fontSize: 30,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 20, right: 20, bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize
                      .min, // Let the Column shrink-wrap its children.
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Progress bar.
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: double.infinity,
                        height: 10,
                        child: LinearProgressIndicator(
                          value: _progress,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                              const Color.fromARGB(255, 12, 112, 54)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Display the question text.
                    Container(
                      height: 100,
                      child: Text(
                        currentQuestion.text,
                        style: GoogleFonts.nunito(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Display the question image in a fixed height container.
                    SizedBox(
                      height: 200, // Fixed height for consistency
                      child: Image.asset(
                        currentQuestion.imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Fixed spacing before the buttons.
                    const SizedBox(height: 70),
                    // "Yes" button.
                    Container(
                      width: 300,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () => _onAnswer(true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 100, 209, 103),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Yes',
                          style: GoogleFonts.nunito(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // "No" button.
                    Container(
                      width: 300,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () => _onAnswer(false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'No',
                          style: GoogleFonts.nunito(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Display progress text.
                    Text(
                      'Question ${_currentQuestionIndex + 1} of ${questions.length}',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

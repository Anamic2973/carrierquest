import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tetsing/auth/loginn.dart';

import 'package:flutter/material.dart';
import 'package:tetsing/recommendation_screen.dart';
import 'package:tetsing/widget/questionscreen.dart';
// Import your login screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyDWSq3f-dSDSnUZE-G3ab2GcYyeate_hnY",
    appId: "1:100191556868:ios:c09e09bc2b59e3345a6c51",
    messagingSenderId: "100191556868",
    projectId: "carrierquest-e56e8",
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CareerQuest',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'package:csv/csv.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:tetsing/csv_loader.dart';

// void main() {
//   runApp(const CareerQuizApp());
// }

// class CareerQuizApp extends StatelessWidget {
//   const CareerQuizApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Career Quiz',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const QuizPage(),
//     );
//   }
// }

// // -----------------------------------------------------------------------------
// // Models: CareerMatch and UserInterest
// // -----------------------------------------------------------------------------
// class CareerMatch {
//   final String profession;
//   final String field;
//   final double matchScore;

//   CareerMatch({
//     required this.profession,
//     required this.field,
//     required this.matchScore,
//   });
// }

// class UserInterest {
//   final String question;
//   final String answer; // Expected values: 'Yes' or 'No'

//   UserInterest({required this.question, required this.answer});
// }

// // -----------------------------------------------------------------------------
// // The ML–inspired Career Matcher
// // -----------------------------------------------------------------------------
// class CareerMatcher {
//   /// Mapping from questions to tags.
//   static final Map<String, List<String>> questionMapping = {
//     "Do you enjoy working with data and analyzing information?": [
//       "Investigative",
//       "Statistics",
//       "Data Analysis",
//       "Python",
//       "SQL"
//     ],
//     "Are you interested in building or designing things?": [
//       "Realistic",
//       "Design",
//       "Architecture",
//       "Engineering"
//     ],
//     "Do you like solving complex problems or puzzles?": [
//       "Problem-Solving",
//       "Critical Thinking",
//       "Analytical"
//     ],
//     "Are you passionate about technology and innovation?": [
//       "Enterprising",
//       "AI Algorithms",
//       "Machine Learning",
//       "Deep Learning"
//     ],
//     "Do you enjoy working with people and helping others?": [
//       "Social",
//       "Communication",
//       "Patient Care"
//     ],
//     "Are you interested in science and research?": [
//       "Investigative",
//       "Research",
//       "Biotech",
//       "Chemistry"
//     ],
//     "Do you like working with your hands or in practical, hands-on roles?": [
//       "Realistic",
//       "Practical",
//       "Construction",
//       "Manufacturing"
//     ],
//     "Are you creative and enjoy artistic activities?": [
//       "Artistic",
//       "Music",
//       "Design",
//       "Creative Thinking"
//     ],
//     "Do you prefer working independently rather than in a team?": [
//       "Conventional",
//       "Independent",
//       "Self-Motivated"
//     ],
//     "Are you interested in business and financial strategies?": [
//       "Enterprising",
//       "Finance",
//       "Investment",
//       "Risk Management"
//     ],
//     "Do you enjoy working with computers or programming?": [
//       "Technical",
//       "Python",
//       "AI Algorithms",
//       "Machine Learning"
//     ],
//     "Are you interested in health and medicine?": [
//       "Investigative",
//       "Healthcare",
//       "Patient Care",
//       "Medicine"
//     ],
//     "Do you like working in fast-paced, dynamic environments?": [
//       "Enterprising",
//       "Dynamic",
//       "Leadership"
//     ],
//     "Are you interested in environmental or sustainability issues?": [
//       "Conventional",
//       "Environment",
//       "Sustainability",
//       "Renewable Energy"
//     ],
//     "Do you enjoy teaching or mentoring others?": [
//       "Social",
//       "Communication",
//       "Teaching",
//       "Mentoring"
//     ],
//   };

//   /// Pre-defined weights for tags (simulating learned importance).
//   /// Tags not listed here will be assigned a default weight of 1.0.
//   static final Map<String, double> tagWeights = {
//     "Python": 2.0,
//     "Machine Learning": 2.0,
//     "AI Algorithms": 2.0,
//     "Data Analysis": 1.5,
//     "SQL": 1.5,
//     "Deep Learning": 1.8,
//     "Research": 1.2,
//     "Design": 1.0,
//     "Engineering": 1.0,
//     "Problem-Solving": 1.0,
//     "Critical Thinking": 1.0,
//     "Analytical": 1.0,
//     "Leadership": 1.0,
//     "Communication": 1.0,
//     "Sustainability": 2.0,
//     "Renewable Energy": 2.0,
//   };

//   /// Convert the user’s answers into a set of tags.
//   static Set<String> _getUserTags(List<UserInterest> userInterests) {
//     final Set<String> tags = {};
//     for (final interest in userInterests) {
//       if (interest.answer.toLowerCase() == 'yes') {
//         tags.addAll(questionMapping[interest.question] ?? []);
//       }
//     }
//     return tags;
//   }

//   /// The ML model: Simulate a logistic regression prediction.
//   /// Given a set of user tags and career tags, we compute the weighted sum
//   /// of matching tags and return the sigmoid of that sum as a “match probability.”
//   static double _predictMatchProbability(
//       Set<String> userTags, Set<String> careerTags) {
//     double score = 0.0;
//     // Intersection of tags between user and career.
//     final matchingTags = userTags.intersection(careerTags);
//     for (final tag in matchingTags) {
//       // Use the weight if defined; otherwise, use 1.0.
//       score += tagWeights[tag] ?? 1.0;
//     }
//     // Bias term can be added here if desired.
//     double bias = 0.0;
//     score += bias;
//     // Sigmoid activation to simulate probability (range 0 to 1).
//     double probability = 1 / (1 + exp(-score));
//     return probability;
//   }

//   /// Given a list of career data (from CSV), return the top 3 career matches
//   /// using our ML–inspired prediction model.
//   static List<CareerMatch> matchUserInterests(
//       List<UserInterest> userInterests, List<Map<String, String>> careerData) {
//     final userTags = _getUserTags(userInterests);
//     final List<CareerMatch> matches = [];

//     for (final career in careerData) {
//       final Set<String> careerTags = {};
//       if (career['Type of Interest'] != null) {
//         careerTags.addAll(
//           career['Type of Interest']!
//               .split(', ')
//               .map((e) => e.trim())
//               .where((element) => element.isNotEmpty),
//         );
//       }
//       if (career['Associated Skills'] != null) {
//         careerTags.addAll(
//           career['Associated Skills']!
//               .split(', ')
//               .map((e) => e.trim())
//               .where((element) => element.isNotEmpty),
//         );
//       }

//       double probability = _predictMatchProbability(userTags, careerTags);

//       // Only include careers with some matching probability.
//       if (probability > 0) {
//         matches.add(CareerMatch(
//           profession: career['Profession'] ?? '',
//           field: career['Field'] ?? '',
//           matchScore: probability,
//         ));
//       }
//     }

//     // Sort in descending order of probability.
//     matches.sort((a, b) => b.matchScore.compareTo(a.matchScore));
//     return _removeDuplicates(matches).take(3).toList();
//   }

//   /// Remove duplicate professions (keeps the first occurrence).
//   static List<CareerMatch> _removeDuplicates(List<CareerMatch> matches) {
//     final seen = <String>{};
//     return matches.where((match) => seen.add(match.profession)).toList();
//   }
// }

// // -----------------------------------------------------------------------------
// // CSV Loader: For demonstration we use a simulated CSV string.
// // In your production app you could load from assets using rootBundle.loadString.
// // -----------------------------------------------------------------------------

// // Removed duplicate loadCareerData implementation - using csv_loader.dart version
// // -----------------------------------------------------------------------------
// // The Quiz Page UI
// // -----------------------------------------------------------------------------
// class QuizPage extends StatefulWidget {
//   const QuizPage({Key? key}) : super(key: key);

//   @override
//   State<QuizPage> createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   // Updated questions.
//   final List<String> questions = [
//     "Do you enjoy working with data and analyzing information?",
//     "Are you interested in building or designing things?",
//     "Do you like solving complex problems or puzzles?",
//     "Are you passionate about technology and innovation?",
//     "Do you enjoy working with people and helping others?",
//     "Are you interested in science and research?",
//     "Do you like working with your hands or in practical, hands-on roles?",
//     "Are you creative and enjoy artistic activities?",
//     "Do you prefer working independently rather than in a team?",
//     "Are you interested in business and financial strategies?",
//     "Do you enjoy working with computers or programming?",
//     "Are you interested in health and medicine?",
//     "Do you like working in fast-paced, dynamic environments?",
//     "Are you interested in environmental or sustainability issues?",
//     "Do you enjoy teaching or mentoring others?"
//   ];

//   // Map to hold the user's answers.
//   final Map<String, String> answers = {};

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Career Quiz')),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ...questions.map((question) {
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(question,
//                         style: const TextStyle(
//                             fontSize: 16.0, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               answers[question] = 'Yes';
//                             });
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: answers[question] == 'Yes'
//                                 ? Colors.green
//                                 : null,
//                           ),
//                           child: const Text('Yes'),
//                         ),
//                         const SizedBox(width: 8),
//                         ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               answers[question] = 'No';
//                             });
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor:
//                                 answers[question] == 'No' ? Colors.red : null,
//                           ),
//                           child: const Text('No'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//             ElevatedButton(
//               onPressed: _submitAnswers,
//               child: const Text('Submit'),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _submitAnswers() async {
//     // Convert the answers into a list of UserInterest objects.
//     final List<UserInterest> userInterests = answers.entries
//         .map((entry) => UserInterest(question: entry.key, answer: entry.value))
//         .toList();

//     // Load the career data.
//     final careerData = await loadCareerData();

//     // Get the top 3 career matches using our ML–inspired matcher.
//     final matches = CareerMatcher.matchUserInterests(userInterests, careerData);

//     // Display the results in a dialog.
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Top Career Matches'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: matches
//               .map((match) => ListTile(
//                     title: Text(match.profession),
//                     subtitle: Text(
//                         '${match.field} · Score: ${match.matchScore.toStringAsFixed(2)}'),
//                   ))
//               .toList(),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           )
//         ],
//       ),
//     );
//   }
// }

// lib/main.dart

/// Model class representing a single question with associated tags.
/// 
/// ---------------------=======================+++++++++++++++++========================------------------------------------
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









// from flask import Flask, request, jsonify
// from flask_cors import CORS
// import pandas as pd
// import os
// import logging
// import numpy as np
// from collections import defaultdict

// logging.basicConfig(level=logging.DEBUG)
// logger = logging.getLogger(__name__)

// app = Flask(__name__)
// CORS(app)

// # Global variables
// df = None
// profession_details = {}
// field_weights = {
//     'Technical': 1.2,
//     'Healthcare': 1.2,
//     'Engineering': 1.2,
//     'Science': 1.1,
//     'Business': 1.0,
//     'Creative': 1.0
// }

// def load_data():
//     """Load and process the CSV data"""
//     global df, profession_details
    
//     try:
//         base_dir = os.path.dirname(os.path.abspath(__file__))
//         csv_path = os.path.join(base_dir, "tetsing", "assets", "images", "careerquest_1000_updated.csv")
        
//         logger.debug(f"Loading CSV from: {csv_path}")
//         df = pd.read_csv(csv_path)
//         df.dropna(subset=['Field', 'Profession'], inplace=True)
        
//         # Process each profession and store details
//         for _, row in df.iterrows():
//             profession = f"{row['Field']}, {row['Profession']}"
            
//             # Process skills
//             skills = row.get("Associated Skills", "")
//             if isinstance(skills, str):
//                 skills = [s.strip() for s in skills.split(',') if s.strip()]
//             else:
//                 skills = []
                
//             # Process personality traits
//             personality = row.get("Personality", "")
//             if isinstance(personality, str):
//                 personality = [p.strip() for p in personality.split(',') if p.strip()]
//             else:
//                 personality = []
                
//             # Process interests
//             interests = row.get("Type of Interest", "")
//             if isinstance(interests, str):
//                 interests = [i.strip() for i in interests.split(',') if i.strip()]
//             else:
//                 interests = []
            
//             # Store profession details
//             profession_details[profession] = {
//                 "future_scope_years": str(row.get("Future Growth Potential", "N/A")),
//                 "information": row.get("Job Description", "A professional role in " + row['Field']),
//                 "associated_skills": skills,
//                 "field": row['Field'],
//                 "education_required": row.get("Education Requirement", "Bachelor's degree or equivalent"),
//                 "average_salary": row.get("Average Salary", "Competitive"),
//                 "personality": personality,
//                 "interests": interests,
//                 "keywords": set(skills + personality + interests + [row['Field'], row['Profession']])
//             }
        
//         logger.info(f"Loaded {len(profession_details)} professions")
//         return True
    
//     except Exception as e:
//         logger.error(f"Error loading data: {str(e)}")
//         return False

// def calculate_career_matches(selected_questions):
//     """Calculate career matches based on selected questions using multiple criteria"""
//     try:
//         # Initialize user profile based on selected questions
//         user_profile = {
//             'skills': set(),
//             'interests': set(),
//             'personality_types': set(),
//             'field_preferences': defaultdict(float)
//         }
        
//         # Process selected questions to build user profile
//         for question in selected_questions:
//             tags = question_mapping.get(question, [])
//             for tag in tags:
//                 # Add to skills and interests
//                 user_profile['skills'].add(tag)
//                 user_profile['interests'].add(tag)
                
//                 # Update field preferences
//                 for field, weight in field_weights.items():
//                     if tag in category_mapping.get(field, set()):
//                         user_profile['field_preferences'][field] += weight

//         # Calculate match scores for each profession
//         scores = {}
//         for profession, details in profession_details.items():
//             # 1. Skills Match (25%)
//             skills_match = len(user_profile['skills'] & set(details['associated_skills'])) / \
//                           (len(details['associated_skills']) or 1)
            
//             # 2. Interest Alignment (25%)
//             interest_match = len(user_profile['interests'] & set(details['interests'])) / \
//                            (len(details['interests']) or 1)
            
//             # 3. Field Relevance (25%)
//             field_score = user_profile['field_preferences'].get(details['field'], 0) / \
//                          (max(user_profile['field_preferences'].values()) or 1)
            
//             # 4. Future Prospects (25%)
//             growth_potential = {
//                 'High': 1.0,
//                 'Medium': 0.7,
//                 'Low': 0.4
//             }.get(details['future_scope_years'], 0.5)
            
//             # Calculate weighted final score
//             final_score = (
//                 0.25 * skills_match +
//                 0.25 * interest_match +
//                 0.25 * field_score +
//                 0.25 * growth_potential
//             ) * 100  # Convert to percentage
            
//             scores[profession] = final_score

//         # Get top 3 matches
//         top_matches = sorted(scores.items(), key=lambda x: x[1], reverse=True)[:3]
        
//         # Prepare detailed recommendations
//         recommendations = []
//         for profession, score in top_matches:
//             details = profession_details[profession]
//             recommendations.append({
//                 'profession': profession,
//                 'score': int(score),
//                 'future_scope_years': details['future_scope_years'],
//                 'information': details['information'],
//                 'associated_skills': details['associated_skills'],
//                 'field': details['field'],
//                 'education_required': details['education_required'],
//                 'average_salary': details['average_salary'],
//                 'personality': details['personality'],
//                 'interests': details['interests']
//             })
        
//         return recommendations
//     except Exception as e:
//         logger.error(f"Error calculating matches: {str(e)}")
//         return []

// @app.route('/recommend', methods=['POST'])
// def recommend():
//     """Handle recommendation requests"""
//     global df, profession_details
    
//     logger.debug("Received recommendation request")
    
//     if df is None or not profession_details:
//         logger.warning("No data loaded, attempting to load...")
//         if not load_data():
//             logger.error("Failed to load data")
//             return jsonify([])
    
//     try:
//         data = request.get_json()
//         logger.debug(f"Received data: {data}")
        
//         if not data or 'questions' not in data:
//             logger.warning("No questions provided")
//             return jsonify([])
        
//         selected_questions = data['questions']
        
//         # Calculate career matches
//         recommendations = calculate_career_matches(selected_questions)
        
//         logger.debug(f"Sending recommendations: {recommendations}")
//         return jsonify(recommendations)
        
//     except Exception as e:
//         logger.error(f"Error processing request: {str(e)}")
//         return jsonify([])

// # Category mapping for better matching
// category_mapping = {
//     'Technical': {
//         'Programming', 'Python', 'SQL', 'Data Analysis', 'Machine Learning',
//         'AI', 'Software Development', 'Coding', 'Database'
//     },
//     'Analytical': {
//         'Problem-Solving', 'Critical Thinking', 'Analysis', 'Research',
//         'Statistics', 'Mathematical', 'Logical'
//     },
//     'Creative': {
//         'Design', 'Art', 'Innovation', 'Creative', 'Visual', 'Artistic',
//         'UX/UI', 'Content Creation'
//     },
//     'Healthcare': {
//         'Medical', 'Patient Care', 'Biology', 'Health', 'Diagnosis',
//         'Treatment', 'Clinical'
//     },
//     'Business': {
//         'Management', 'Leadership', 'Strategy', 'Marketing', 'Finance',
//         'Entrepreneurship', 'Business Analysis'
//     },
//     'Engineering': {
//         'Engineering', 'Architecture', 'Construction', 'Manufacturing',
//         'Mechanical', 'Electrical', 'Civil'
//     }
// }

// # Question mapping dictionary with comprehensive tags
// question_mapping = {
//     "Do you enjoy working with data and analyzing information?": [
//         "Data Analysis", "Statistics", "Python", "SQL", "Analytical", "Research"
//     ],
//     "Are you interested in building or designing things?": [
//         "Engineering", "Design", "Architecture", "Construction", "Creative"
//     ],
//     "Do you like solving complex problems or puzzles?": [
//         "Problem-Solving", "Critical Thinking", "Analytical", "Logical"
//     ],
//     "Are you passionate about artificial intelligence and machine learning?": [
//         "AI", "Machine Learning", "Programming", "Data Analysis", "Technical"
//     ],
//     "Do you enjoy protecting systems from cyber threats?": [
//         "Cybersecurity", "Network Security", "Technical", "Problem-Solving"
//     ],
//     # Add more mappings based on your questions
// }

// if __name__ == '__main__':
//     logger.info("Starting Flask application...")
//     load_data()
//     app.run(debug=True)
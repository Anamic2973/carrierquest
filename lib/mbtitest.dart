import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// MBTI dimension categories
enum MBTIDimension {
  EI, // Extraversion vs Introversion
  SN, // Sensing vs Intuition
  TF, // Thinking vs Feeling
  JP // Judging vs Perceiving
}

class MBTIQuestion {
  final String text;
  final MBTIDimension dimension;
  final bool
      positiveIndicatesFirst; // If true, "Yes" indicates first letter (E/S/T/J)
  final String imagePath;

  MBTIQuestion({
    required this.text,
    required this.dimension,
    required this.positiveIndicatesFirst,
    required this.imagePath,
  });
}

final List<MBTIQuestion> mbtiQuestions = [
  // E vs I questions
  MBTIQuestion(
    text:
        "Do you feel energized after spending time with a large group of people?",
    dimension: MBTIDimension.EI,
    positiveIndicatesFirst: true,
    imagePath: 'assets/images/q1.png',
  ),
  MBTIQuestion(
    text: "Do you prefer to think out loud and discuss ideas with others?",
    dimension: MBTIDimension.EI,
    positiveIndicatesFirst: true,
    imagePath: 'assets/images/q2.png',
  ),
  MBTIQuestion(
    text: "Do you prefer being the center of attention at social gatherings?",
    dimension: MBTIDimension.EI,
    positiveIndicatesFirst: true,
    imagePath: 'assets/images/q3.png',
  ),
  MBTIQuestion(
    text: "Do you recharge best by spending time alone?",
    dimension: MBTIDimension.EI,
    positiveIndicatesFirst: false,
    imagePath: 'assets/images/q4.png',
  ),
  MBTIQuestion(
    text: "Do you enjoy meeting new people and making new friends?",
    dimension: MBTIDimension.EI,
    positiveIndicatesFirst: true,
    imagePath: 'assets/images/q5.png',
  ),

  // S vs N questions
  MBTIQuestion(
    text: "Do you focus more on current realities than future possibilities?",
    dimension: MBTIDimension.SN,
    positiveIndicatesFirst: true,
    imagePath: 'assets/images/q6.png',
  ),
  MBTIQuestion(
    text: "Do you prefer concrete facts over abstract theories?",
    dimension: MBTIDimension.SN,
    positiveIndicatesFirst: true,
    imagePath: 'assets/images/q7.png',
  ),
  MBTIQuestion(
    text: "Do you trust concrete data more than intuitive hunches?",
    dimension: MBTIDimension.SN,
    positiveIndicatesFirst: true,
    imagePath: 'assets/images/q8.png',
  ),
  MBTIQuestion(
    text: "Do you enjoy thinking about abstract philosophical concepts?",
    dimension: MBTIDimension.SN,
    positiveIndicatesFirst: false,
    imagePath: 'assets/images/q9.png',
  ),
  MBTIQuestion(
    text: "Do you often imagine future scenarios and possibilities?",
    dimension: MBTIDimension.SN,
    positiveIndicatesFirst: false,
    imagePath: 'assets/images/q10.png',
  ),

  // T vs F questions
  MBTIQuestion(
    text: "Do you make decisions based more on logic than personal values?",
    dimension: MBTIDimension.TF,
    positiveIndicatesFirst: true,
    imagePath: 'assets/images/q11.png',
  ),
  MBTIQuestion(
    text: "Do you prefer honest criticism over tactful encouragement?",
    dimension: MBTIDimension.TF,
    positiveIndicatesFirst: true,
    imagePath: 'assets/images/q12.png',
  ),
  MBTIQuestion(
    text: "Do you prioritize objective truth over personal harmony?",
    dimension: MBTIDimension.TF,
    positiveIndicatesFirst: true,
    imagePath: 'assets/images/q13.png',
  ),
  MBTIQuestion(
    text: "Do you often consider how decisions will affect others' feelings?",
    dimension: MBTIDimension.TF,
    positiveIndicatesFirst: false,
    imagePath: 'assets/images/q14.png',
  ),
  MBTIQuestion(
    text: "Do you value empathy and compassion in decision-making?",
    dimension: MBTIDimension.TF,
    positiveIndicatesFirst: false,
    imagePath: 'assets/images/q15.png',
  ),

  // J vs P questions
  MBTIQuestion(
    text: "Do you prefer to have a detailed plan rather than be spontaneous?",
    dimension: MBTIDimension.JP,
    positiveIndicatesFirst: true,
    imagePath: 'assets/images/q16.png',
  ),
  MBTIQuestion(
    text:
        "Do you like to have things decided and settled rather than leaving options open?",
    dimension: MBTIDimension.JP,
    positiveIndicatesFirst: true,
    imagePath: 'assets/images/q17.png',
  ),
  MBTIQuestion(
    text: "Do you make to-do lists and stick to schedules?",
    dimension: MBTIDimension.JP,
    positiveIndicatesFirst: true,
    imagePath: 'assets/images/q18.png',
  ),
  MBTIQuestion(
    text: "Do you prefer keeping your options open rather than planning ahead?",
    dimension: MBTIDimension.JP,
    positiveIndicatesFirst: false,
    imagePath: 'assets/images/q19.png',
  ),
  MBTIQuestion(
    text: "Do you enjoy flexibility and adaptability in your daily life?",
    dimension: MBTIDimension.JP,
    positiveIndicatesFirst: false,
    imagePath: 'assets/images/q20.png',
  ),
];

class MBTIQuestionScreen extends StatefulWidget {
  @override
  _MBTIQuestionScreenState createState() => _MBTIQuestionScreenState();
}

class _MBTIQuestionScreenState extends State<MBTIQuestionScreen> {
  int _currentQuestionIndex = 0;
  Map<MBTIDimension, int> _scores = {
    MBTIDimension.EI: 0,
    MBTIDimension.SN: 0,
    MBTIDimension.TF: 0,
    MBTIDimension.JP: 0,
  };
  double _progress = 0.0;

  String _calculateMBTIType() {
    String type = '';

    // E/I
    type += _scores[MBTIDimension.EI]! > 0 ? 'E' : 'I';
    // S/N
    type += _scores[MBTIDimension.SN]! > 0 ? 'S' : 'N';
    // T/F
    type += _scores[MBTIDimension.TF]! > 0 ? 'T' : 'F';
    // J/P
    type += _scores[MBTIDimension.JP]! > 0 ? 'J' : 'P';

    return type;
  }

  void _onAnswer(bool answer) {
    final question = mbtiQuestions[_currentQuestionIndex];

    // Update score based on answer
    if (answer == question.positiveIndicatesFirst) {
      _scores[question.dimension] = _scores[question.dimension]! + 1;
    } else {
      _scores[question.dimension] = _scores[question.dimension]! - 1;
    }

    setState(() {
      if (_currentQuestionIndex < mbtiQuestions.length - 1) {
        _currentQuestionIndex++;
        _progress = (_currentQuestionIndex + 1) / mbtiQuestions.length;
      } else {
        // Test complete - calculate MBTI type
        String mbtiType = _calculateMBTIType();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PersonalityResultScreen(mbtiType: mbtiType),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = mbtiQuestions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personality Test',
          style: GoogleFonts.nunito(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: _progress,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          const Color.fromARGB(255, 12, 112, 54),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Question text
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
                    // Image
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        currentQuestion.imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 70),
                    // Yes button
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
                    // No button
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
                    // Progress text
                    Text(
                      'Question ${_currentQuestionIndex + 1} of ${mbtiQuestions.length}',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
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

class PersonalityResultScreen extends StatelessWidget {
  final String mbtiType;

  const PersonalityResultScreen({Key? key, required this.mbtiType})
      : super(key: key);

  Map<String, dynamic> get typeInfo {
    // Simplified MBTI type descriptions and career suggestions
    final typeData = {
      'INTJ': {
        'title': 'The Architect',
        'description':
            'Imaginative and strategic thinkers with a plan for everything.',
        'strengths': ['Strategic', 'Independent', 'Innovative', 'Analytical'],
        'careers': [
          'Data Scientist',
          'Software Architect',
          'Investment Banker',
          'Strategic Planner',
          'Research Scientist'
        ],
      },
      'INTP': {
        'title': 'The Logician',
        'description':
            'Innovative inventors with an unquenchable thirst for knowledge.',
        'strengths': ['Analytical', 'Original', 'Open-minded', 'Curious'],
        'careers': [
          'Software Developer',
          'Systems Analyst',
          'Physicist',
          'Professor',
          'Research Scientist'
        ],
      },
      'ENTJ': {
        'title': 'The Commander',
        'description':
            'Bold, imaginative and strong-willed leaders, always finding a way.',
        'strengths': ['Leadership', 'Strategic', 'Determined', 'Efficient'],
        'careers': [
          'Corporate Executive',
          'Management Consultant',
          'Business Administrator',
          'Lawyer',
          'Entrepreneur'
        ],
      },
      'ENTP': {
        'title': 'The Debater',
        'description':
            'Smart and curious thinkers who cannot resist an intellectual challenge.',
        'strengths': ['Innovative', 'Knowledgeable', 'Original', 'Charismatic'],
        'careers': [
          'Entrepreneur',
          'Political Scientist',
          'Creative Director',
          'Attorney',
          'Management Consultant'
        ],
      },
      'INFJ': {
        'title': 'The Advocate',
        'description':
            'Quiet and mystical, yet very inspiring and tireless idealists.',
        'strengths': ['Creative', 'Insightful', 'Principled', 'Passionate'],
        'careers': [
          'Counselor',
          'HR Development Trainer',
          'Non-profit Director',
          'Social Worker',
          'Psychologist'
        ],
      },
      'INFP': {
        'title': 'The Mediator',
        'description':
            'Poetic, kind and altruistic people, always eager to help a good cause.',
        'strengths': ['Empathetic', 'Creative', 'Open-minded', 'Passionate'],
        'careers': [
          'Writer',
          'Art Therapist',
          'Social Worker',
          'Librarian',
          'Graphic Designer'
        ],
      },
      'ENFJ': {
        'title': 'The Protagonist',
        'description':
            'Charismatic and inspiring leaders, able to mesmerize their listeners.',
        'strengths': [
          'Charismatic',
          'Reliable',
          'Natural Leaders',
          'Altruistic'
        ],
        'careers': [
          'Teacher',
          'HR Manager',
          'Training Manager',
          'Sales Manager',
          'Marketing Director'
        ],
      },
      'ENFP': {
        'title': 'The Campaigner',
        'description':
            'Enthusiastic, creative and sociable free spirits, who can always find a reason to smile.',
        'strengths': ['Enthusiastic', 'Creative', 'Sociable', 'Adaptable'],
        'careers': [
          'Journalist',
          'Actor',
          'Product Manager',
          'Event Planner',
          'Public Relations Specialist'
        ],
      },
      'ISTJ': {
        'title': 'The Logistician',
        'description':
            'Practical and fact-minded individuals, whose reliability cannot be doubted.',
        'strengths': ['Honest', 'Direct', 'Responsible', 'Calm'],
        'careers': [
          'Accountant',
          'Project Manager',
          'Military Officer',
          'Judge',
          'Financial Manager'
        ],
      },
      'ISFJ': {
        'title': 'The Defender',
        'description':
            'Very dedicated and warm protectors, always ready to defend their loved ones.',
        'strengths': ['Supportive', 'Reliable', 'Patient', 'Observant'],
        'careers': [
          'Nurse',
          'Elementary Teacher',
          'Administrative Assistant',
          'Librarian',
          'Customer Service Manager'
        ],
      },
      'ESTJ': {
        'title': 'The Executive',
        'description':
            'Excellent administrators, unsurpassed at managing things or people.',
        'strengths': ['Organized', 'Leadership', 'Dedicated', 'Traditional'],
        'careers': [
          'Business Administrator',
          'Sales Manager',
          'Police Officer',
          'Judge',
          'Insurance Agent'
        ],
      },
      'ESFJ': {
        'title': 'The Consul',
        'description':
            'Extraordinarily caring, social and popular people, always eager to help.',
        'strengths': ['Caring', 'Organized', 'Dutiful', 'Practical'],
        'careers': [
          'Healthcare Worker',
          'Sales Representative',
          'Office Manager',
          'Teacher',
          'Social Worker'
        ],
      },
      'ISTP': {
        'title': 'The Virtuoso',
        'description':
            'Bold and practical experimenters, masters of all kinds of tools.',
        'strengths': ['Optimistic', 'Creative', 'Practical', 'Spontaneous'],
        'careers': [
          'Mechanical Engineer',
          'Software Developer',
          'Pilot',
          'Data Analyst',
          'Forensic Scientist'
        ],
      },
      'ISFP': {
        'title': 'The Adventurer',
        'description':
            'Flexible and charming artists, always ready to explore and experience something new.',
        'strengths': ['Artistic', 'Passionate', 'Curious', 'Adaptable'],
        'careers': [
          'Artist',
          'Designer',
          'Musician',
          'Veterinarian',
          'Fashion Designer'
        ],
      },
      'ESTP': {
        'title': 'The Entrepreneur',
        'description':
            'Smart, energetic and very perceptive people, who truly enjoy living on the edge.',
        'strengths': ['Perceptive', 'Energetic', 'Adaptable', 'Risk-taker'],
        'careers': [
          'Sales Representative',
          'Marketing Executive',
          'Entrepreneur',
          'Police Officer',
          'Athletic Coach'
        ],
      },
      'ESFP': {
        'title': 'The Entertainer',
        'description':
            'Spontaneous, energetic and enthusiastic people – life is never boring around them.',
        'strengths': ['Bold', 'Original', 'Practical', 'Observant'],
        'careers': [
          'Event Planner',
          'Sales Representative',
          'Child Care Provider',
          'Actor',
          'Travel Agent'
        ],
      },

      // Add other MBTI types similarly
    };

    return typeData[mbtiType] ??
        {
          'title': 'Personality Type $mbtiType',
          'description': 'A unique combination of personality traits.',
          'strengths': ['Adaptable', 'Unique', 'Balanced'],
          'careers': ['Various career paths available'],
        };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Personality Type',
          style: GoogleFonts.nunito(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Type Header
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        mbtiType,
                        style: GoogleFonts.nunito(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      Text(
                        typeInfo['title'],
                        style: GoogleFonts.nunito(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Description
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        typeInfo['description'],
                        style: GoogleFonts.nunito(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Strengths
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Key Strengths',
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (typeInfo['strengths'] as List)
                            .map(
                              (strength) => Chip(
                                label: Text(
                                  strength,
                                  style:
                                      GoogleFonts.nunito(color: Colors.white),
                                ),
                                backgroundColor: Colors.blue[700],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Career Suggestions
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recommended Careers',
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...(typeInfo['careers'] as List)
                          .map(
                            (career) => ListTile(
                              leading:
                                  Icon(Icons.work, color: Colors.blue[700]),
                              title: Text(
                                career,
                                style: GoogleFonts.nunito(fontSize: 16),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

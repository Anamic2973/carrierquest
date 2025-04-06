import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Skill Categories
enum SkillCategory {
  Technical,
  Communication,
  Leadership,
  Creativity,
  ProblemSolving,
  Adaptability,
  TeamWork,
  TimeManagement,
}

class SkillQuestion {
  final String text;
  final SkillCategory category;
  final String imagePath;

  SkillQuestion({
    required this.text,
    required this.category,
    required this.imagePath,
  });
}

// List of Skill Assessment Questions
final List<SkillQuestion> skillQuestions = [
  // Technical Skills
  SkillQuestion(
    text: "I can quickly learn and adapt to new software and technologies.",
    category: SkillCategory.Technical,
    imagePath: 'assets/images/q1.png',
  ),
  SkillQuestion(
    text: "I enjoy solving complex technical problems.",
    category: SkillCategory.Technical,
    imagePath: 'assets/images/q2.png',
  ),

  // Communication Skills
  SkillQuestion(
    text: "I can explain complex ideas in simple terms.",
    category: SkillCategory.Communication,
    imagePath: 'assets/images/q3.png',
  ),
  SkillQuestion(
    text: "I'm comfortable speaking in front of groups.",
    category: SkillCategory.Communication,
    imagePath: 'assets/images/q4.png',
  ),

  // Leadership Skills
  SkillQuestion(
    text: "I naturally take charge in group situations.",
    category: SkillCategory.Leadership,
    imagePath: 'assets/images/q5.png',
  ),
  SkillQuestion(
    text: "I can motivate others to achieve goals.",
    category: SkillCategory.Leadership,
    imagePath: 'assets/images/q6.png',
  ),

  // Creativity Skills
  SkillQuestion(
    text: "I often come up with unique solutions to problems.",
    category: SkillCategory.Creativity,
    imagePath: 'assets/images/q7.png',
  ),
  SkillQuestion(
    text: "I enjoy thinking outside the box.",
    category: SkillCategory.Creativity,
    imagePath: 'assets/images/q8.png',
  ),

  // Problem Solving
  SkillQuestion(
    text: "I can break down complex problems into manageable parts.",
    category: SkillCategory.ProblemSolving,
    imagePath: 'assets/images/q9.png',
  ),
  SkillQuestion(
    text: "I consider multiple perspectives when solving problems.",
    category: SkillCategory.ProblemSolving,
    imagePath: 'assets/images/q10.png',
  ),

  // Adaptability
  SkillQuestion(
    text: "I handle unexpected changes well.",
    category: SkillCategory.Adaptability,
    imagePath: 'assets/images/q11.png',
  ),
  SkillQuestion(
    text: "I'm comfortable working in uncertain situations.",
    category: SkillCategory.Adaptability,
    imagePath: 'assets/images/q12.png',
  ),

  // Team Work
  SkillQuestion(
    text: "I work well with people from diverse backgrounds.",
    category: SkillCategory.TeamWork,
    imagePath: 'assets/images/q13.png',
  ),
  SkillQuestion(
    text: "I actively contribute to team discussions and projects.",
    category: SkillCategory.TeamWork,
    imagePath: 'assets/images/q14.png',
  ),

  // Time Management
  SkillQuestion(
    text: "I consistently meet deadlines and manage time well.",
    category: SkillCategory.TimeManagement,
    imagePath: 'assets/images/q15.png',
  ),
  SkillQuestion(
    text: "I can prioritize tasks effectively.",
    category: SkillCategory.TimeManagement,
    imagePath: 'assets/images/q16.png',
  ),
];

class SkillAssessmentScreen extends StatefulWidget {
  @override
  _SkillAssessmentScreenState createState() => _SkillAssessmentScreenState();
}

class _SkillAssessmentScreenState extends State<SkillAssessmentScreen> {
  int _currentQuestionIndex = 0;
  Map<SkillCategory, List<int>> _scores = {
    SkillCategory.Technical: [],
    SkillCategory.Communication: [],
    SkillCategory.Leadership: [],
    SkillCategory.Creativity: [],
    SkillCategory.ProblemSolving: [],
    SkillCategory.Adaptability: [],
    SkillCategory.TeamWork: [],
    SkillCategory.TimeManagement: [],
  };
  double _progress = 0.0;

  void _onAnswer(int score) {
    // score from 1 to 5
    final question = skillQuestions[_currentQuestionIndex];
    setState(() {
      _scores[question.category]!.add(score);

      if (_currentQuestionIndex < skillQuestions.length - 1) {
        _currentQuestionIndex++;
        _progress = (_currentQuestionIndex + 1) / skillQuestions.length;
      } else {
        // Test complete - navigate to results
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SkillResultScreen(scores: _calculateFinalScores()),
          ),
        );
      }
    });
  }

  Map<SkillCategory, double> _calculateFinalScores() {
    Map<SkillCategory, double> finalScores = {};

    _scores.forEach((category, scores) {
      if (scores.isNotEmpty) {
        double average = scores.reduce((a, b) => a + b) / scores.length;
        finalScores[category] = (average * 20); // Convert to percentage
      } else {
        finalScores[category] = 0.0;
      }
    });

    return finalScores;
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = skillQuestions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Skill Assessment',
          style: GoogleFonts.nunito(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
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
              const SizedBox(height: 40),
              // Rating buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  return ElevatedButton(
                    onPressed: () => _onAnswer(index + 1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getButtonColor(index + 1),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              Text(
                '1 = Strongly Disagree, 5 = Strongly Agree',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Question ${_currentQuestionIndex + 1} of ${skillQuestions.length}',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(int score) {
    switch (score) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow[700]!;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

class SkillResultScreen extends StatelessWidget {
  final Map<SkillCategory, double> scores;

  const SkillResultScreen({Key? key, required this.scores}) : super(key: key);

  String _getSkillLevel(double score) {
    if (score >= 80) return 'Expert';
    if (score >= 60) return 'Advanced';
    if (score >= 40) return 'Intermediate';
    if (score >= 20) return 'Basic';
    return 'Novice';
  }

  Color _getSkillColor(double score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.lightGreen;
    if (score >= 40) return Colors.yellow[700]!;
    if (score >= 20) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<SkillCategory, double>> sortedScores = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Skill Profile',
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
              Text(
                'Skill Assessment Results',
                style: GoogleFonts.nunito(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ...sortedScores
                  .map((entry) => Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    entry.key.toString().split('.').last,
                                    style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    _getSkillLevel(entry.value),
                                    style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      color: _getSkillColor(entry.value),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: entry.value / 100,
                                  backgroundColor: Colors.grey[200],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    _getSkillColor(entry.value),
                                  ),
                                  minHeight: 10,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${entry.value.toStringAsFixed(1)}%',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add development recommendations or next steps
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SkillDevelopmentPlanScreen(scores: scores),
                    ),
                  );
                },
                child: Text(
                  'View Development Plan',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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

// You can implement SkillDevelopmentPlanScreen similarly to show personalized recommendations

class SkillDevelopmentPlanScreen extends StatelessWidget {
  final Map<SkillCategory, double> scores;

  const SkillDevelopmentPlanScreen({Key? key, required this.scores})
      : assert(scores != null),
        super(key: key);

  // Development recommendations based on skill level
  Map<String, List<String>> _getRecommendations(
      SkillCategory category, double score) {
    final Map<String, Map<String, List<String>>> recommendations = {
      'Technical': {
        'novice': [
          'Complete basic programming tutorials on Codecademy',
          'Learn fundamental computer concepts through online courses',
          'Practice with basic software tools',
          'Join beginner-friendly tech communities',
        ],
        'intermediate': [
          'Take advanced programming courses',
          'Work on personal coding projects',
          'Obtain technical certifications',
          'Participate in coding challenges',
        ],
        'expert': [
          'Contribute to open-source projects',
          'Mentor others in technical skills',
          'Specialize in advanced technologies',
          'Write technical articles',
        ],
      },
      'Communication': {
        'novice': [
          'Join a Toastmasters club',
          'Practice writing clear emails',
          'Read books on effective communication',
          'Record and analyze your speaking skills',
        ],
        'intermediate': [
          'Take public speaking workshops',
          'Volunteer for presentations',
          'Practice active listening techniques',
          'Write blog posts on communication skills',
        ],
        'expert': [
          'Speak at conferences',
          'Lead communication workshops',
          'Develop training materials',
          'Coach others in presentation skills',
        ],
      },
      'Leadership': {
        'novice': [
          'Read books on leadership principles',
          'Observe and learn from great leaders',
          'Take responsibility for small tasks in teams',
          'Improve self-discipline and time management',
        ],
        'intermediate': [
          'Attend leadership training programs',
          'Take charge of small projects',
          'Develop team-building skills',
          'Give constructive feedback to team members',
        ],
        'expert': [
          'Lead large teams and projects',
          'Mentor aspiring leaders',
          'Drive organizational change',
          'Write and publish leadership insights',
        ],
      },
      'Problem-Solving': {
        'novice': [
          'Learn basic problem-solving frameworks',
          'Practice logical reasoning exercises',
          'Observe how experts approach problem-solving',
          'Engage in simple puzzles and brain teasers',
        ],
        'intermediate': [
          'Take part in hackathons or case competitions',
          'Analyze real-world case studies',
          'Apply problem-solving techniques to work projects',
          'Develop structured thinking methods',
        ],
        'expert': [
          'Mentor others in critical thinking',
          'Develop innovative solutions to industry challenges',
          'Write and publish case studies',
          'Teach problem-solving methodologies',
        ],
      },
      'Time Management': {
        'novice': [
          'Create a daily to-do list',
          'Use a calendar for scheduling tasks',
          'Avoid multitasking to stay focused',
          'Set clear daily and weekly goals',
        ],
        'intermediate': [
          'Apply the Pomodoro technique',
          'Prioritize tasks using the Eisenhower matrix',
          'Limit distractions with focus techniques',
          'Batch similar tasks together for efficiency',
        ],
        'expert': [
          'Optimize workflows for maximum productivity',
          'Mentor others in time management',
          'Develop time management systems',
          'Speak at events on productivity strategies',
        ],
      },
      'Creativity': {
        'novice': [
          'Engage in brainstorming exercises',
          'Keep a journal of creative ideas',
          'Experiment with different problem-solving methods',
          'Read books on creative thinking',
        ],
        'intermediate': [
          'Work on projects that challenge creativity',
          'Collaborate with diverse teams for fresh perspectives',
          'Practice lateral thinking techniques',
          'Develop storytelling skills to communicate ideas',
        ],
        'expert': [
          'Lead creative strategy sessions',
          'Write a book or blog about creativity',
          'Teach creativity workshops',
          'Develop innovative business models',
        ],
      },
    };

    String categoryKey =
        category.toString().split('.').last; // Extract the category name
    String level = score >= 80
        ? 'expert'
        : score >= 40
            ? 'intermediate'
            : 'novice';

    // Ensure category exists in recommendations
    if (!recommendations.containsKey(categoryKey)) {
      return {level: []}; // Return an empty list if category is missing
    }

    // Ensure level exists in the category
    return {level: recommendations[categoryKey]?[level] ?? []};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Development Plan',
          style: GoogleFonts.nunito(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Personalized Development Plan',
                style: GoogleFonts.nunito(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ...scores.entries.map((entry) {
                final recs = _getRecommendations(entry.key, entry.value);
                return DevelopmentSection(
                  category: entry.key,
                  score: entry.value,
                  recommendations: recs,
                );
              }).toList(),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Implement export or share functionality
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  'Export Development Plan',
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
      ),
    );
  }
}

class DevelopmentSection extends StatelessWidget {
  final SkillCategory category;
  final double score;
  final Map<String, List<String>> recommendations;

  const DevelopmentSection({
    Key? key,
    required this.category,
    required this.score,
    required this.recommendations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: ExpansionTile(
        title: Text(
          category.toString().split('.').last,
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Current Level: ${_getSkillLevel(score)}',
          style: GoogleFonts.nunito(
            color: _getSkillColor(score),
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommended Actions:',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...recommendations.entries.expand((entry) => [
                      ...entry.value.map((rec) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.arrow_right,
                                    color: Colors.blue),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    rec,
                                    style: GoogleFonts.nunito(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ]),
                const SizedBox(height: 16),
                Text(
                  'Resources:',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildResourcesList(category),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourcesList(SkillCategory category) {
    final resources = _getCategoryResources(category);
    return Column(
      children: resources
          .map((resource) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(resource.icon, color: Colors.blue, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        resource.name,
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  String _getSkillLevel(double score) {
    if (score >= 80) return 'Expert';
    if (score >= 60) return 'Advanced';
    if (score >= 40) return 'Intermediate';
    if (score >= 20) return 'Basic';
    return 'Novice';
  }

  Color _getSkillColor(double score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.lightGreen;
    if (score >= 40) return Colors.yellow[700]!;
    if (score >= 20) return Colors.orange;
    return Colors.red;
  }

  List<ResourceItem> _getCategoryResources(SkillCategory category) {
    final resources = {
      SkillCategory.Technical: [
        ResourceItem(Icons.school, 'Online Courses'),
        ResourceItem(Icons.book, 'Technical Documentation'),
        ResourceItem(Icons.group, 'Developer Community'),
        ResourceItem(Icons.computer, 'Coding Platforms (LeetCode, Codeforces)'),
      ],
      SkillCategory.Communication: [
        ResourceItem(Icons.record_voice_over, 'Public Speaking Club'),
        ResourceItem(Icons.book, 'Communication Books'),
        ResourceItem(Icons.video_library, 'Speaking Practice Videos'),
        ResourceItem(Icons.forum, 'Discussion Forums'),
      ],
      SkillCategory.Leadership: [
        ResourceItem(Icons.business, 'Leadership Workshops'),
        ResourceItem(Icons.menu_book, 'Books on Leadership'),
        ResourceItem(Icons.supervisor_account, 'Mentorship Programs'),
        ResourceItem(Icons.event, 'Leadership Seminars'),
      ],
      SkillCategory.ProblemSolving: [
        ResourceItem(Icons.lightbulb, 'Critical Thinking Courses'),
        ResourceItem(Icons.extension, 'Puzzle and Logic Games'),
        ResourceItem(Icons.analytics, 'Case Study Analysis'),
        ResourceItem(Icons.psychology, 'Problem-Solving Frameworks'),
      ],
      SkillCategory.TimeManagement: [
        ResourceItem(Icons.access_time, 'Time Management Apps'),
        ResourceItem(Icons.timer, 'Pomodoro Technique Tools'),
        ResourceItem(Icons.calendar_today, 'Productivity Books'),
        ResourceItem(Icons.checklist, 'Task Prioritization Frameworks'),
      ],
      SkillCategory.Creativity: [
        ResourceItem(Icons.palette, 'Creative Thinking Books'),
        ResourceItem(Icons.draw, 'Design and Art Platforms'),
        ResourceItem(Icons.mic, 'Storytelling Workshops'),
        ResourceItem(Icons.camera_roll, 'Inspiration from Media'),
      ],
    };
    return resources[category] ?? [];
  }
}

class ResourceItem {
  final IconData icon;
  final String name;

  ResourceItem(this.icon, this.name);
}

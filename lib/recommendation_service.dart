// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class Recommendation {
//   final String profession;
//   final String futureScopeYears;
//   final String information;
//   final int score;
//   final List<String> associatedSkills;
//   final String field;
//   final String educationRequired;
//   final String averageSalary;

//   Recommendation({
//     required this.profession,
//     required this.futureScopeYears,
//     required this.information,
//     required this.score,
//     required this.associatedSkills,
//     required this.field,
//     required this.educationRequired,
//     required this.averageSalary,
//   });

//   factory Recommendation.fromJson(Map<String, dynamic> json) {
//     List<String> parseSkills(dynamic skills) {
//       if (skills is List) return List<String>.from(skills);
//       if (skills is String)
//         return skills
//             .split(',')
//             .map((s) => s.trim())
//             .where((s) => s.isNotEmpty)
//             .toList();
//       return [];
//     }

//     return Recommendation(
//       profession: json['profession'] as String? ?? 'Unknown',
//       futureScopeYears: json['future_scope_years'] as String? ?? 'N/A',
//       information: json['information'] as String? ?? 'No information available',
//       score: json['score'] as int? ?? 0,
//       associatedSkills: parseSkills(json['associated_skills']),
//       field: json['field'] as String? ?? 'Unknown Field',
//       educationRequired:
//           json['education_required'] as String? ?? 'Not specified',
//       averageSalary: json['average_salary'] as String? ?? 'Not specified',
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'profession': profession,
//       'future_scope_years': futureScopeYears,
//       'information': information,
//       'score': score,
//       'associated_skills': associatedSkills,
//       'field': field,
//       'education_required': educationRequired,
//       'average_salary': averageSalary,
//     };
//   }
// }

// class RecommendationService {
//   final String baseUrl = 'http://127.0.0.1:5000';

//   Future<List<Map<String, dynamic>>> getRecommendations(
//       List<String> questions) async {
//     try {
//       print('Sending request to $baseUrl/recommend');
//       print('Request body: ${jsonEncode({'questions': questions})}');

//       final response = await http.post(
//         Uri.parse('$baseUrl/recommend'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//         body: jsonEncode({'questions': questions}),
//       );

//       print('Response status code: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         if (response.body.isEmpty) {
//           return [];
//         }

//         final List<dynamic> jsonResponse = jsonDecode(response.body);

//         return jsonResponse.map((item) {
//           try {
//             final recommendation =
//                 Recommendation.fromJson(Map<String, dynamic>.from(item));
//             return recommendation.toMap();
//           } catch (e) {
//             print('Error parsing recommendation: $e');
//             return {
//               'profession': 'Error',
//               'future_scope_years': 'N/A',
//               'information': 'Error parsing data',
//               'score': 0,
//               'associated_skills': <String>[],
//               'field': 'Unknown',
//               'education_required': 'Not specified',
//               'average_salary': 'Not specified',
//             };
//           }
//         }).toList();
//       } else {
//         throw Exception('Server returned status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error in getRecommendations: $e');
//       throw Exception('Error connecting to recommendation service: $e');
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;

class Recommendation {
  final String profession;
  final double confidence;
  final String futureScope;
  final String information;
  final List<String> associatedSkills;
  final String field;
  final String educationRequired;
  final String averageSalary;
  final int score;

  Recommendation({
    required this.profession,
    required this.confidence,
    required this.futureScope,
    required this.information,
    required this.associatedSkills,
    required this.field,
    required this.educationRequired,
    required this.averageSalary,
    required this.score,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    // Helper function to get the growth potential category based on confidence
    String getGrowthPotential(double confidence) {
      if (confidence >= 0.8) return 'High Growth (10+ years)';
      if (confidence >= 0.6) return 'Moderate Growth (5-10 years)';
      return 'Emerging (1-5 years)';
    }

    // Convert confidence to a score percentage
    int calculateScore(double confidence) {
      return (confidence * 100).round();
    }

    return Recommendation(
      profession: json['profession'] as String? ?? 'Unknown Profession',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      futureScope:
          getGrowthPotential((json['confidence'] as num?)?.toDouble() ?? 0.0),
      information:
          _generateJobDescription(json['profession'] as String? ?? 'Unknown'),
      associatedSkills:
          _getAssociatedSkills(json['profession'] as String? ?? 'Unknown'),
      field: _getField(json['profession'] as String? ?? 'Unknown'),
      educationRequired:
          _getEducationRequirement(json['profession'] as String? ?? 'Unknown'),
      averageSalary:
          _getAverageSalary(json['profession'] as String? ?? 'Unknown'),
      score: calculateScore((json['confidence'] as num?)?.toDouble() ?? 0.0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profession': profession,
      'future_scope_years': futureScope,
      'information': information,
      'score': score,
      'associated_skills': associatedSkills,
      'field': field,
      'education_required': educationRequired,
      'average_salary': averageSalary,
    };
  }

  // Helper methods to generate missing information
  static String _generateJobDescription(String profession) {
    // Add basic job descriptions for common professions
    final descriptions = {
      'Data Scientist':
          'Analyzes complex data sets to help organizations make better decisions. Combines statistics, mathematics, and programming to extract insights from data.',
      'Software Engineer':
          'Designs and develops computer software and applications. Works with various programming languages and frameworks to create efficient solutions.',
      // Add more professions as needed
    };

    return descriptions[profession] ??
        'A professional role requiring specific skills and expertise in $profession.';
  }

  static List<String> _getAssociatedSkills(String profession) {
    // Map professions to common required skills
    final skillsMap = {
      'Data Scientist': [
        'Python',
        'Machine Learning',
        'Statistics',
        'SQL',
        'Data Visualization'
      ],
      'Software Engineer': [
        'Programming',
        'Software Design',
        'Problem Solving',
        'Debugging',
        'Version Control'
      ],
      // Add more mappings as needed
    };

    return skillsMap[profession] ??
        [
          'Professional Skills',
          'Technical Knowledge',
          'Communication',
          'Problem Solving'
        ];
  }

  static String _getField(String profession) {
    // Map professions to their general fields
    final fieldMap = {
      'Data Scientist': 'Technology & Analytics',
      'Software Engineer': 'Information Technology',
      // Add more mappings as needed
    };

    return fieldMap[profession] ?? 'Professional Services';
  }

  static String _getEducationRequirement(String profession) {
    // Map professions to typical education requirements
    final educationMap = {
      'Data Scientist':
          "Bachelor's or Master's in Computer Science, Statistics, or related field",
      'Software Engineer': "Bachelor's in Computer Science or related field",
      // Add more mappings as needed
    };

    return educationMap[profession] ??
        "Bachelor's degree or equivalent experience";
  }

  static String _getAverageSalary(String profession) {
    // Map professions to typical salary ranges
    final salaryMap = {
      'Data Scientist': '\$90,000 - \$150,000',
      'Software Engineer': '\$80,000 - \$140,000',
      // Add more mappings as needed
    };

    return salaryMap[profession] ?? 'Varies based on experience and location';
  }
}

class RecommendationService {
  final String baseUrl = 'http://127.0.0.1:5000';

  Future<List<Map<String, dynamic>>> getRecommendations(
      List<String> questions) async {
    try {
      // Prepare input data based on questions
      final inputData = _prepareInputData(questions);

      final response = await http.post(
        Uri.parse('$baseUrl/recommend'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(inputData),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Create a recommendation from the model's response
        final recommendation = Recommendation.fromJson(jsonResponse);

        // Return as a list with a single recommendation for now
        // You can modify this to handle multiple recommendations if needed
        return [recommendation.toMap()];
      } else {
        throw Exception('Server returned status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getRecommendations: $e');
      throw Exception('Error connecting to recommendation service: $e');
    }
  }

  Map<String, dynamic> _prepareInputData(List<String> questions) {
    // Combine all selected questions' information
    String jobDescription = '';
    String associatedSkills = '';
    String personality = 'ENTJ'; // Default personality type
    String typeOfInterest = '';
    String educationRequirement =
        "Bachelor's Degree"; // Default education requirement
    String futureGrowth = 'High'; // Default growth potential
    double averageSalary = 80000.0; // Default salary

    // Process each question to build the input data
    for (String question in questions) {
      // Add relevant information based on the question
      if (question.contains('data') || question.contains('analyzing')) {
        jobDescription += 'Data analysis and interpretation. ';
        associatedSkills += 'Python,SQL,Statistics,';
        typeOfInterest += 'Investigative,Analytical,';
      }
      // Add more question processing logic as needed
    }

    return {
      'job_description': jobDescription.trim(),
      'associated_skills': associatedSkills.trimRight(),
      'personality': personality,
      'type_of_interest': typeOfInterest.trimRight(),
      'education_requirement': educationRequirement,
      'future_growth': futureGrowth,
      'average_salary': averageSalary
    };
  }
}

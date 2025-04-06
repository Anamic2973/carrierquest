// import 'package:flutter/material.dart';
// // ignore: unused_import
// import 'package:fl_chart/fl_chart.dart';
// import 'recommendation_service.dart';

// class ProfessionData {
//   final String profession;
//   final int score;
//   final String futureScope;
//   final String information;
//   final List<String> associatedSkills;
//   final String field;
//   final String educationRequired;
//   final String averageSalary;

//   ProfessionData({
//     required this.profession,
//     required this.score,
//     required this.futureScope,
//     required this.information,
//     required this.associatedSkills,
//     required this.field,
//     required this.educationRequired,
//     required this.averageSalary,
//   });

//   factory ProfessionData.fromJson(Map<String, dynamic> json) {
//     List<String> parseSkills(dynamic skills) {
//       if (skills is List) return List<String>.from(skills);
//       if (skills is String) {
//         return skills
//             .split(',')
//             .map((s) => s.trim())
//             .where((s) => s.isNotEmpty)
//             .toList();
//       }
//       return [];
//     }

//     return ProfessionData(
//       profession: json['profession'] ?? 'Unknown Profession',
//       score: json['score'] ?? 0,
//       futureScope: json['future_scope_years'] ?? 'N/A',
//       information: json['information'] ?? 'No information available',
//       associatedSkills: parseSkills(json['associated_skills']),
//       field: json['field'] ?? 'Unknown Field',
//       educationRequired: json['education_required'] ?? 'Not specified',
//       averageSalary: json['average_salary'] ?? 'Not specified',
//     );
//   }
// }

// class RecommendationScreen extends StatefulWidget {
//   final List<String> selectedQuestions;

//   const RecommendationScreen({Key? key, required this.selectedQuestions})
//       : super(key: key);

//   @override
//   _RecommendationScreenState createState() => _RecommendationScreenState();
// }

// class _RecommendationScreenState extends State<RecommendationScreen> {
//   final RecommendationService _service = RecommendationService();
//   List<ProfessionData> recommendations = [];
//   bool isLoading = true;
//   String? error;

//   @override
//   void initState() {
//     super.initState();
//     _fetchRecommendations();
//   }

//   Future<void> _fetchRecommendations() async {
//     try {
//       setState(() {
//         isLoading = true;
//         error = null;
//       });

//       final result =
//           await _service.getRecommendations(widget.selectedQuestions);
//       setState(() {
//         recommendations =
//             result.map((item) => ProfessionData.fromJson(item)).toList();
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         error = 'Failed to load recommendations: ${e.toString()}';
//         isLoading = false;
//       });
//     }
//   }

//   Widget _buildChart() {
//     return Container(
//       height: 250,
//       padding: const EdgeInsets.all(16),
//       child: BarChart(
//         BarChartData(
//           alignment: BarChartAlignment.spaceAround,
//           maxY: 100,
//           titlesData: FlTitlesData(
//             show: true,
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, meta) {
//                   if (value.toInt() >= recommendations.length) {
//                     return const Text('');
//                   }
//                   final prof = recommendations[value.toInt()];
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           prof.profession.split(',').last.trim(),
//                           style: const TextStyle(
//                               fontSize: 10, fontWeight: FontWeight.bold),
//                           textAlign: TextAlign.center,
//                         ),
//                         Text(
//                           prof.futureScope,
//                           style: TextStyle(
//                               fontSize: 9,
//                               color: Colors.green[700],
//                               fontWeight: FontWeight.w500),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 reservedSize: 60,
//               ),
//             ),
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 reservedSize: 40,
//                 getTitlesWidget: (value, meta) {
//                   return Text(
//                     value.toInt().toString(),
//                     style: const TextStyle(fontSize: 12),
//                   );
//                 },
//               ),
//             ),
//             topTitles: const AxisTitles(
//               sideTitles: SideTitles(showTitles: false),
//             ),
//             rightTitles: const AxisTitles(
//               sideTitles: SideTitles(showTitles: false),
//             ),
//           ),
//           borderData: FlBorderData(
//             show: true,
//             border: Border.all(color: Colors.grey.shade300),
//           ),
//           barGroups: recommendations.asMap().entries.map((entry) {
//             return BarChartGroupData(
//               x: entry.key,
//               barRods: [
//                 BarChartRodData(
//                   toY: entry.value.score.toDouble(),
//                   color: Colors.blue,
//                   width: 20,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ],
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }

//   Widget _buildSkillChips(List<String> skills) {
//     return Wrap(
//       spacing: 8,
//       runSpacing: 8,
//       children: skills
//           .map((skill) => Chip(
//                 label: Text(
//                   skill,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.blue,
//                   ),
//                 ),
//                 backgroundColor: Colors.blue.withOpacity(0.1),
//               ))
//           .toList(),
//     );
//   }

//   Widget _buildProfessionCard(ProfessionData profession) {
//     final scopeColor = _getScopeColor(profession.futureScope);

//     return Card(
//       elevation: 3,
//       margin: const EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         profession.profession,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.blue.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           'Match Score: ${profession.score}%',
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: scopeColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: scopeColor.withOpacity(0.3)),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.trending_up, color: scopeColor),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Future Growth Potential: ${profession.futureScope}',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           profession.futureScope,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: scopeColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Field:${profession.field}',
//               style: const TextStyle(
//                 fontSize: 14,
//                 height: 1.5,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Education Required:${profession.educationRequired}',
//               style: const TextStyle(
//                 fontSize: 14,
//                 height: 1.5,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Average Salary:${profession.averageSalary}',
//               style: const TextStyle(
//                 fontSize: 14,
//                 height: 1.5,
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Job Description',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               profession.information,
//               style: const TextStyle(
//                 fontSize: 14,
//                 height: 1.5,
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Required Skills',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             _buildSkillChips(profession.associatedSkills),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoSection(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Text(
//             '$label: ',
//             style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Color _getScopeColor(String years) {
//     if (years == 'N/A') return Colors.grey;
//     final numYears = int.tryParse(years.split(' ').first) ?? 0;
//     if (numYears > 10) return Colors.green;
//     if (numYears > 5) return Colors.orange;
//     return Colors.red;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Career Recommendations'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _fetchRecommendations,
//           ),
//         ],
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : error != null
//               ? Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'Error Loading Recommendations',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           error!,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: Colors.red[700]),
//                         ),
//                         const SizedBox(height: 16),
//                         ElevatedButton.icon(
//                           onPressed: _fetchRecommendations,
//                           icon: const Icon(Icons.refresh),
//                           label: const Text('Try Again'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               : recommendations.isEmpty
//                   ? const Center(
//                       child: Text(
//                         'No matching professions found',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     )
//                   : SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           _buildChart(),
//                           Padding(
//                             padding: const EdgeInsets.all(16),
//                             child: ListView.builder(
//                               physics: const NeverScrollableScrollPhysics(),
//                               shrinkWrap: true,
//                               itemCount: recommendations.length,
//                               itemBuilder: (context, index) =>
//                                   _buildProfessionCard(
//                                 recommendations[index],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//     );
//   }
// }

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:fl_chart/fl_chart.dart';
import 'recommendation_service.dart';

class ProfessionData {
  final String profession;
  final int score;
  final String futureScope;
  final String information;
  final List<String> associatedSkills;
  final String field;
  final String educationRequired;
  final String averageSalary;

  ProfessionData({
    required this.profession,
    required this.score,
    required this.futureScope,
    required this.information,
    required this.associatedSkills,
    required this.field,
    required this.educationRequired,
    required this.averageSalary,
  });

  factory ProfessionData.fromJson(Map<String, dynamic> json) {
    List<String> parseSkills(dynamic skills) {
      if (skills is List) return List<String>.from(skills);
      if (skills is String) {
        return skills
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
      }
      return [];
    }

    return ProfessionData(
      profession: json['profession'] ?? 'Unknown Profession',
      score: json['score'] ?? 0,
      futureScope: json['future_scope_years'] ?? 'N/A',
      information: json['information'] ?? 'No information available',
      associatedSkills: parseSkills(json['associated_skills']),
      field: json['field'] ?? 'Unknown Field',
      educationRequired: json['education_required'] ?? 'Not specified',
      averageSalary: json['average_salary'] ?? 'Not specified',
    );
  }
}

class RecommendationScreen extends StatefulWidget {
  final List<String> selectedQuestions;

  const RecommendationScreen({Key? key, required this.selectedQuestions})
      : super(key: key);

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  final RecommendationService _service = RecommendationService();
  List<ProfessionData> recommendations = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _fetchRecommendations();
  }

  Future<void> _fetchRecommendations() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final result =
          await _service.getRecommendations(widget.selectedQuestions);
      setState(() {
        recommendations =
            result.map((item) => ProfessionData.fromJson(item)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Failed to load recommendations: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  Widget _buildChart() {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= recommendations.length) {
                    return const Text('');
                  }
                  final prof = recommendations[value.toInt()];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        Text(
                          prof.profession.split(',').last.trim(),
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          prof.futureScope,
                          style: TextStyle(
                              fontSize: 9,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
                reservedSize: 60,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey.shade300),
          ),
          barGroups: recommendations.asMap().entries.map((entry) {
            return BarChartGroupData(
              x: entry.key,
              barRods: [
                BarChartRodData(
                  toY: entry.value.score.toDouble(),
                  color: Colors.blue,
                  width: 20,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSkillChips(List<String> skills) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: skills
          .map((skill) => Chip(
                label: Text(
                  skill,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                  ),
                ),
                backgroundColor: Colors.blue.withOpacity(0.1),
              ))
          .toList(),
    );
  }

  Widget _buildProfessionCard(ProfessionData profession) {
    final scopeColor = _getScopeColor(profession.futureScope);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profession.profession,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Match Score: ${profession.score}%',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: scopeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: scopeColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.trending_up, color: scopeColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Future Growth Potential: ${profession.futureScope}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          profession.futureScope,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: scopeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Field:${profession.field}',
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Education Required:${profession.educationRequired}',
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Average Salary:${profession.averageSalary}',
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Job Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              profession.information,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Required Skills',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildSkillChips(profession.associatedSkills),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getScopeColor(String years) {
    if (years == 'N/A') return Colors.grey;
    final numYears = int.tryParse(years.split(' ').first) ?? 0;
    if (numYears > 10) return Colors.green;
    if (numYears > 5) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Career Recommendations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchRecommendations,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Error Loading Recommendations',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          error!,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red[700]),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _fetchRecommendations,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                )
              : recommendations.isEmpty
                  ? const Center(
                      child: Text(
                        'No matching professions found',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildChart(),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: recommendations.length,
                              itemBuilder: (context, index) =>
                                  _buildProfessionCard(
                                recommendations[index],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ResumeBuilderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' CQ Resume Builder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ResumeBuilder(),
    );
  }
}

class ResumeData {
  String name = '';
  String email = '';
  String phone = '';
  String address = '';
  String summary = '';
  List<Education> education = [];
  List<Experience> experience = [];
  List<String> skills = [];

  ResumeData();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'summary': summary,
      'education': education.map((e) => e.toJson()).toList(),
      'experience': experience.map((e) => e.toJson()).toList(),
      'skills': skills,
    };
  }

  ResumeData.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    address = json['address'] ?? '';
    summary = json['summary'] ?? '';
    education = (json['education'] as List?)
            ?.map((e) => Education.fromJson(e))
            .toList() ??
        [];
    experience = (json['experience'] as List?)
            ?.map((e) => Experience.fromJson(e))
            .toList() ??
        [];
    skills = (json['skills'] as List?)?.map((e) => e.toString()).toList() ?? [];
  }
}

class Education {
  String institution = '';
  String degree = '';
  String fieldOfStudy = '';
  String startDate = '';
  String endDate = '';
  String description = '';

  Education();

  Map<String, dynamic> toJson() {
    return {
      'institution': institution,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
    };
  }

  Education.fromJson(Map<String, dynamic> json) {
    institution = json['institution'] ?? '';
    degree = json['degree'] ?? '';
    fieldOfStudy = json['fieldOfStudy'] ?? '';
    startDate = json['startDate'] ?? '';
    endDate = json['endDate'] ?? '';
    description = json['description'] ?? '';
  }
}

class Experience {
  String company = '';
  String position = '';
  String startDate = '';
  String endDate = '';
  String description = '';
  List<String> achievements = [];

  Experience();

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'position': position,
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
      'achievements': achievements,
    };
  }

  Experience.fromJson(Map<String, dynamic> json) {
    company = json['company'] ?? '';
    position = json['position'] ?? '';
    startDate = json['startDate'] ?? '';
    endDate = json['endDate'] ?? '';
    description = json['description'] ?? '';
    achievements =
        (json['achievements'] as List?)?.map((e) => e.toString()).toList() ??
            [];
  }
}

class ResumeBuilder extends StatefulWidget {
  @override
  _ResumeBuilderState createState() => _ResumeBuilderState();
}

class _ResumeBuilderState extends State<ResumeBuilder> {
  ResumeData resumeData = ResumeData();
  int _currentStep = 0;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/resume_data.json');
  }

  Future<void> _saveResume() async {
    try {
      final file = await _localFile;
      String jsonData = jsonEncode(resumeData.toJson());
      await file.writeAsString(jsonData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Resume saved successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving resume: $e')),
      );
    }
  }

  Future<void> _loadResume() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        String jsonData = await file.readAsString();
        setState(() {
          resumeData = ResumeData.fromJson(jsonDecode(jsonData));
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Resume loaded successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading resume: $e')),
      );
    }
  }

  Future<void> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text(resumeData.name,
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
            ),
            pw.Paragraph(
                text:
                    '${resumeData.email} | ${resumeData.phone} | ${resumeData.address}'),
            pw.SizedBox(height: 20),
            pw.Header(level: 1, text: 'Professional Summary'),
            pw.Paragraph(text: resumeData.summary),
            pw.SizedBox(height: 20),
            if (resumeData.experience.isNotEmpty) ...[
              pw.Header(level: 1, text: 'Experience'),
              ...resumeData.experience.map((exp) => pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('${exp.position} at ${exp.company}',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text('${exp.startDate} - ${exp.endDate}'),
                        pw.SizedBox(height: 5),
                        pw.Text(exp.description),
                        if (exp.achievements.isNotEmpty) ...[
                          pw.SizedBox(height: 5),
                          pw.Bullet(text: 'Key Achievements:'),
                          ...exp.achievements.map((achievement) => pw.Padding(
                              padding: pw.EdgeInsets.only(left: 20),
                              child: pw.Bullet(text: achievement))),
                        ],
                        pw.SizedBox(height: 15),
                      ])),
            ],
            if (resumeData.education.isNotEmpty) ...[
              pw.Header(level: 1, text: 'Education'),
              ...resumeData.education.map((edu) => pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('${edu.degree} in ${edu.fieldOfStudy}',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text('${edu.institution}'),
                        pw.Text('${edu.startDate} - ${edu.endDate}'),
                        if (edu.description.isNotEmpty)
                          pw.Text(edu.description),
                        pw.SizedBox(height: 15),
                      ])),
            ],
            if (resumeData.skills.isNotEmpty) ...[
              pw.Header(level: 1, text: 'Skills'),
              pw.Wrap(
                  spacing: 10,
                  runSpacing: 5,
                  children: resumeData.skills
                      .map((skill) => pw.Container(
                          padding: pw.EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(),
                              borderRadius: pw.BorderRadius.circular(5)),
                          child: pw.Text(skill)))
                      .toList()),
            ],
          ];
        },
      ),
    );

    // Get temporary directory to save the PDF
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/resume.pdf');
    await file.writeAsBytes(await pdf.save());

    // Show preview and share options
    await Printing.sharePdf(bytes: await pdf.save(), filename: 'resume.pdf');
  }

  @override
  void initState() {
    super.initState();
    _loadResume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resume Builder'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveResume,
            tooltip: 'Save Resume',
          ),
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: _generatePdf,
            tooltip: 'Generate PDF',
          ),
        ],
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: () {
          setState(() {
            if (_currentStep < 3) {
              _currentStep += 1;
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep -= 1;
            }
          });
        },
        steps: [
          Step(
            title: Text('Personal Information'),
            isActive: _currentStep >= 0,
            content: Column(
              children: [
                TextFormField(
                  initialValue: resumeData.name,
                  decoration: InputDecoration(labelText: 'Full Name'),
                  onChanged: (value) {
                    setState(() {
                      resumeData.name = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: resumeData.email,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      resumeData.email = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: resumeData.phone,
                  decoration: InputDecoration(labelText: 'Phone'),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    setState(() {
                      resumeData.phone = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: resumeData.address,
                  decoration: InputDecoration(labelText: 'Address'),
                  onChanged: (value) {
                    setState(() {
                      resumeData.address = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: resumeData.summary,
                  decoration:
                      InputDecoration(labelText: 'Professional Summary'),
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      resumeData.summary = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Step(
            title: Text('Experience'),
            isActive: _currentStep >= 1,
            content: Column(
              children: [
                ...resumeData.experience.asMap().entries.map((entry) {
                  int index = entry.key;
                  Experience exp = entry.value;
                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Experience ${index + 1}',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    resumeData.experience.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                          TextFormField(
                            initialValue: exp.company,
                            decoration: InputDecoration(labelText: 'Company'),
                            onChanged: (value) {
                              setState(() {
                                exp.company = value;
                              });
                            },
                          ),
                          TextFormField(
                            initialValue: exp.position,
                            decoration: InputDecoration(labelText: 'Position'),
                            onChanged: (value) {
                              setState(() {
                                exp.position = value;
                              });
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  initialValue: exp.startDate,
                                  decoration:
                                      InputDecoration(labelText: 'Start Date'),
                                  onChanged: (value) {
                                    setState(() {
                                      exp.startDate = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  initialValue: exp.endDate,
                                  decoration: InputDecoration(
                                      labelText: 'End Date (or Present)'),
                                  onChanged: (value) {
                                    setState(() {
                                      exp.endDate = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            initialValue: exp.description,
                            decoration:
                                InputDecoration(labelText: 'Description'),
                            maxLines: 2,
                            onChanged: (value) {
                              setState(() {
                                exp.description = value;
                              });
                            },
                          ),
                          SizedBox(height: 16),
                          Text('Achievements',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          ...exp.achievements.asMap().entries.map((achEntry) {
                            int achIndex = achEntry.key;
                            String achievement = achEntry.value;
                            return Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue: achievement,
                                    decoration: InputDecoration(
                                        labelText:
                                            'Achievement ${achIndex + 1}'),
                                    onChanged: (value) {
                                      setState(() {
                                        exp.achievements[achIndex] = value;
                                      });
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      exp.achievements.removeAt(achIndex);
                                    });
                                  },
                                ),
                              ],
                            );
                          }).toList(),
                          TextButton.icon(
                            icon: Icon(Icons.add),
                            label: Text('Add Achievement'),
                            onPressed: () {
                              setState(() {
                                exp.achievements.add('');
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Add Experience'),
                  onPressed: () {
                    setState(() {
                      resumeData.experience.add(Experience());
                    });
                  },
                ),
              ],
            ),
          ),
          Step(
            title: Text('Education'),
            isActive: _currentStep >= 2,
            content: Column(
              children: [
                ...resumeData.education.asMap().entries.map((entry) {
                  int index = entry.key;
                  Education edu = entry.value;
                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Education ${index + 1}',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    resumeData.education.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                          TextFormField(
                            initialValue: edu.institution,
                            decoration:
                                InputDecoration(labelText: 'Institution'),
                            onChanged: (value) {
                              setState(() {
                                edu.institution = value;
                              });
                            },
                          ),
                          TextFormField(
                            initialValue: edu.degree,
                            decoration: InputDecoration(labelText: 'Degree'),
                            onChanged: (value) {
                              setState(() {
                                edu.degree = value;
                              });
                            },
                          ),
                          TextFormField(
                            initialValue: edu.fieldOfStudy,
                            decoration:
                                InputDecoration(labelText: 'Field of Study'),
                            onChanged: (value) {
                              setState(() {
                                edu.fieldOfStudy = value;
                              });
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  initialValue: edu.startDate,
                                  decoration:
                                      InputDecoration(labelText: 'Start Date'),
                                  onChanged: (value) {
                                    setState(() {
                                      edu.startDate = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  initialValue: edu.endDate,
                                  decoration: InputDecoration(
                                      labelText: 'End Date (or Expected)'),
                                  onChanged: (value) {
                                    setState(() {
                                      edu.endDate = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            initialValue: edu.description,
                            decoration: InputDecoration(
                                labelText: 'Description (Optional)'),
                            maxLines: 2,
                            onChanged: (value) {
                              setState(() {
                                edu.description = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Add Education'),
                  onPressed: () {
                    setState(() {
                      resumeData.education.add(Education());
                    });
                  },
                ),
              ],
            ),
          ),
          Step(
            title: Text('Skills'),
            isActive: _currentStep >= 3,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    ...resumeData.skills.asMap().entries.map((entry) {
                      int index = entry.key;
                      String skill = entry.value;
                      return Chip(
                        label: Text(skill),
                        deleteIcon: Icon(Icons.cancel),
                        onDeleted: () {
                          setState(() {
                            resumeData.skills.removeAt(index);
                          });
                        },
                      );
                    }).toList(),
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Add Skill',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add_circle),
                      onPressed: () {
                        if (_skillController.text.isNotEmpty &&
                            !resumeData.skills
                                .contains(_skillController.text)) {
                          setState(() {
                            resumeData.skills.add(_skillController.text);
                            _skillController.clear();
                          });
                        }
                      },
                    ),
                  ),
                  controller: _skillController,
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty &&
                        !resumeData.skills.contains(value)) {
                      setState(() {
                        resumeData.skills.add(value);
                        _skillController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final TextEditingController _skillController = TextEditingController();

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }
}

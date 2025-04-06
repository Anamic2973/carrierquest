import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tetsing/widget/q11.dart';

class QuestionPage10 extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage10> {
  double _progress = 0.40; // Initial progress (modify as needed)

  void _updateProgress(double value) {
    setState(() {
      _progress = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8), // Adjust corner radius
              child: Container(
                width: 250, // Set desired width
                height: 10, // Set height for better visibility
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                      const Color.fromARGB(255, 12, 112, 54)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 100,
              width: 350,
              child: Text(
                'Are you interested in research and development?',
                style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
                'assets/images/q10.png'), // Ensure the image path is correct
            const SizedBox(height: 120),

            // Yes button (Rectangular)
            Container(
              width: 300,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionPage11(),
                    ),
                  );
                  // Simulating progress increase on "Yes"
                  _updateProgress((_progress + 0.1).clamp(0.0, 1.0));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 100, 209, 103), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15), // Rectangular button (no rounding)
                  ),
                ),
                child: Text(
                  'Yes ',
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Gap between buttons

            // No button (Rectangular)
            Container(
              width: 300,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Simulating progress reset on "Home"
                  _updateProgress(0.0);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15), // Rectangular button (no rounding)
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
          ],
        ),
      ),
    );
  }
}

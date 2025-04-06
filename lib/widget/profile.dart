import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tetsing/widget/editprofile.dart'; // Import the EditProfileScreen file

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 251, 251),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 254, 254),
        title: Text(
          'Profile',
          style: GoogleFonts.nunito(
            fontSize: 35,
            fontWeight: FontWeight.w800,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        actions: [
          // Edit Button in the top right corner
          IconButton(
            color: const Color.fromARGB(255, 0, 0, 0),
            icon: const Icon(Icons.edit_attributes_rounded),
            onPressed: () {
              // Navigate to EditProfileScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Image with rounded top corners
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Image.asset(
                'assets/images/profileman.webp', // Ensure this image exists in assets
                fit: BoxFit.cover,
              ),
            ),
          ),
          // White Profile Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Row
                  Row(
                    children: [
                      // Profile Image
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: const AssetImage(
                            'assets/images/profileman.webp'), // Default profile image
                      ),
                      const SizedBox(width: 10),
                      // Name & Details
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Neel Litoriya",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "@neel_photography",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Age: 25 | Birthdate: 12 Jan 2000",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Location & Occupation
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.camera_alt, size: 16, color: Colors.grey),
                      SizedBox(width: 5),
                      Text("Photographer",
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(width: 15),
                      Icon(Icons.location_on, size: 16, color: Colors.grey),
                      SizedBox(width: 5),
                      Text("Indore, India",
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

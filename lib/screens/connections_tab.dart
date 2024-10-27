import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectionsTab extends StatelessWidget {
  const ConnectionsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Connections',
          style: GoogleFonts.poppins(
            color: const Color(0xFF333333),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 10, // Replace with actual connection data length
        itemBuilder: (context, index) {
          return _buildConnectionCard(
            name: 'User ${index + 1}',
            jobTitle: 'UX/UI Designer at Company ${index + 1}',
            profileImage: 'assets/profile_placeholder.png', // Replace with actual image path
            onMessageTap: () {
              // Navigate to chat screen
            },
            onViewProfileTap: () {
              // Navigate to profile screen
            },
          );
        },
      ),
    );
  }

  // Connection card widget
  Widget _buildConnectionCard({
    required String name,
    required String jobTitle,
    required String profileImage,
    required VoidCallback onMessageTap,
    required VoidCallback onViewProfileTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(profileImage),
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    jobTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.message, color: Color(0xFF0077B5)), // LinkedIn blue
                  onPressed: onMessageTap,
                  tooltip: 'Message',
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle, color: Color(0xFF0077B5)), // LinkedIn blue
                  onPressed: onViewProfileTap,
                  tooltip: 'View Profile',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

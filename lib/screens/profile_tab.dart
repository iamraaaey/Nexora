import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart'; // File picker for resume upload
import 'dart:io';
import 'edit_profile_screen.dart';
import 'settings_screen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _name = 'Raynold Kabai';
  String _title = 'Product Designer & UI Designer';
  String _location = 'Samarahan, Sarawak'; // Updated location
  String _avatarUrl = 'assets/profile_placeholder.png';
  File? _resumeFile; // Variable to store the uploaded resume file

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Update profile information after editing
  void _updateProfile(Map<String, dynamic> updatedData) {
    setState(() {
      _name = updatedData['name'];
      _title = updatedData['title'];
      _location = updatedData['location'];
      _avatarUrl = updatedData['avatarUrl'];
    });
  }

  // Function to handle resume file selection
  Future<void> _uploadResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _resumeFile = File(result.files.single.path!);
      });

      // Simulate an upload process (this would be replaced with actual upload logic)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Resume uploaded: ${result.files.single.name}', style: GoogleFonts.poppins())),
      );
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F1F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            color: const Color(0xFF3C3C3C),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF51cacc),
          labelColor: const Color(0xFF51cacc),
          unselectedLabelColor: Colors.grey,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: "Profile"),
            Tab(text: "Career Tools"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProfileTab(context), // Profile Tab
          _buildCareerToolsTab(),    // Career Tools Tab
        ],
      ),
    );
  }

  // Tab 1: Profile Tab (existing profile details, enhanced UI)
  Widget _buildProfileTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 30),
          _buildAccountOptions(context),
          const SizedBox(height: 30),
          _buildSkillsSection(),
          const SizedBox(height: 30),
          _buildAboutSection(),
        ],
      ),
    );
  }

  // Profile header with avatar, name, and title
  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: _avatarUrl.startsWith('assets/')
              ? AssetImage(_avatarUrl) as ImageProvider
              : FileImage(File(_avatarUrl)),
          backgroundColor: Colors.grey.shade200,
        ),
        const SizedBox(height: 15),
        Text(
          _name,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF3C3C3C),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          _title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, color: Colors.grey, size: 16),
            const SizedBox(width: 5),
            Text(
              _location,
              style: GoogleFonts.poppins(color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }

  // Account options with Edit Profile, Settings, and Log Out
  Widget _buildAccountOptions(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      shadowColor: const Color(0xFF51cacc).withOpacity(0.2),
      child: Column(
        children: [
          _buildOptionTile(context, Icons.edit, "Edit Profile", () async {
            final updatedData = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditProfileScreen()),
            );
            if (updatedData != null) {
              _updateProfile(updatedData);
            }
          }),
          const Divider(height: 1),
          _buildOptionTile(context, Icons.settings, "Settings", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          }),
          const Divider(height: 1),
          _buildOptionTile(context, Icons.logout, "Log Out", () {
            _showLogoutConfirmation(context);
          }),
        ],
      ),
    );
  }

  // Build each option tile (Edit, Settings, Logout)
  Widget _buildOptionTile(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF51cacc)),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  // Career Tools Tab
  Widget _buildCareerToolsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Career Tools',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3C3C3C),
            ),
          ),
          const SizedBox(height: 20),
          _buildCareerToolTile(Icons.file_upload, "Upload Resume", _uploadResume),
          const Divider(),
          _buildCareerToolTile(Icons.work_outline, "View Job Applications", () {
            // Handle viewing job applications
          }),
          const SizedBox(height: 20),
          if (_resumeFile != null)
            Text(
              'Uploaded Resume: ${_resumeFile!.path.split('/').last}',
              style: GoogleFonts.poppins(color: Colors.black54),
            ),
        ],
      ),
    );
  }

  // Career Tool Option Tile
  Widget _buildCareerToolTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF51cacc)),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  // Skills section for user's skills
  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF3C3C3C)),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildSkillChip('UI/UX Design'),
            _buildSkillChip('Prototyping'),
            _buildSkillChip('User Research'),
            _buildSkillChip('Adobe XD'),
            _buildSkillChip('Figma'),
          ],
        ),
      ],
    );
  }

  // Chip widget for each skill
  Widget _buildSkillChip(String skill) {
    return Chip(
      label: Text(
        skill,
        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      backgroundColor: const Color(0xFF51cacc),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    );
  }

  // About section for user description or bio
  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF3C3C3C)),
        ),
        const SizedBox(height: 10),
        Text(
          'Enthusiastic and creative UI/UX designer with 5+ years of experience in designing user-centered digital experiences. Passionate about creating impactful designs that meet business objectives and deliver value to users.',
          style: GoogleFonts.poppins(color: Colors.black54, fontSize: 16),
        ),
      ],
    );
  }

  // Show logout confirmation dialog
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Log Out"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF51cacc)),
              child: const Text("Log Out"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }
}

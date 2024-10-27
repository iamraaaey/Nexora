import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'avatar_selection_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'Raynold Kabai');
  final TextEditingController _titleController = TextEditingController(text: 'Product Designer & UI Designer');
  String _avatarUrl = 'assets/profile_placeholder.png'; // Default avatar path

  // List of states and cities in Malaysia
  final Map<String, List<String>> _malaysiaLocations = {
    'Johor': ['Johor Bahru', 'Batu Pahat', 'Muar', 'Kluang'],
    'Kedah': ['Alor Setar', 'Sungai Petani', 'Kulim', 'Langkawi'],
    'Kelantan': ['Kota Bharu', 'Tanah Merah', 'Machang', 'Pasir Mas'],
    'Malacca': ['Malacca City', 'Alor Gajah', 'Jasin'],
    'Negeri Sembilan': ['Seremban', 'Port Dickson', 'Nilai'],
    'Pahang': ['Kuantan', 'Temerloh', 'Bentong', 'Raub'],
    'Penang': ['George Town', 'Butterworth', 'Batu Ferringhi'],
    'Perak': ['Ipoh', 'Taiping', 'Lumut', 'Teluk Intan'],
    'Perlis': ['Kangar', 'Padang Besar'],
    'Sabah': ['Kota Kinabalu', 'Sandakan', 'Tawau', 'Lahad Datu'],
    'Sarawak': ['Kuching', 'Miri', 'Sibu', 'Bintulu'],
    'Selangor': ['Shah Alam', 'Petaling Jaya', 'Klang', 'Ampang'],
    'Terengganu': ['Kuala Terengganu', 'Dungun', 'Kemaman'],
    'Kuala Lumpur': ['Bukit Bintang', 'Titiwangsa', 'Seputeh'],
    'Putrajaya': ['Putrajaya'],
    'Labuan': ['Labuan'],
  };

  // Selected state and city
  String _selectedState = 'Johor';
  String _selectedCity = 'Johor Bahru';

  // Update avatar when selected from AvatarSelectionScreen
  void _updateAvatar(String newAvatarUrl) {
    setState(() {
      _avatarUrl = newAvatarUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF51cacc),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Profile Picture'),
            const SizedBox(height: 10),
            Center(
              child: GestureDetector(
                onTap: () async {
                  // Navigate to AvatarSelectionScreen and wait for a result
                  final selectedAvatarUrl = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AvatarSelectionScreen(currentStep: 3),
                    ),
                  );
                  if (selectedAvatarUrl != null) {
                    _updateAvatar(selectedAvatarUrl);
                  }
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _avatarUrl.startsWith('assets/')
                      ? AssetImage(_avatarUrl) as ImageProvider
                      : FileImage(File(_avatarUrl)),
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Personal Information'),
            const SizedBox(height: 10),
            _buildTextField('Full Name', _nameController),
            const SizedBox(height: 15),
            _buildTextField('Job Title', _titleController),
            const SizedBox(height: 15),
            _buildStateDropdown(),
            const SizedBox(height: 15),
            _buildCityDropdown(),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Pass the updated profile data back to ProfileTab
                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'title': _titleController.text,
                    'location': '$_selectedCity, $_selectedState',
                    'avatarUrl': _avatarUrl,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF51cacc),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF3C3C3C)),
    );
  }

  // Text field builder for profile input
  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  // Dropdown for selecting a state
  Widget _buildStateDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'State',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: _selectedState,
          items: _malaysiaLocations.keys.map((state) {
            return DropdownMenuItem<String>(
              value: state,
              child: Text(state, style: GoogleFonts.poppins(fontSize: 16)),
            );
          }).toList(),
          onChanged: (newState) {
            setState(() {
              _selectedState = newState!;
              _selectedCity = _malaysiaLocations[_selectedState]![0]; // Reset city when state changes
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  // Dropdown for selecting a city based on selected state
  Widget _buildCityDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'City',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: _selectedCity,
          items: _malaysiaLocations[_selectedState]!.map((city) {
            return DropdownMenuItem<String>(
              value: city,
              child: Text(city, style: GoogleFonts.poppins(fontSize: 16)),
            );
          }).toList(),
          onChanged: (newCity) {
            setState(() {
              _selectedCity = newCity!;
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

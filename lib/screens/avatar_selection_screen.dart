import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AvatarSelectionScreen extends StatefulWidget {
  final int currentStep;

  const AvatarSelectionScreen({super.key, required this.currentStep});

  @override
  _AvatarSelectionScreenState createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // Predefined avatar paths
  final List<String> _avatarPaths = [
    'assets/avatars/avatar1.png',
    'assets/avatars/avatar2.png',
    'assets/avatars/avatar3.png',
    'assets/avatars/avatar4.png',
    'assets/avatars/avatar5.png',
  ];

  // Pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      Navigator.pop(context, pickedFile.path); // Return selected custom image path
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Select Your Avatar'),
        backgroundColor: const Color(0xFF0077FF),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Progress Indicator (Step 3 of 3)
                _buildProgressIndicator(currentStep: widget.currentStep),
                const SizedBox(height: 20),

                // Avatar Grid
                _buildAvatarGrid(),

                const SizedBox(height: 20),

                // Choose Image from Gallery Button
                ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    backgroundColor: const Color(0xFF0077FF),
                  ),
                  child: const Text(
                    'Choose from Gallery',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),

                const SizedBox(height: 20),

                // Save & Continue Button (Only enables if an avatar is selected)
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    onPressed: _selectedImage != null
                        ? () {
                            Navigator.pop(context, _selectedImage!.path); // Return selected avatar
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor: _selectedImage != null
                          ? const Color(0xFF0077FF)
                          : Colors.grey, // Disabled state if no avatar is selected
                    ),
                    child: const Text(
                      'Save & Continue',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build grid of predefined avatars
  Widget _buildAvatarGrid() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: _avatarPaths.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        final avatarPath = _avatarPaths[index];
        final isSelected = _selectedImage?.path == avatarPath;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedImage = File(avatarPath);
            });
            Navigator.pop(context, avatarPath); // Return selected avatar path
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF0077FF) : Colors.grey.shade300,
                    width: isSelected ? 4 : 2,
                  ),
                  boxShadow: isSelected
                      ? [const BoxShadow(color: Colors.blueAccent, blurRadius: 10, spreadRadius: 2)]
                      : [],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    avatarPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (isSelected)
                const Positioned(
                  bottom: 5,
                  right: 5,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 24,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // Progress Indicator (Step 3 of 3)
  Widget _buildProgressIndicator({required int currentStep}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepCircle(isActive: currentStep >= 1),
        _buildProgressLine(isActive: currentStep >= 2),
        _buildStepCircle(isActive: currentStep >= 2),
        _buildProgressLine(isActive: currentStep >= 3),
        _buildStepCircle(isActive: currentStep >= 3),
      ],
    );
  }

  // Step Circle
  Widget _buildStepCircle({required bool isActive}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0077FF) : Colors.grey.shade300,
        shape: BoxShape.circle,
        boxShadow: isActive
            ? [const BoxShadow(color: Colors.blueAccent, blurRadius: 10, spreadRadius: 2)]
            : [],
      ),
      child: Center(
        child: Icon(
          isActive ? Icons.check : null,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }

  // Progress Line
  Widget _buildProgressLine({required bool isActive}) {
    return Container(
      width: 80,
      height: 4,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0077FF) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';
import 'education_details_screen.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  _SetupProfileScreenState createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _gender;
  String? _jobType;
  String? _preferredIndustry;

  // Progress management variables
  int _currentStep = 1;
  bool _isLoading = false;

  // Validation logic for required fields
  String? _validateRequiredField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Phone validation
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty || value.length != 10) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  // Simulate loading progress using a Timer
  Future<void> _simulateProgress() async {
    setState(() {
      _isLoading = true;
    });

    for (int i = 1; i <= 3; i++) {
      await Future.delayed(const Duration(seconds: 1));  // Simulate progress step by step
      setState(() {
        _currentStep = i;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Progress Indicator (Step 1 of 3)
                  _buildProgressIndicator(currentStep: _currentStep),

                  const SizedBox(height: 30),

                  // Title
                  const Text(
                    'Setup Your Profile',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003366),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),

                  // Subtitle
                  const Text(
                    'Complete your profile so we can deliver the best job matches for you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Form Fields
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Name Field
                        _buildTextField(
                          label: 'Name',
                          controller: _nameController,
                          validator: (value) => _validateRequiredField(value, 'Name'),
                        ),
                        const SizedBox(height: 15),

                        // Mobile Number Field
                        _buildTextField(
                          label: 'Mobile Number',
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                          validator: _validatePhoneNumber,
                        ),
                        const SizedBox(height: 15),

                        // Age Field
                        _buildTextField(
                          label: 'Age',
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          validator: (value) => _validateRequiredField(value, 'Age'),
                        ),
                        const SizedBox(height: 15),

                        // Gender Dropdown
                        _buildDropdownField(
                          label: 'Gender',
                          value: _gender,
                          items: ['Male', 'Female', 'Other'],
                          onChanged: (String? value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                          validator: (value) => _validateRequiredField(value, 'Gender'),
                        ),
                        const SizedBox(height: 15),

                        // Job Type Dropdown
                        _buildDropdownField(
                          label: 'Preferred Job Type',
                          value: _jobType,
                          items: ['Full-time', 'Part-time', 'Freelance'],
                          onChanged: (String? value) {
                            setState(() {
                              _jobType = value;
                            });
                          },
                          validator: (value) => _validateRequiredField(value, 'Job Type'),
                        ),
                        const SizedBox(height: 15),

                        // Preferred Industry Dropdown
                        _buildDropdownField(
                          label: 'Preferred Industry',
                          value: _preferredIndustry,
                          items: ['Technology', 'Business', 'Healthcare', 'Education', 'Other'],
                          onChanged: (String? value) {
                            setState(() {
                              _preferredIndustry = value;
                            });
                          },
                          validator: (value) => _validateRequiredField(value, 'Industry'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Save & Continue Button
                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        backgroundColor: const Color(0xFF0077FF),
                      ),
                      onPressed: _isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                _simulateProgress().then((_) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const EducationDetailsScreen(
                                          currentStep: 2),  // Passing progress step
                                    ),
                                  );
                                });
                              }
                            },
                      child: const Text(
                        'Save & Continue',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Skip for Now
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Text(
                      'Skip For Now',
                      style: TextStyle(color: Color(0xFF0077FF)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Progress Indicator
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

  // Helper method to build dropdown fields
  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required FormFieldValidator<String?> validator,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
      value: value,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      validator: validator,
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
      validator: validator,
    );
  }
}

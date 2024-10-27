import 'package:flutter/material.dart';

class EducationDetailsScreen extends StatefulWidget {
  final int currentStep;

  const EducationDetailsScreen({super.key, required this.currentStep});

  @override
  _EducationDetailsScreenState createState() => _EducationDetailsScreenState();
}

class _EducationDetailsScreenState extends State<EducationDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _educationLevel;
  String? _fieldOfStudy;
  final TextEditingController institutionController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();

  // Validation logic for required fields
  String? _validateRequiredField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
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
                  // Progress Indicator (Step 2 of 3)
                  _buildProgressIndicator(currentStep: widget.currentStep),

                  const SizedBox(height: 30),

                  // Title for the education details section
                  const Text(
                    'Enter Your Education Details',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003366),  // Consistent color with other screens
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Container for the form fields to ensure consistent width
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),  // Consistent width
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Dropdown for selecting education level
                        _buildDropdownField(
                          label: 'Level of Education',
                          value: _educationLevel,
                          items: ['High School', 'Undergraduate', 'Postgraduate', 'Doctorate'],
                          onChanged: (String? value) {
                            setState(() {
                              _educationLevel = value;
                            });
                          },
                          validator: (value) => _validateRequiredField(value, 'Level of Education'),
                        ),
                        const SizedBox(height: 15),

                        // Dropdown for selecting field of study
                        _buildDropdownField(
                          label: 'Field of Study',
                          value: _fieldOfStudy,
                          items: ['Computer Science', 'Business', 'Engineering', 'Medicine', 'Other'],
                          onChanged: (String? value) {
                            setState(() {
                              _fieldOfStudy = value;
                            });
                          },
                          validator: (value) => _validateRequiredField(value, 'Field of Study'),
                        ),
                        const SizedBox(height: 15),

                        // Text field for institution/university name
                        _buildTextField(
                          controller: institutionController,
                          label: 'Institution/University Name',
                          validator: (value) => _validateRequiredField(value, 'Institution/University Name'),
                        ),
                        const SizedBox(height: 15),

                        // Text field for year of graduation/completion
                        _buildTextField(
                          controller: yearController,
                          label: 'Year of Graduation/Completion',
                          keyboardType: TextInputType.number,
                          validator: (value) => _validateRequiredField(value, 'Year of Completion'),
                        ),
                        const SizedBox(height: 15),

                        // Optional text field for Grade/CGPA
                        _buildTextField(
                          controller: gradeController,
                          label: 'Grade/CGPA (Optional)',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Save & Continue button to proceed to the next screen
                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, '/avatar_selection');  // Navigate to Avatar Selection Screen
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        backgroundColor: const Color(0xFF0077FF),
                      ),
                      child: const Text(
                        'Save & Continue',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Skip for Now button to allow skipping this step
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');  // Skip setup
                      },
                      child: const Text(
                        'Skip For Now',
                        style: TextStyle(color: Color(0xFF0077FF)),  // Sync color with other buttons
                      ),
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

  // Progress Indicator widget for tracking steps (Step 2 of 3)
  Widget _buildProgressIndicator({required int currentStep}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepCircle(isActive: currentStep >= 1), // Step 1 circle
        _buildProgressLine(isActive: currentStep >= 2), // Line between steps
        _buildStepCircle(isActive: currentStep >= 2), // Step 2 circle
        _buildProgressLine(isActive: currentStep >= 3), // Line between steps
        _buildStepCircle(isActive: currentStep >= 3), // Step 3 circle
      ],
    );
  }

  // Step Circle widget to represent individual steps
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

  // Progress Line widget to connect step circles
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
        ), //OutlineInputBorder
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
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    FormFieldValidator<String?>? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ), //OutlineInputBorder
        filled: true,
        fillColor: Colors.grey.shade100,
      ), //InputDecoration
      validator: validator,
    );
  }
}

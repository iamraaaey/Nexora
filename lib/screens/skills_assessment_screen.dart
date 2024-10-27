import 'dart:async';
import 'package:flutter/material.dart';

class SkillsAssessmentScreen extends StatefulWidget {
  const SkillsAssessmentScreen({super.key});

  @override
  _SkillsAssessmentScreenState createState() => _SkillsAssessmentScreenState();
}

class _SkillsAssessmentScreenState extends State<SkillsAssessmentScreen>
    with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  late Future<List<Map<String, dynamic>>> _futureQuestions;

  final Map<String, dynamic> _answers = {}; // Use question strings as keys

  @override
  void initState() {
    super.initState();
    _futureQuestions = _fetchQuestions(); // Fetch questions from a dummy online source
  }

  // Simulate fetching data from an online source with Future
  Future<List<Map<String, dynamic>>> _fetchQuestions() async {
    // Simulating network delay
    await Future.delayed(const Duration(seconds: 2));

    return [
      {
        'question': 'Which of the following describes your proficiency in project management?',
        'options': ['Beginner', 'Intermediate', 'Advanced', 'Expert'],
      },
      {
        'question': 'How would you rate your communication skills?',
        'options': ['Poor', 'Average', 'Good', 'Excellent'],
      },
      {
        'question': 'Have you worked in a team-based environment?',
        'options': ['Never', 'Occasionally', 'Frequently', 'Always'],
      },
      {
        'question': 'Which design tools are you familiar with?',
        'options': ['Figma', 'Adobe XD', 'Sketch', 'Canva'],
      },
    ];
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    } else {
      _showResults();
    }
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Assessment Complete! 🎉'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Based on your answers, here are the areas to improve or explore further:'),
              const SizedBox(height: 16),
              _buildImprovementCard('Project Management', _answers['Which of the following describes your proficiency in project management?']),
              _buildImprovementCard('Communication Skills', _answers['How would you rate your communication skills?']),
              _buildImprovementCard('Team Collaboration', _answers['Have you worked in a team-based environment?']),
              _buildImprovementCard('Design Tools', _answers['Which design tools are you familiar with?']),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Go back to previous screen
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Widget _buildImprovementCard(String skill, dynamic answer) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(Icons.trending_up, color: Color(0xFF51cacc)),  // Teal color for icon
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                '$skill: ${answer ?? 'No answer provided'}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),  // Soft, flat background
      appBar: _buildAppBar(), // Use the corrected AppBar
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureQuestions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading indicator
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading questions'));
          }

          if (snapshot.hasData) {
            var questions = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildCircularProgressIndicator(questions.length),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: _buildQuestionCard(questions[_currentStep]['question']),
                  ),
                  const SizedBox(height: 30),
                  _buildAnswerOptions(
                      questions[_currentStep]['question'],
                      questions[_currentStep]['options']
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('No questions available'));
        },
      ),
      floatingActionButton: _buildNextButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Positioned at bottom center
    );
  }

  // Enhanced appBar with gradient background
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF51cacc), Color(0xFF2BB1B2)],  // Gradient Teal colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: const Text(
        'Skills Assessment',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.home,
          color: Colors.white,  // White icon for home
        ),
        onPressed: () {
          Navigator.pop(context); // Go back to home screen
        },
      ),
    );
  }

  // Modern Circular Progress Indicator
  Widget _buildCircularProgressIndicator(int questionCount) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: (_currentStep + 1) / questionCount,
                strokeWidth: 8,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF51cacc)),  // Teal progress color
              ),
              Center(
                child: Text(
                  '${((_currentStep + 1) / questionCount * 100).round()}%', // Percentage text
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF51cacc),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Question ${_currentStep + 1} of $questionCount',  // Display the current step
          style: const TextStyle(fontSize: 16, color: Color(0xFF3C3C3C)),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(String question) {
    return Container(
      key: ValueKey(question), // Key for AnimatedSwitcher
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 5), // Slight elevation shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Text(
          question,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF3C3C3C), // Dark gray for better readability
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerOptions(String question, List<String> options) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: options.map((option) {
        return ChoiceChip(
          label: Text(option),
          selected: _answers[question] == option,
          selectedColor: const Color(0xFF51cacc),
          backgroundColor: Colors.grey.shade200,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          labelStyle: TextStyle(
            color: _answers[question] == option ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
          onSelected: (selected) {
            setState(() {
              _answers[question] = option;  // Now use the question as the key
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildNextButton() {
    bool allAnswered = _answers.values.isNotEmpty && _answers.length > _currentStep;

    return GestureDetector(
      onTap: allAnswered ? _nextStep : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: allAnswered ? 1.0 : 0.5,
        child: Container(
          height: 50,
          width: 180,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF51cacc), Color(0xFF2BB1B2)],  // Gradient Teal colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.withOpacity(0.4),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _currentStep == 3 ? 'Finish' : 'Next',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ), //AnimatedOpacity
    ); //Gesture Detection
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isNotificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF51cacc),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNotificationToggle(),
            const SizedBox(height: 30),
            _buildSettingTile(
              context,
              icon: Icons.lock,
              title: 'Change Password',
              onTap: () => Navigator.pushNamed(context, '/change_password'),
            ),
            const SizedBox(height: 20),
            _buildSettingTile(
              context,
              icon: Icons.article,
              title: 'Terms and Conditions',
              onTap: () => _showTermsAndConditionsDialog(context),
            ),
            const SizedBox(height: 20),
            _buildSettingTile(
              context,
              icon: Icons.privacy_tip,
              title: 'Privacy Policy',
              onTap: () => _showPrivacyPolicyDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationToggle() {
    return SwitchListTile(
      title: Text(
        'Notifications',
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      value: _isNotificationsEnabled,
      activeColor: const Color(0xFF51cacc),
      onChanged: (bool value) {
        setState(() {
          _isNotificationsEnabled = value;
        });
      },
      secondary: const Icon(Icons.notifications, color: Color(0xFF51cacc)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }

  Widget _buildSettingTile(BuildContext context,
      {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF51cacc)),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  void _showTermsAndConditionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Terms and Conditions', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          content: SingleChildScrollView(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(color: Colors.black87),
                children: [
                  TextSpan(text: 'Terms and Conditions for Nexora App\n\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'Effective Date: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '14/10/2024\n\n'),
                  TextSpan(text: 'Welcome to the Nexora App! ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'These terms and conditions outline the rules and regulations for the use of Nexora\'s mobile application.\n\n'),
                  TextSpan(text: '1. Use of the App: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'You agree to use the Nexora App only for lawful purposes and in accordance with these terms.\n\n'),
                  TextSpan(text: '2. User Accounts: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'To access certain features of the app, you may be required to create an account. You are responsible for maintaining the confidentiality of your account information.\n\n'),
                  TextSpan(text: '3. Content: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'The Nexora App allows users to post content, including but not limited to job postings, resumes, and profiles. You are responsible for the content you post and must ensure it complies with applicable laws.\n\n'),
                  TextSpan(text: '4. Intellectual Property: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'The Nexora App and its content are protected by copyright, trademark, and other intellectual property rights. You may not reproduce, distribute, or create derivative works without express permission.\n\n'),
                  TextSpan(text: '5. Limitation of Liability: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'Nexora shall not be liable for any direct, indirect, incidental, or consequential damages arising from the use of the app.\n\n'),
                  TextSpan(text: '6. Changes to Terms: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'We may update these terms from time to time. Changes will be effective immediately upon posting the new terms in the app.\n\n'),
                  TextSpan(text: 'If you have any questions about these terms, please contact us at support@nexora.com.'),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('OK', style: GoogleFonts.poppins()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Privacy Policy', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          content: SingleChildScrollView(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(color: Colors.black87),
                children: [
                  TextSpan(text: 'Privacy Policy for Nexora App\n\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'Effective Date: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '14/10/2024\n\n'),
                  TextSpan(text: 'At Nexora, we are committed to protecting your privacy. ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application.\n\n'),
                  TextSpan(text: '1. Information We Collect: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'We may collect personal information, such as your name, email address, and location, when you register for an account or use certain features of the app.\n\n'),
                  TextSpan(text: '2. Use of Information: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'We may use the information we collect to:\n'),
                  TextSpan(text: '   - Provide and maintain our app\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '   - Notify you about changes to our app\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '   - Allow you to participate in interactive features when you choose to do so\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '   - Provide customer support\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '   - Gather analysis or valuable information so that we can improve the app\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '   - Monitor the usage of the app\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '   - Detect, prevent, and address technical issues\n\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '3. Data Security: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'The security of your data is important to us, but remember that no method of transmission over the Internet or method of electronic storage is 100% secure.\n\n'),
                  TextSpan(text: '4. Changes to Privacy Policy: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.\n\n'),
                  TextSpan(text: 'If you have any questions about this Privacy Policy, please contact us at support@nexora.com.'),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('OK', style: GoogleFonts.poppins()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

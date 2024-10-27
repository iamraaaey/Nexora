import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GrowthHubTab extends StatelessWidget {
  const GrowthHubTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white, // White background for AppBar
          title: Text(
            'Growth Hub',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true, // Center-align the title
          elevation: 0, // Remove shadow for a flat look
          bottom: TabBar(
            indicatorColor: const Color(0xFF51cacc), // Custom teal color for active tab underline
            indicatorWeight: 3, // Thickness of the underline indicator
            labelColor: const Color(0xFF51cacc), // Active tab text color
            unselectedLabelColor: Colors.grey, // Inactive tab text color
            labelStyle: GoogleFonts.poppins(fontSize: 16), // Active tab text style with Poppins font
            tabs: const [
              Tab(text: 'Mentorship'),
              Tab(text: 'Training'),
              Tab(text: 'Business Support'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MentorshipTab(),
            TrainingTab(),
            BusinessSupportTab(),
          ],
        ),
      ),
    );
  }
}

class MentorshipTab extends StatelessWidget {
  const MentorshipTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Section(
            title: 'Mentorship and Networking',
            children: [
              FeatureCard(
                icon: Icons.people_outline,
                title: 'Mentorship Program',
                description: 'Connect with mentors for career advice and job support.',
              ),
              FeatureCard(
                icon: Icons.group,
                title: 'Virtual Networking',
                description: 'Network with peers and professionals in community hubs.',
              ),
              FeatureCard(
                icon: Icons.video_call,
                title: 'Live Webinars',
                description: 'Attend webinars with industry experts on career growth.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TrainingTab extends StatelessWidget {
  const TrainingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Section(
            title: 'Online Training and Upskilling',
            children: [
              FeatureCard(
                icon: Icons.school,
                title: 'Skills Development',
                description: 'Access courses and certifications in high-demand fields.',
              ),
              FeatureCard(
                icon: Icons.build,
                title: 'Vocational Training',
                description: 'Train in practical skills for local industries.',
              ),
              FeatureCard(
                icon: Icons.timeline,
                title: 'Learning Paths',
                description: 'Follow curated paths for essential skills like coding.',
              ),
              FeatureCard(
                icon: Icons.badge,
                title: 'Completion Badges',
                description: 'Earn badges and certifications to showcase on your CV.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BusinessSupportTab extends StatelessWidget {
  const BusinessSupportTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Section(
            title: 'Local Business Support and Entrepreneurship',
            children: [
              FeatureCard(
                icon: Icons.business_center,
                title: 'Small Business Support',
                description: 'Learn to start and manage small businesses locally.',
              ),
              FeatureCard(
                icon: Icons.monetization_on,
                title: 'Microfinance and Grants',
                description: 'Get microloans and grants for your business idea.',
              ),
              FeatureCard(
                icon: Icons.work_outline,
                title: 'Local Job Creation',
                description: 'Promote job openings within the community.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const Section({required this.title, required this.children, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: const Color(0xFF51cacc),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 40, color: const Color(0xFF51cacc)), // Icon color set to teal
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          description,
          style: GoogleFonts.poppins(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        splashColor: const Color(0xFF51cacc).withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

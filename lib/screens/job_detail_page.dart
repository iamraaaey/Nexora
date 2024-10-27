import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobDetailPage extends StatelessWidget {
  final String jobTitle;
  final String company;
  final String location;
  final String salary;
  final int totalCandidates;
  final String newApplicants;
  final String jobDescription;

  const JobDetailPage({
    Key? key,
    required this.jobTitle,
    required this.company,
    required this.location,
    required this.salary,
    required this.totalCandidates,
    required this.newApplicants,
    required this.jobDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF51cacc),
        elevation: 2,
        title: Text(
          'Job Details',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildJobDetails(),
            const SizedBox(height: 20),
            _buildApplicantStats(),
            const SizedBox(height: 20),
            _buildDescription(),
            const SizedBox(height: 20),
            _buildReviews(),
            const SizedBox(height: 30),
            _buildApplyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: const Color(0xFF51cacc).withOpacity(0.3),
          child: const Icon(Icons.business, size: 50, color: Color(0xFF51cacc)),
        ),
        const SizedBox(height: 12),
        Text(
          jobTitle,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF51cacc),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          company,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildJobDetails() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInfoBadge('Location', location),
            _buildInfoBadge('Job Type', 'Full Time'),
            _buildInfoBadge('Salary', salary),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicantStats() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatBadge('Total Applicants', totalCandidates.toString()),
            _buildStatBadge('New Applicants', newApplicants),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBadge(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF51cacc),
          ),
        ),
      ],
    );
  }

  Widget _buildStatBadge(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF51cacc),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Job Description',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF51cacc),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              jobDescription,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviews() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reviews',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF51cacc),
              ),
            ),
            const SizedBox(height: 8),
            _buildReviewItem('John Doe', 'Great company to work with!'),
            const Divider(),
            _buildReviewItem('Jane Smith', 'Supportive team and amazing projects!'),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewItem(String reviewer, String review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          reviewer,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF51cacc),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          review,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildApplyButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF51cacc),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        ),
        child: Text(
          'Apply Now',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

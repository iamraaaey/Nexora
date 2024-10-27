import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'job_detail_page.dart';

class MyJobTab extends StatefulWidget {
  const MyJobTab({Key? key}) : super(key: key);

  @override
  State<MyJobTab> createState() => _MyJobTabState();
}

class _MyJobTabState extends State<MyJobTab> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _userLocation;
  late TabController _tabController;

  final Color primaryColor = const Color(0xFF51cacc);
  final Color accentColor = const Color(0xFF83C5BE);
  final Color cardBackgroundColor = const Color(0xFFEDF6F9);
  final Color titleColor = const Color(0xFF222222);
  final Color subtextColor = const Color(0xFF555555);

  final List<Map<String, dynamic>> _dummyJobs = [
    {'title': 'Account Executive', 'company': 'Borneo International', 'location': 'Kuching, Sarawak'},
    {'title': 'Product Designer', 'company': 'ABC Corp', 'location': 'New York, USA'},
    {'title': 'UX Designer', 'company': 'Booking', 'location': 'Jakarta, Indonesia'},
    {'title': 'Software Engineer', 'company': 'XYZ Inc.', 'location': 'San Francisco, USA'},
    {'title': 'Graphic Designer', 'company': 'Creative Studio', 'location': 'Bandung, Indonesia'},
    {'title': 'Mobile Developer', 'company': 'TechHub', 'location': 'Singapore'},
    {'title': 'Software Engineer', 'company': 'Petronas', 'location': 'Kuala Lumpur, Malaysia'},
  ];

  final List<Map<String, dynamic>> _appliedJobs = []; // List to store applied jobs

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      _showSnackBar('Please enable location services');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      _showSnackBar('Location permissions are permanently denied');
      return;
    } else if (permission != LocationPermission.denied) {
      Position position = await Geolocator.getCurrentPosition();
      setState(() => _userLocation = '${position.latitude}, ${position.longitude}');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  List<Map<String, dynamic>> _getFilteredJobs() {
    if (_searchQuery.isEmpty && _userLocation == null) return _dummyJobs;

    return _dummyJobs.where((job) {
      final matchesTitle = job['title'].toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesLocation = _userLocation == null ||
          job['location'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          job['location'].toLowerCase().contains(_userLocation!.toLowerCase());
      return matchesTitle || matchesLocation;
    }).toList();
  }

  void _applyForJob(Map<String, dynamic> job) {
    // Add job to applied list if it's not already there
    if (!_appliedJobs.any((appliedJob) => appliedJob['title'] == job['title'])) {
      setState(() {
        _appliedJobs.add(job);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Applied to ${job['title']} successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have already applied for ${job['title']}.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredJobs = _getFilteredJobs();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'My Job',
          style: GoogleFonts.poppins(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: primaryColor,
              indicatorWeight: 3,
              labelColor: primaryColor,
              unselectedLabelColor: Colors.grey,
              labelStyle: GoogleFonts.poppins(fontSize: 16),
              tabs: const [
                Tab(text: 'Saved Jobs'),
                Tab(text: 'Applied Jobs'),
                Tab(text: 'Browse History'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent(filteredJobs, 'You haven\'t saved a job yet', 'Save jobs and apply later.'),
          _buildTabContent(_appliedJobs, 'You haven\'t applied to any jobs yet', 'Apply to jobs and track them here.'),
          _buildTabContent([], 'No browsing history', 'View jobs you\'ve browsed here.'),
        ],
      ),
    );
  }

  Widget _buildTabContent(List<Map<String, dynamic>> jobs, String emptyTitle, String emptySubtitle) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          const SizedBox(height: 20),
          jobs.isNotEmpty ? _buildSectionTitle('Suggested Jobs') : Container(),
          jobs.isNotEmpty
              ? Column(children: jobs.map((job) => _buildJobCard(context, job)).toList())
              : _buildEmptyState(emptyTitle, emptySubtitle),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: subtextColor)),
            const SizedBox(height: 8),
            Text(subtitle, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 16, color: Colors.black45)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.white),
              label: Text('Search Jobs', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Search by job title or location',
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: titleColor));
  }

  Widget _buildJobCard(BuildContext context, Map<String, dynamic> job) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailPage(
              jobTitle: job['title'],
              company: job['company'],
              location: job['location'],
              salary: 'MYR 2,500 - MYR 3,500',
              totalCandidates: 50,
              newApplicants: '5 New Applicants',
              jobDescription: 'Details about the job at ${job['company']}',
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16.0),
        color: cardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(job['title'], style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: titleColor)),
                  Icon(Icons.bookmark_border, color: Colors.grey[400]),
                ],
              ),
              const SizedBox(height: 4),
              Text(job['company'], style: GoogleFonts.poppins(fontSize: 16, color: subtextColor)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(job['location'], style: GoogleFonts.poppins(fontSize: 14, color: subtextColor)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'MYR 2,500 - MYR 3,500 Per Month',
                style: GoogleFonts.poppins(fontSize: 14, color: accentColor, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => _applyForJob(job),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text('Apply', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_tab.dart';
import 'videos_tab.dart';
import 'my_job_tab.dart';
import 'messages_tab.dart';
import 'growth_hub_tab.dart';


class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePageContent(),
    const MyJobTab(),
    const VideosTab(),
    const GrowthHubTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F1F6),
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildCustomTabBar(),
      floatingActionButton: _buildFloatingPostButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildCustomTabBar() {
  return ClipPath(
    clipper: BottomBarClipper(),
    child: BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFFE8F1F6),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: _currentIndex == 0 ? const Color(0xFF51cacc) : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.work_outline,
                color: _currentIndex == 1 ? const Color(0xFF51cacc) : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            const SizedBox(width: 40), // Space for floating button
            IconButton(
              icon: Icon(
                Icons.video_library,
                color: _currentIndex == 2 ? const Color(0xFF51cacc) : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.trending_up, // Growth Hub icon
                color: _currentIndex == 3 ? const Color(0xFF51cacc) : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person_outline,
                color: _currentIndex == 4 ? const Color(0xFF51cacc) : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 4;
                });
              },
            ),
          ],
        ),
      ),
    ),
  );
}



  Widget _buildFloatingPostButton() {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF51cacc), Color(0xFF84dbf4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create_post');
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: const Icon(Icons.add, size: 28, color: Colors.white),
      ),
    );
  }
}

// Home Page Content
class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<Map<String, String>> _jobPostings = [
  // Development Jobs
  {'title': 'Software Engineer', 'company': 'Tech Co', 'location': 'Kuala Lumpur', 'salary': 'MYR 5k - MYR 8k/month', 'category': 'Development'},
  {'title': 'Mobile App Developer', 'company': 'AppWorld', 'location': 'Cyberjaya', 'salary': 'MYR 4.5k - MYR 7k/month', 'category': 'Development'},
  {'title': 'Backend Developer', 'company': 'DataSys', 'location': 'Penang', 'salary': 'MYR 6k - MYR 10k/month', 'category': 'Development'},
  {'title': 'Frontend Developer', 'company': 'Webify', 'location': 'Shah Alam', 'salary': 'MYR 4k - MYR 6k/month', 'category': 'Development'},
  {'title': 'Data Engineer', 'company': 'BigData Corp', 'location': 'Kuala Lumpur', 'salary': 'MYR 7k - MYR 10k/month', 'category': 'Development'},

  // Designing Jobs
  {'title': 'UI/UX Designer', 'company': 'Creative Studio', 'location': 'Petaling Jaya', 'salary': 'MYR 4.5k - MYR 6.5k/month', 'category': 'Designing'},
  {'title': 'Graphic Designer', 'company': 'Artify', 'location': 'George Town', 'salary': 'MYR 3.5k - MYR 5k/month', 'category': 'Designing'},
  {'title': 'Product Designer', 'company': 'Design Inc', 'location': 'Petaling Jaya', 'salary': 'MYR 6k - MYR 9k/month', 'category': 'Designing'},
  {'title': 'Illustrator', 'company': 'Pixie Studios', 'location': 'Shah Alam', 'salary': 'MYR 4k - MYR 5.5k/month', 'category': 'Designing'},
  {'title': 'Visual Designer', 'company': 'Adcreatives', 'location': 'Kuala Lumpur', 'salary': 'MYR 5k - MYR 7k/month', 'category': 'Designing'},

  // Marketing Jobs
  {'title': 'Digital Marketing Specialist', 'company': 'MarketPros', 'location': 'Cyberjaya', 'salary': 'MYR 4k - MYR 7k/month', 'category': 'Marketing'},
  {'title': 'Content Strategist', 'company': 'Contentify', 'location': 'Kuala Lumpur', 'salary': 'MYR 3.5k - MYR 5k/month', 'category': 'Marketing'},
  {'title': 'SEO Specialist', 'company': 'SearchFirst', 'location': 'Penang', 'salary': 'MYR 4k - MYR 6k/month', 'category': 'Marketing'},
  {'title': 'Social Media Manager', 'company': 'Buzz Social', 'location': 'Petaling Jaya', 'salary': 'MYR 5k - MYR 7k/month', 'category': 'Marketing'},
  {'title': 'Brand Manager', 'company': 'Brandify', 'location': 'Shah Alam', 'salary': 'MYR 6k - MYR 9k/month', 'category': 'Marketing'},
];

  List<Map<String, String>> get _filteredJobPostings {
    return _jobPostings.where((job) {
      final matchesCategory = _selectedCategory == 'All' || job['category'] == _selectedCategory;
      final matchesQuery = job['title']!.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          _buildGreetingSection(),
          const SizedBox(height: 30),
          _buildAnimatedSearchBar(),
          const SizedBox(height: 30),
          _buildSkillsAssessmentSection(context),
          const SizedBox(height: 30),
          _buildAICareerGuidanceSection(context),
          const SizedBox(height: 30),
          _buildJobCategories(),
          const SizedBox(height: 30),
          _buildTopCompaniesSection(),
          const SizedBox(height: 30),
          _buildRecentPosts(),
        ],
      ),
    );
  }

  // Greeting Section
  Widget _buildGreetingSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning,',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF3C3C3C),
              ),
            ),
            Text(
              'Raynold Kabai',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MessagesTab()),
                );
              },
              child: CircleAvatar(
                radius: 24,
                backgroundColor: const Color(0xFF51cacc).withOpacity(0.2),
                child: const Icon(Icons.message_outlined, color: Color(0xFF51cacc)),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/notifications');
              },
              child: CircleAvatar(
                radius: 24,
                backgroundColor: const Color(0xFF51cacc).withOpacity(0.2),
                child: const Icon(Icons.notifications_none, color: Color(0xFF51cacc)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Search Bar
  Widget _buildAnimatedSearchBar() {
    return GestureDetector(
      onTap: () {
        print('Search bar tapped');
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFd7e9f6),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            const Icon(Icons.search, color: Color(0xFF3C3C3C)),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                style: GoogleFonts.poppins(),
                decoration: const InputDecoration(
                  hintText: 'Search Company, Job Profile...',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.filter_alt, color: Color(0xFF3C3C3C)),
              onPressed: () {
                print('Filter pressed');
              },
            ),
          ],
        ),
      ),
    );
  }

  // Skills Assessment Section
  Widget _buildSkillsAssessmentSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFffffff).withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF088385).withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(Icons.assessment, size: 40, color: Color(0xFF088385)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Take Your Skills Assessment',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3C3C3C),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Get personalized job and training recommendations!',
                  style: GoogleFonts.poppins(color: Colors.black54),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/skills_assessment');
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              backgroundColor: const Color(0xFF088385),
            ),
            child: const Text(
              'Begin',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // AI Career Guidance Section
  Widget _buildAICareerGuidanceSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFffffff).withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF088385).withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(Icons.lightbulb, size: 40, color: Color(0xFF088385)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Career Guidance',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3C3C3C),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Explore career paths recommended by AI just for you!',
                  style: GoogleFonts.poppins(color: Colors.black54),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/ai_career_guidance');
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              backgroundColor: const Color(0xFF088385),
            ),
            child: const Text(
              'Explore',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Job Categories Section
  Widget _buildJobCategories() {
    final categories = ['All', 'Development', 'Designing', 'Marketing'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(
                category,
                style: GoogleFonts.poppins(),
              ),
              selected: _selectedCategory == category,
              selectedColor: const Color(0xFF51cacc),
              backgroundColor: const Color(0xFFd7e9f6),
              labelStyle: TextStyle(
                color: _selectedCategory == category ? Colors.white : const Color(0xFF3C3C3C),
              ),
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedCategory = category;
                  });
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  // Top Companies Section
  Widget _buildTopCompaniesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top Companies Hiring',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AllTopCompaniesPage()));
              },
              child: Text(
                'View all',
                style: GoogleFonts.poppins(color: const Color(0xFF51cacc)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _buildCompanyCard('UI / UX Designer', 'Figma', 'New York, United States', 'MYR 20k - MYR 30k/month'),
      ],
    );
  }

  Widget _buildCompanyCard(String jobTitle, String companyName, String location, String salaryRange) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      shadowColor: const Color(0xFF51cacc).withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 24,
              backgroundImage: AssetImage('assets/figma_logo.png'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobTitle,
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    companyName,
                    style: GoogleFonts.poppins(color: Colors.black54),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      Text(location, style: GoogleFonts.poppins(color: Colors.black54)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    salaryRange,
                    style: const TextStyle(color: Color(0xFF51cacc)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Recent Posts Section
  Widget _buildRecentPosts() {
    final List<Map<String, dynamic>> recentPosts = [
      {
        'name': 'Brooke Aiseen',
        'position': 'Product Designer & UI Designer at Microsoft',
        'jobTitle': 'Desktop App Developer',
        'likes': 2300,
        'time': '20 mins ago',
      },
      {
        'name': 'Rachel Tales',
        'position': 'Data Analyst & Senior Developer at Quara',
        'jobTitle': 'Desktop App Developer',
        'likes': 1800,
        'time': '45 mins ago',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Posts',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Sort by',
              style: GoogleFonts.poppins(color: const Color(0xFF51cacc)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          children: recentPosts.map((post) => _buildPostCard(post)).toList(),
        ),
      ],
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      shadowColor: const Color(0xFF51cacc).withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: const AssetImage('assets/profile_placeholder.png'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post['name'],
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post['position'],
                      style: GoogleFonts.poppins(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Hey there, folks\nAre you looking for a talented individual to join your team?',
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      post['likes'] += 1;
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text('${post['likes']} Likes'),
                    ],
                  ),
                ),
                const Spacer(),
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text(post['time']),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BottomBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const notchRadius = 30.0;
    final center = size.width / 2;

    path.lineTo(center - notchRadius * 2, 0);
    path.quadraticBezierTo(
      center - notchRadius, 0,
      center - notchRadius, notchRadius,
    );
    path.arcToPoint(
      Offset(center + notchRadius, notchRadius),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );
    path.quadraticBezierTo(
      center + notchRadius, 0,
      center + notchRadius * 2, 0,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

// Page to show All Top Companies
class AllTopCompaniesPage extends StatelessWidget {
  const AllTopCompaniesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final companies = [
      {'title': 'UI / UX Designer', 'company': 'Figma', 'location': 'New York, United States', 'salary': 'MYR 20k - MYR 30k/month'},
      {'title': 'Software Engineer', 'company': 'Google', 'location': 'Mountain View, CA', 'salary': 'MYR 25k - MYR 40k/month'},
      {'title': 'Product Designer', 'company': 'Apple', 'location': 'Cupertino, CA', 'salary': 'MYR 30k - MYR 45k/month'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Companies Hiring"),
      ),
      body: ListView.builder(
        itemCount: companies.length,
        itemBuilder: (context, index) {
          final company = companies[index];
          return ListTile(
            title: Text(company['title']!),
            subtitle: Text("${company['company']!}, ${company['location']!}"),
            trailing: Text(company['salary']!),
          );
        },
      ),
    );
  }
}

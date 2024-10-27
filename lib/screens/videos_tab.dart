// Main Flutter material package import
import 'package:flutter/material.dart';

// Importing additional packages for custom fonts and URL handling
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// Main class representing the videos tab screen
class VideosTab extends StatelessWidget {
  const VideosTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), // Adjusted height for visual separation
        child: Container(
          color: Colors.white, // White background for AppBar container
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Video Related Jobs',
                  style: GoogleFonts.poppins(
                    color: Colors.black, // Black color for text
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding for the main content area
        child: ListView(
          children: _videoJobPostings.map((videoJob) => _buildVideoJobCard(videoJob)).toList(),
        ),
      ),
    );
  }

  // Widget for each video job card displaying job details and a button to watch the video
  Widget _buildVideoJobCard(VideoJob videoJob) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0), // Spacing between each card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Thumbnail with error handling
            Image.network(
              videoJob.thumbnailUrl,
              fit: BoxFit.cover,
              height: 180,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: Colors.grey.shade200,
                  child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                );
              },
            ),
            // Video Details and Watch Video button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoJob.title,
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    videoJob.description,
                    style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => _launchURL(videoJob.videoUrl),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF51cacc),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Text(
                      'Watch Video',
                      style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to launch the URL for the video
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// Data model for video job postings containing title, description, thumbnail, and video URL
class VideoJob {
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;

  VideoJob({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
  });
}

// Sample list of video-related jobs with real YouTube URLs for demonstration
final List<VideoJob> _videoJobPostings = [
  VideoJob(
    title: 'Video Editor',
    description: 'Looking for a creative video editor with experience in Adobe Premiere.',
    thumbnailUrl: 'https://img.youtube.com/vi/RJ1cT4fS8aY/hqdefault.jpg',
    videoUrl: 'https://www.youtube.com/watch?v=_PB4MH2bGy4',
  ),
  VideoJob(
    title: 'Content Creator',
    description: 'Join our team as a content creator for YouTube and social media.',
    thumbnailUrl: 'https://img.youtube.com/vi/2cXvH3GRzjw/hqdefault.jpg',
    videoUrl: 'https://www.youtube.com/watch?v=Qmxj7_jj1-Y',
  ),
  VideoJob(
    title: 'Videographer',
    description: 'We need a videographer for our upcoming projects in Kuala Lumpur.',
    thumbnailUrl: 'https://img.youtube.com/vi/7b7BzUHZK5c/hqdefault.jpg',
    videoUrl: 'https://www.youtube.com/watch?v=y7si6iAo0Vo',
  ),
  VideoJob(
    title: 'Social Media Manager',
    description: 'Looking for a social media manager with video production skills.',
    thumbnailUrl: 'https://img.youtube.com/vi/BbQsXUtlSRU/hqdefault.jpg',
    videoUrl: 'https://www.youtube.com/watch?v=y-n1RUbYq6Q',
  ),
];

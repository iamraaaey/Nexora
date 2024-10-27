import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Stateful widget for creating a post screen
class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _postController = TextEditingController(); // Controller for the post text field
  String _visibility = 'Anyone'; // Default visibility setting for the post
  List<String> _postFeed = []; // List to store posts

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Close the post creation screen
        ),
        title: Text(
          'Create a Post',
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _postController.text.trim().isEmpty ? null : _submitPost, // Enable "Post" button only when the post field is not empty
            child: Text(
              'Post',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _postController.text.trim().isEmpty
                    ? Colors.grey
                    : const Color(0xFF0A66C2),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCreatePostSection(), // Section to create a new post
          const Divider(height: 1, color: Colors.grey), // Divider to separate sections
          Expanded(child: _buildPostFeed()), // Display the list of posts
        ],
      ),
    );
  }

  // Widget to build the section for creating a post
  Widget _buildCreatePostSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserInfo(), // Display user info with profile picture and visibility setting
          const SizedBox(height: 16),
          _buildPostTextField(), // Text field for entering post content
          const SizedBox(height: 16),
          _buildPostOptions(), // Options to add media to the post
        ],
      ),
    );
  }

  // Widget to build user information section with profile picture and visibility setting
  Widget _buildUserInfo() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage('assets/profile_placeholder.png'), // Placeholder for profile picture
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Raynold Kabai', // Hardcoded user name
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: _changeVisibility, // Tap to change the visibility setting
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1F6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.public, size: 14, color: Colors.black54), // Visibility icon
                    const SizedBox(width: 4),
                    Text(
                      _visibility, // Display current visibility setting
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, size: 16, color: Colors.black54), // Dropdown arrow
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Widget to build the text field for creating a post
  Widget _buildPostTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextField(
        controller: _postController, // Controller to handle the post text
        maxLines: 5,
        keyboardType: TextInputType.multiline,
        onChanged: (value) {
          setState(() {}); // Update UI when text changes
        },
        decoration: InputDecoration(
          hintText: 'What do you want to talk about?', // Placeholder text
          hintStyle: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // Widget to build post options (e.g., Photo, Video, Event, Write article)
  Widget _buildPostOptions() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildOptionButton(Icons.photo, 'Photo', const Color(0xFF0A66C2), _onAddMedia),
          _buildOptionButton(Icons.videocam, 'Video', const Color(0xFF0A66C2), _onAddMedia),
          _buildOptionButton(Icons.event, 'Event', const Color(0xFF0A66C2), _onAddMedia),
          _buildOptionButton(Icons.article, 'Write article', const Color(0xFF0A66C2), _onAddMedia),
        ],
      ),
    );
  }

  // Widget to build individual option buttons (e.g., Photo, Video)
  Widget _buildOptionButton(IconData icon, String label, Color color, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(label), // Handle tap on option button
      child: Column(
        children: [
          Icon(icon, color: color), // Display icon
          const SizedBox(height: 4),
          Text(
            label, // Display label (e.g., Photo, Video)
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build the list of posts
  Widget _buildPostFeed() {
    if (_postFeed.isEmpty) {
      // If no posts, display "No posts yet"
      return Center(
        child: Text(
          'No posts yet',
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
      );
    }
    // Display list of posts
    return ListView.builder(
      itemCount: _postFeed.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/profile_placeholder.png'), // Placeholder for profile picture
            ),
            title: Text(
              'Raynold Kabai', // Hardcoded user name
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              _postFeed[index], // Display post content
              style: GoogleFonts.poppins(),
            ),
          ),
        );
      },
    );
  }

  // Function to change the visibility setting for the post
  void _changeVisibility() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.public),
                title: const Text('Anyone'),
                onTap: () {
                  setState(() {
                    _visibility = 'Anyone'; // Set visibility to "Anyone"
                  });
                  Navigator.pop(context); // Close bottom sheet
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Connections only'),
                onTap: () {
                  setState(() {
                    _visibility = 'Connections only'; // Set visibility to "Connections only"
                  });
                  Navigator.pop(context); // Close bottom sheet
                },
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Private'),
                onTap: () {
                  setState(() {
                    _visibility = 'Private'; // Set visibility to "Private"
                  });
                  Navigator.pop(context); // Close bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to handle adding media (currently shows a SnackBar)
  void _onAddMedia(String mediaType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Add $mediaType feature coming soon!'), // Display a message indicating the feature is not yet implemented
      ),
    );
  }

  // Function to handle submitting a post
  void _submitPost() {
    if (_postController.text.trim().isNotEmpty) {
      setState(() {
        _postFeed.insert(0, _postController.text.trim()); // Add the new post to the top of the post feed
        _postController.clear(); // Clear the text field
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post submitted successfully!')), // Display a confirmation message
      );
    }
  }
}

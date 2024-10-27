import 'package:flutter/material.dart';

class MessagesTab extends StatelessWidget {
  const MessagesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: const Color(0xFF51cacc),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _messageList.length,
        itemBuilder: (context, index) {
          final message = _messageList[index];
          return _buildMessageItem(context, message);
        },
      ),
    );
  }

  // A method to build a single message item (conversation)
  Widget _buildMessageItem(BuildContext context, Message message) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(user: message.senderName),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: NetworkImage(message.avatarUrl),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.senderName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    message.lastMessage,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              message.timestamp,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Mock data for the messages with Malaysian names
class Message {
  final String senderName;
  final String lastMessage;
  final String timestamp;
  final String avatarUrl;

  Message({
    required this.senderName,
    required this.lastMessage,
    required this.timestamp,
    required this.avatarUrl,
  });
}

// Sample message list data with Malaysian names
final List<Message> _messageList = [
  Message(
    senderName: 'Leonal Sigar',
    lastMessage: 'Apa khabar? Lama tak jumpa!',
    timestamp: '2 min ago',
    avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
  ),
  Message(
    senderName: 'Nur Aisyah',
    lastMessage: 'Jom minum kopi minggu depan?',
    timestamp: '10 min ago',
    avatarUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
  ),
  Message(
    senderName: 'Syafiq Abdullah',
    lastMessage: 'Dokumen tu dah siap ke?',
    timestamp: '1 hr ago',
    avatarUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
  ),
  Message(
    senderName: 'Siti Aminah',
    lastMessage: 'Saya akan semak dulu dan beri maklum balas esok.',
    timestamp: 'Yesterday',
    avatarUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
  ),
];

/// Chat screen for individual conversations
class ChatScreen extends StatefulWidget {
  final String user;

  const ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text);
        _messageController.clear(); // Clear the input field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user),
        backgroundColor: const Color(0xFF51cacc),
      ),
      body: Column(
        children: [
          // Chat history
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _messages[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          // Text input field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Tulis mesej...',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  backgroundColor: const Color(0xFF51cacc),
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

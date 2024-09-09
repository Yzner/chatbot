// import 'package:flutter/material.dart';
// import 'api.dart';

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   List<Map<String, String>> messages = [];

//   void sendMessage(String message) async {
//     setState(() {
//       messages.add({'user': message});
//     });
//     String response = await ApiService.sendMessage(message);
//     setState(() {
//       messages.add({'bot': response});
//     });
//     _controller.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chatbot'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(
//                     messages[index].values.first,
//                     style: TextStyle(
//                       color: messages[index].keys.first == 'user'
//                           ? const Color.fromARGB(255, 0, 3, 5)
//                           : Colors.black,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(hintText: 'Enter a message'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () => sendMessage(_controller.text),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'api.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  final ScrollController _scrollController = ScrollController();

  void sendMessage(String message) async {
    if (message.trim().isEmpty) return; // Prevent sending empty messages

    setState(() {
      messages.add({'user': message});
    });

    _controller
        .clear(); // Clear the text field immediately after adding the message

    String response = await ApiService.sendMessage(message);
    setState(() {
      messages.add({'bot': response});
    });

    // Scroll to the bottom after new messages are added
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: false, // Ensure new messages appear at the bottom
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUserMessage = message.keys.first == 'user';
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: Align(
                    alignment: isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width *
                            0.8, // Max width of the message bubble
                      ),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: isUserMessage
                            ? Colors.blueAccent
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        message.values.first,
                        style: TextStyle(
                          color: isUserMessage ? Colors.white : Colors.black,
                        ),
                        softWrap: true, // Ensures text wraps
                        overflow: TextOverflow
                            .visible, // Handles overflow if necessary
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLines: null, // Allows multi-line input
                    minLines: 1, // Sets the minimum number of lines
                    onChanged: (text) {
                      setState(
                          () {}); // Refresh the UI to enable/disable the send button
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      hintText: 'Enter a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(
                    width: 8.0), // Spacing between TextField and IconButton
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final text = _controller.text;
                    if (text.trim().isNotEmpty) {
                      sendMessage(text);
                    }
                  },
                  color: Colors.blueAccent,
                  iconSize: 24.0,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

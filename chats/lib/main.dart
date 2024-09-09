// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const MyHomePage(title: 'Chatbot'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final List<String> _messages = [];
//   final TextEditingController _controller = TextEditingController();

//   void _sendMessage() {
//     final message = _controller.text;
//     if (message.isNotEmpty) {
//       setState(() {
//         _messages.add(message);
//         _controller.clear();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Icon(Icons.chat, color: Colors.deepPurple),
//             ),
//             SizedBox(width: 10),
//             Text(widget.title),
//           ],
//         ),
//         backgroundColor: Colors.deepPurple,
//         actions: [
//           PopupMenuButton<String>(
//             onSelected: (value) {
//               // Handle actions
//               switch (value) {
//                 case 'search':
//                 // Implement search action
//                   break;
//                 case 'history':
//                 // Implement history action
//                   break;
//                 case 'account':
//                 // Implement account action
//                   break;
//               }
//             },
//             itemBuilder: (BuildContext context) => [
//               PopupMenuItem(value: 'search', child: Text('Search')),
//               PopupMenuItem(value: 'history', child: Text('History')),
//               PopupMenuItem(value: 'account', child: Text('Account')),
//             ],
//             icon: Icon(Icons.more_vert),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_messages[index]),
//                   contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
//                   tileColor: Colors.deepPurple.shade50,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5),
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
//                     decoration: InputDecoration(
//                       hintText: 'Type your message...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: _sendMessage,
//                   child: Text('Send'),
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'chat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: ChatScreen(),
    );
  }
}

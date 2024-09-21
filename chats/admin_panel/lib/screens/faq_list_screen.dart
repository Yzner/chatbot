import 'package:flutter/material.dart';

class FAQListScreen extends StatefulWidget {
  @override
  _FAQListScreenState createState() => _FAQListScreenState();
}

class _FAQListScreenState extends State<FAQListScreen> {
  final List<String> faqs = [
    'What is the registration process?',
    'How do I reset my password?'
  ];
  final TextEditingController _controller = TextEditingController();

  void _addFAQ(String faq) {
    setState(() {
      faqs.add(faq);
    });
  }

  void _deleteFAQ(int index) {
    setState(() {
      faqs.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Panel - FAQs')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(faqs[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteFAQ(index),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Add a new FAQ'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _addFAQ(_controller.text);
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

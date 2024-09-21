import 'package:flutter/material.dart';
import 'screens/faq_list_screen.dart';

void main() {
  runApp(AdminPanel());
}

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FAQListScreen(),
    );
  }
}

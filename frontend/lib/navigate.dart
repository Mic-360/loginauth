import 'package:flutter/material.dart';

class navigate extends StatefulWidget {
  navigate({super.key});

  @override
  State<navigate> createState() => _navigateState();
}

class _navigateState extends State<navigate> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'logged in',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      color: Colors.amber,
    );
  }
}
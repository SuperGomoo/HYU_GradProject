import 'package:flutter/material.dart';

class MainMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example Page'),
      ),
      body: Center(
        child: Text(
          'This is an example page!',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
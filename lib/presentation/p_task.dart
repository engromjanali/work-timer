import 'package:flutter/material.dart';

class PTask extends StatefulWidget {
  const PTask({super.key});

  @override
  State<PTask> createState() => _PTaskState();
}

class _PTaskState extends State<PTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task",),
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
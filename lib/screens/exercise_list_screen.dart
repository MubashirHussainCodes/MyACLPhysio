import 'package:flutter/material.dart';
import 'exercise_screen.dart';

class ExerciseListScreen extends StatelessWidget {
  final List<String> exercises;
  final String routineLevel;

  ExerciseListScreen({required this.exercises, required this.routineLevel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(routineLevel)),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(exercises[index]),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExerciseScreen(
                exercises: exercises,
                initialIndex: index,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'exercise_list_screen.dart';

class RoutineSelectionScreen extends StatelessWidget {
  final Map<String, List<String>> routines = {
    'WEEK 2-4': ['Ankle Pumps', 'Quad Pumps', 'Patella Mobilization',"Calf Stretch", "Hip Tight","Knee Press","Heel Press", "Straight Leg Raises","Knee Right Slides", "SLR Pillow","Knee Slides- Heel","Prone Knee Stretch","Side Slr", "Reverse SLR", "Sitting SLR"],
    'WEEK 4-6': ['Wall Pushups', 'Side Leg Raises', 'Mini Squats'],
    'WEEK 6-8': ['Plank', 'Bridge', 'Lunges'],
    'WEEK 8-10': ['Plank', 'Bridge', 'Lunges'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Routine'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: routines.keys.map((level) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: Icon(
                Icons.fitness_center,
                color: Colors.blue.shade900,
              ),
              title: Text(
                level,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${routines[level]!.length} exercises',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue.shade900),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseListScreen(
                    exercises: routines[level]!,
                    routineLevel: level,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PieChartWidget extends StatelessWidget {
  final String goalId;

  PieChartWidget({required this.goalId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('goals').doc(goalId).collection('progress').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final progress = snapshot.data!.docs;
        int totalDays = progress.length;
        int completedDays = progress.where((doc) => doc['satisfactionLevel'] > 3).length;
        double percentage = (completedDays / totalDays) * 100;

        return Column(
          children: [
            Text('Progress: ${percentage.toStringAsFixed(2)}%'),
            // Add your pie chart implementation here
            // For example, using a placeholder container
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.red],
                  stops: [completedDays / totalDays, completedDays / totalDays],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
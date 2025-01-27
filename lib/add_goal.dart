import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddGoalPage extends StatefulWidget {
  @override
  _AddGoalPageState createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  final _formKey = GlobalKey<FormState>();
  String _description = '';
  int _duration = 0;
  String _goalType = '';

  void _addGoal() async {
    if (_formKey.currentState!.validate()) {
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('goals').add({
        'userId': user?.uid,
        'description': _description,
        'duration': _duration,
        'progress': 0,
      });
      Navigator.pop(context);
    }
  }

  void _updateGoalType(int duration) {
    if (duration >= 7 && duration <= 45) {
      _goalType = 'Short-term Goal';
    } else if (duration > 45) {
      _goalType = 'Long-term Goal';
    } else {
      _goalType = 'Invalid';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Goal')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade200, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  _description = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Duration (days)'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _duration = int.parse(value);
                    _updateGoalType(_duration);
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a duration';
                  }
                  if (_duration < 7) {
                    return 'You need more than 7 days';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              if (_goalType.isNotEmpty && _goalType != 'Invalid')
                Text(
                  _goalType,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addGoal,
                child: Text(
                  'Add Goal',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
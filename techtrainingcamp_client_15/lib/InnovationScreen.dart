import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InnovationScreen extends StatefulWidget {
  @override
  _InnovationScreenState createState() => _InnovationScreenState();
}

class _InnovationScreenState extends State<InnovationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        color: Colors.greenAccent.shade200,
        gradient: LinearGradient(
          colors: [Colors.lightBlueAccent.shade400, Colors.greenAccent.shade400],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
    );
  }
}

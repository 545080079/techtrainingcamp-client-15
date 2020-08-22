import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InnovationScreen extends StatefulWidget {
  @override
  _InnovationScreenState createState() => _InnovationScreenState();
}



class _InnovationScreenState extends State<InnovationScreen> {

  String join({String a, String b}) {
    if(b == null)
      return a;
    return a+b;
  }

  @override
  Widget build(BuildContext context) {


  assert(join(a: 'name') == 'name');
  assert(join(a: 'name', b: 'space') == 'namespace');
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
      child: Text(
        'f',
      ),
    );
  }
}

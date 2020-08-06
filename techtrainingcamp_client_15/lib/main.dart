import 'package:flutter/material.dart';
import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Clock',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('My Clock'),
        ),
        body: new Center(
          child: new Text('second row'),
        ),
      )
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {

  @override
  Widget build(BuildContext context) {
    final wordPair = new WorkPair.random();
    return new Text(wordPair.asPascalCase);
  }
}
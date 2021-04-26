import 'package:flutter/material.dart';

// 通话
class CallPage extends StatefulWidget {
  @override
  _CallPageState createState() => _CallPageState();
}
class _CallPageState extends State<CallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 81, 125, 162),
        title: Text("通话", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        child: Center(child: Text("您还没有拨打过任何电话", style: TextStyle(fontSize: 20, color: Colors.grey)))
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        child: Icon(Icons.call, size: 25),
        backgroundColor: Color.fromARGB(255, 102, 169, 224),
        onPressed: (){},
      ),
    );
  }
}
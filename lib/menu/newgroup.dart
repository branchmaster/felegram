import 'package:flutter/material.dart';

// 新建群组
class NewGroupPage extends StatefulWidget {
  @override
  _NewGroupPageState createState() => _NewGroupPageState();
}
class _NewGroupPageState extends State<NewGroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 81, 125, 162),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("新建群组", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("最多200000人", style: TextStyle(color: Colors.white60, fontSize: 16))
          ]
        )
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "添加成员...",
              hintStyle: TextStyle(color: Colors.black38),
              contentPadding: EdgeInsets.all(5),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.5)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1)),
            )
          ),
          Divider(height: 1),
          Expanded(child: Container(
            child: Center(child: Text("还没有联系人", style: TextStyle(fontSize: 20, color: Colors.grey)))
          ))
        ],
      ),
    );
  }
}
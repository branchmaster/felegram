import 'package:flutter/material.dart';

// 推荐
class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}
class _RecommendPageState extends State<RecommendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 81, 125, 162),
        title: Text("推荐", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "搜索联系人",
              hintStyle: TextStyle(color: Colors.black38),
              contentPadding: EdgeInsets.all(5),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.5)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1)),
            )
          ),
          Divider(height: 1),
          Expanded(child: ListView(
            children: [
              Container(
                height: 50,
                child: ListTile(
                  leading: Icon(Icons.share_outlined, size: 25),
                  title: Text("分享 Felegram", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RecommendPage())),
                ),
              ),
              Divider(height: 1, indent: 70),
              Container(child: Center(child: Text("还没有联系人", style: TextStyle(fontSize: 20, color: Colors.grey))))
            ],
          ))
        ],
      ),
    );
  }
}
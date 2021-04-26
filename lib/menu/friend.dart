import 'package:country_code_picker/country_code_picker.dart';
import 'package:felegram/menu/newgroup.dart';
import 'package:felegram/menu/recommend.dart';
import 'package:flutter/material.dart';

// 联系人
class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}
class _FriendPageState extends State<FriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 81, 125, 162),
        title: Text("联系人", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: [
          Container(
            height: 50,
            child: ListTile(
              leading: Icon(Icons.share_outlined, size: 25),
              title: Text("推荐给好友", style: TextStyle(fontSize: 16)),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RecommendPage())),
            ),
          ),
          Container(
            height: 50,
            child: ListTile(
              leading: Icon(Icons.place_outlined, size: 30),
              title: Text("附近的人", style: TextStyle(fontSize: 16)),
              onTap: (){},
            ),
          ),
          Container(
            height: 50,
            child: ListTile(
              leading: Icon(Icons.group_outlined, size: 30),
              title: Text("新建群组", style: TextStyle(fontSize: 16)),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewGroupPage())),
            ),
          ),
          Container(
            height: 50,
            child: ListTile(
              leading: Icon(Icons.lock_outline, size: 30),
              title: Text("说悄悄话", style: TextStyle(fontSize: 16)),
              onTap: (){},
            ),
          ),
          Container(
            height: 50,
            child: ListTile(
              leading: Icon(Icons.record_voice_over_outlined, size: 28),
              title: Text("新建频道", style: TextStyle(fontSize: 16)),
              onTap: (){},
            ),
          ),
          Divider(thickness: 10),
          Container(
            child: Center(child: Text("还没有联系人", style: TextStyle(fontSize: 20, color: Colors.grey)))
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        child: Icon(Icons.person_add, size: 25),
        backgroundColor: Color.fromARGB(255, 102, 169, 224),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddFriendPage())),
      ),
    );
  }
}

// 添加联系人
class AddFriendPage extends StatefulWidget {
  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}
class _AddFriendPageState extends State<AddFriendPage> {
  final String img_url = "https://b-ssl.duitang.com/uploads/blog/201312/04/20131204184148_hhXUT.jpeg";
  TextEditingController _name = TextEditingController();  // 名字
  TextEditingController _fname = TextEditingController();  // 姓氏
  CountryCode _countryCode = CountryCode.fromDialCode("+86");
  TextEditingController _phone = TextEditingController();  // 电话

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 81, 125, 162),
        title: Text("添加联系人", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(Icons.done), onPressed: (){})
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Container(  // 头像
                    padding: EdgeInsets.only(right: 20),
                    child: ClipOval(
                      child: Image.network(
                        this.img_url,
                        width: 55, height: 55,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(child: Column(
                    children: [
                      TextField(controller: this._name, decoration: InputDecoration(hintText: "名字（必填）")),
                      TextField(controller: this._fname, decoration: InputDecoration(hintText: "姓氏（可选）"))
                    ],
                  )),
                ],
              )
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  CountryCodePicker(
                    onChanged: (CountryCode code){
                      setState(() => this._countryCode = code);
                    },
                    initialSelection: this._countryCode.code,
                    favorite: ["+86"],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                  ),
                  Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    TextField(controller: this._phone, decoration: InputDecoration.collapsed(hintText: "电话")),
                    Divider(height: 1, color: Colors.black54),
                  ]))
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}
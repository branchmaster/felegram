import 'package:felegram/menu/call.dart';
import 'package:felegram/menu/friend.dart';
import 'package:felegram/menu/newgroup.dart';
import 'package:felegram/menu/recommend.dart';
import 'package:felegram/page/session.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

// 主页
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}
class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 81, 125, 162),
        title: Text("Felegram"),
        actions: [
          IconButton(icon: Icon(Icons.verified_user, size: 22), onPressed: (){}),
          IconButton(icon: Icon(Icons.search, size: 25), onPressed: (){})
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index){
          return Column(
            children: [
              SessionItem(),
              Divider(indent: 75, height: 1)
            ],
          );
        }
      ),
      drawer: UserMenuItem(),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        child: Icon(Icons.create, size: 25),
        backgroundColor: Color.fromARGB(255, 102, 169, 224),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FriendPage())),
      ),
    );
  }
}

// 对话
class SessionItem extends StatefulWidget {
  @override
  _SessionItemState createState() => _SessionItemState();
}
class _SessionItemState extends State<SessionItem> {
  final String img_url = "https://b-ssl.duitang.com/uploads/blog/201312/04/20131204184148_hhXUT.jpeg";
  final String text = "社工库机器人";
  final String time = "3月6日";
  final String simple_smg = "未收录词条信息，可付费联系合作商户未收录词条信息，可付费联系合作商户";
  final int unread_num = 2;

  // 未读消息
  Widget unreadNumWidget(int unread_num){
    if(unread_num == 0){
      return SizedBox();
    }
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: (unread_num<10)?Badge(
        toAnimate: false,
        badgeColor: Color.fromARGB(255, 197, 201, 204),
        badgeContent: Text(unread_num.toString(), style: TextStyle(color: Colors.white)),
      ):Badge(
        toAnimate: false,
        shape: BadgeShape.square,
        borderRadius: BorderRadius.circular(20),
        badgeColor: Color.fromARGB(255, 197, 201, 204),
        badgeContent: Text(unread_num.toString(), style: TextStyle(color: Colors.white)),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child: MaterialButton(
        padding: EdgeInsets.all(0),
        child: Row(
          children: [
            Container(  // 头像
              padding: EdgeInsets.all(10),
              child: ClipOval(
                child: Image.network(
                  this.img_url,
                  width: 55, height: 55,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(child: Container(  // 标题/简介
              padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(
                        this.text,
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis
                      )),
                      Container(child: Text(this.time, style: TextStyle(color: Colors.black54, fontSize: 16))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(
                        this.simple_smg,
                        style: TextStyle(color: Colors.black45, fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis
                      )),
                      this.unreadNumWidget(this.unread_num)
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SessionPage())),
      )
    );
  }
}

// 左侧用户菜单
class UserMenuItem extends StatelessWidget {
  final String username = "kkkunny";
  final String email = "@kkkunny";
  final String img_url = "https://b-ssl.duitang.com/uploads/blog/201312/04/20131204184148_hhXUT.jpeg";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            color: Color.fromARGB(255, 90, 143, 187),
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ClipOval(
                        child: Image.network(
                          this.img_url,
                          width: 65, height: 65,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(this.username, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                        Text(this.email, style: TextStyle(color: Colors.white60))
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.brightness_2, color: Colors.white),
                      onPressed: (){}
                    ),
                    IconButton(
                      icon: Icon(Icons.expand_more, color: Colors.white, size: 30),
                      onPressed: (){}
                    )
                  ],
                ),
              ],
            )
          ),
          Container(
            height: 50,
            child: ListTile(
              leading: Icon(Icons.group_outlined, size: 30),
              title: Text("新建群组", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewGroupPage())),
            ),
          ),
          Container(
            height: 50,
            child: ListTile(
              leading: Icon(Icons.person_outline, size: 30),
              title: Text("联系人", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FriendPage())),
            ),
          ),
          Container(
            height: 50,
            child: ListTile(
              leading: Icon(Icons.local_phone_outlined, size: 30),
              title: Text("通话", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CallPage())),
            ),
          ),
          Container(
            height: 50,
            child: ListTile(
              leading: Icon(Icons.person_pin_circle_outlined, size: 30),
              title: Text("附件的人", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              onTap: (){},
            ),
          ),
          Container(
            height: 50,
            child: ListTile(
              leading: Icon(Icons.bookmark_outline, size: 30),
              title: Text("收藏", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SessionPage())),
            ),
          ),
          Container(
            height: 50,
            child: ListTile(
              leading: Icon(Icons.settings_outlined, size: 30),
              title: Text("设置", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              onTap: (){},
            ),
          ),
          Divider(height: 1),
          Container(
            height: 50,
            child: ListTile(
              leading: Icon(Icons.share_outlined, size: 30),
              title: Text("推荐", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RecommendPage())),
            ),
          ),
        ],
      ),
    );
  }
}
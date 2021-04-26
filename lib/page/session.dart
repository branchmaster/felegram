import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emoji;
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';

// 聊天页面
class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}
class _SessionPageState extends State<SessionPage> {
  bool _top = true;
  final String title = "Go";
  final String img_url = "https://b-ssl.duitang.com/uploads/blog/201312/04/20131204184148_hhXUT.jpeg";
  final int members = 3603;
  final int online = 403;

  TextEditingController _inputCtlr = TextEditingController();  // 输入控制器

  @override
  Widget build(BuildContext context) {
    return KeyboardSizeProvider(
      child: KeyboardDismissOnTap(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 81, 125, 162),
            title: Row(
              children: [
                Container(  // 头像
                  padding: EdgeInsets.only(right: 10),
                  child: ClipOval(
                    child: Image.network(
                      this.img_url,
                      width: 45, height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(this.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(this.members.toString()+"人，"+this.online.toString()+"人在线", style: TextStyle(color: Colors.white60, fontSize: 16))
                  ]
                )
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/background.jpg")
              )
            ),
            child:  Column(
              children: [
                Offstage(
                  offstage: !this._top,
                  child: Container(  // 置顶
                    color: Colors.white,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("置顶", style: TextStyle(color: Color.fromARGB(255, 59, 140, 206))),
                              Text("sfasdjsahdjadjadjsadadj", style: TextStyle(color: Colors.black54))
                            ],
                          ),
                        ),
                        IconButton(icon: Icon(Icons.close), color: Colors.black54, iconSize: 20, onPressed: (){
                          setState(() => this._top = false);
                        })
                      ],
                    )
                  ),
                ),
                Expanded(child: ListView(children: [
                  ChatMessageItem()
                ])),
                ChatInputBottom(this._inputCtlr),
              ],
            ),
          )
        ),
      ),
    );
  }
}

// 聊天底部输入栏
class ChatInputBottom extends StatefulWidget {
  final TextEditingController _controller;

  ChatInputBottom(this._controller);
  @override
  _ChatInputBottomState createState() => _ChatInputBottomState(this._controller);
}
class _ChatInputBottomState extends State<ChatInputBottom> {
  FocusNode _inputFocus = FocusNode();  // 输入焦点
  bool _emoji = false;  // emoji选择栏
  double _keyboardHeight = 0;  // 键盘高度

  TextEditingController _controller;  // 输入栏控制器
  ValueNotifier<bool> _hasWord = ValueNotifier<bool>(false);  // 输入栏是否有字

  _ChatInputBottomState(this._controller);
  @override
  void initState() {
    // 输入框是否有字变化
    this._controller.addListener(() {this._hasWord.value = this._controller.text==""?false:true;});
    // 输入框焦点变化
    this._inputFocus.addListener(() {
      if(this._emoji && this._inputFocus.hasFocus){
        setState(() => this._emoji = false);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenHeight>(
      builder: (context, _res, child){
        if(!this._emoji && _res.isOpen){
          this._keyboardHeight = _res.keyboardHeight;
        }
        return Column(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(icon: Icon(this._emoji?Icons.keyboard:Icons.insert_emoticon), color: Colors.grey, onPressed: (){
                    if(!this._emoji){
                      this._inputFocus.unfocus();
                    }else{
                      this._inputFocus.requestFocus();
                    }
                    setState((){
                      this._emoji = !this._emoji;
                    });
                  }),
                  Expanded(child: TextField(
                    focusNode: this._inputFocus,
                    maxLines: 5,
                    minLines: 1,
                    controller: this._controller,
                    decoration: InputDecoration.collapsed(hintText: "请输入", hintStyle: TextStyle(color: Colors.grey))
                  )),
                  ValueListenableBuilder(
                    valueListenable: this._hasWord,
                    builder: (BuildContext context, bool value, Widget child){
                      return !value?Row(children: [
                        IconButton(icon: Icon(Icons.attach_file), color: Colors.grey, onPressed: (){}),
                        IconButton(icon: Icon(Icons.mic_none), color: Colors.grey, onPressed: (){})
                      ]):IconButton(icon: Icon(Icons.send), color: Colors.blue, onPressed: (){});
                    }
                  ),
                ],
              ),
            ),
            Visibility(
              visible: this._emoji?true:false,
              maintainAnimation: this._emoji||this._inputFocus.hasFocus?true:false,
              maintainSize: this._emoji||this._inputFocus.hasFocus?true:false,
              maintainState: this._emoji||this._inputFocus.hasFocus?true:false,
              child: SizedBox(
                height: !this._emoji&&!_res.isOpen?0:this._keyboardHeight,
                child: emoji.EmojiPicker(
                  onEmojiSelected: (category, emoji) => this._controller.text += emoji.emoji,
                  config: emoji.Config(
                      columns: 8,
                      emojiSizeMax: 28.0,
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      initCategory: emoji.Category.RECENT,
                      bgColor: Color(0xFFF2F2F2),
                      indicatorColor: Colors.blue,
                      iconColor: Colors.grey,
                      iconColorSelected: Colors.blue,
                      progressIndicatorColor: Colors.blue,
                      showRecentsTab: true,
                      recentsLimit: 32,
                      noRecentsText: "No Recents",
                      noRecentsStyle: const TextStyle(fontSize: 20, color: Colors.black26),
                      categoryIcons: const emoji.CategoryIcons(),
                      buttonMode: emoji.ButtonMode.MATERIAL
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// 聊天信息
class ChatMessageItem extends StatelessWidget {
  final bool _isMy = false;
  final String _username = "jiang jin";
  final Color _color = Colors.red;
  final String img_url = "https://b-ssl.duitang.com/uploads/blog/201312/04/20131204184148_hhXUT.jpeg";
  final String _text = "你好";
  final String _time = "PM 5.07";

  @override
  Widget build(BuildContext context) {
    return this._isMy?Bubble(
        margin: BubbleEdges.only(right: 5),
        alignment: Alignment.topRight,
        nip: BubbleNip.rightBottom,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(this._time, style: TextStyle(color: Colors.black54, fontSize: 12)),
            Text(this._text, style: TextStyle(fontSize: 16)),
          ],
        ),
      ):Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(  // 头像
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: ClipOval(
              child: Image.network(
                this.img_url,
                width: 45, height: 45,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Bubble(
            alignment: Alignment.topLeft,
            nip: BubbleNip.leftBottom,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(this._time, style: TextStyle(color: Colors.black54, fontSize: 12)),
                    SizedBox(width: 20),
                    Text(this._username, style: TextStyle(color: this._color, fontSize: 14)),
                  ],
                ),
                Text(this._text, style: TextStyle(fontSize: 16)),
              ],
            )
          )
        ],
      ),
    );
  }
}
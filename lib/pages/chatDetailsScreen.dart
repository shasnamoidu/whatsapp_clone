import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/chat_Model.dart';

class ChatDetails extends StatefulWidget {
  ChatDetails({super.key, required this.chatData});
  Chat chatData;

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back),
            ),
            CircleAvatar(
                backgroundImage: (widget.chatData.avatar == "")
                    ? NetworkImage((widget.chatData.isGroup)
                        ? "https://www.shutterstock.com/image-vector/avatar-icon-design-buddy-chat-260nw-1485904172.jpg"
                        : "https://t4.ftcdn.net/jpg/05/49/98/39/360_F_549983970_bRCkYfk0P6PP5fKbMhZMIb07mCJ6esXL.webp")
                    : NetworkImage(widget.chatData.avatar)),
          ],
        ),
        title: Column(
          children: [
            Text(
              widget.chatData.nAme,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              widget.chatData.status,
              style: TextStyle(fontSize: 15, color: Colors.white),
            )
          ],
        ),
        backgroundColor: Colors.teal,
        actions: [
          SizedBox(
            width: 30,
          ),
          Icon(
            Icons.video_call,
            color: Colors.white,
          ),
          SizedBox(
            width: 30,
          ),
          Icon(
            Icons.call,
            color: Colors.white,
          ),
          SizedBox(
            width: 30,
          ),
          PopupMenuButton(
            color: Colors.white,
            itemBuilder: (context) {
              return [
                PopupMenuItem(child: Text("view contacts")),
                PopupMenuItem(child: Text("media,links,and docs")),
                PopupMenuItem(child: Text("search")),
                PopupMenuItem(child: Text("mute notification")),
                PopupMenuItem(child: Text("disappearing messages")),
                PopupMenuItem(child: Text("wallpaper")),
                PopupMenuItem(child: Text("More")),
              ];
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('assets/images/wtsap_wal.png',fit: BoxFit.cover,),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width -70,
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(25)),
                      child: TextField(
                        cursorColor: Colors.teal,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(hintText: 'type a message',
                        border: InputBorder.none),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                    child: InkWell(
                      child: CircleAvatar(
                        radius: 25,
                        child:
                    
                         Icon(Icons.mic,)
                      ),
                    ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

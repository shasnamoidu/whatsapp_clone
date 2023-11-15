import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/chat_Model.dart';
import 'package:whatsapp_clone/models/singleChatMode.dart';
import 'package:whatsapp_clone/widgets/chatBubble.dart';
import 'package:whatsapp_clone/widgets/utilityWidget.dart';

class ChatDetails extends StatefulWidget {
  ChatDetails({super.key, required this.chatData});
  Chat chatData;

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  List<SingleChat> messageList = [
    SingleChat(
        isSend: true, isReaded: true, message: 'hello', sendAt: '9:45 AM'),
    SingleChat(
        isSend: true,
        isReaded: false,
        message: 'how are you',
        sendAt: '12:35 PM'),
    SingleChat(
        isSend: false,
        isReaded: false,
        message: 'i am fine',
        sendAt: '2:12 AM'),
    SingleChat(
        isSend: true, isReaded: true, message: 'welcome', sendAt: '10:35 AM'),
  ];
  bool showSend = false;
  bool showEmoji = false;
  TextEditingController _msgController = TextEditingController();
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
            child: Image.asset(
              'assets/images/wtsap_wal.png',
              fit: BoxFit.cover,
            ),
          ),
          ListView.builder(
            itemCount: messageList.length,
            itemBuilder: (context, index) {
              return ChatBubble(message: messageList[index]);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      child: TextField(
                        controller: _msgController,
                        onChanged: (value) {
                          if (value.length > 0) {
                            setState(() {
                              showSend = true;
                            });
                          } else {
                            setState(() {
                              showSend = false;
                            });
                          }
                        },
                        onTap: () {
                          setState(() {
                            showEmoji = true;
                          });
                        },
                        cursorColor: Colors.teal,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                                onPressed: () {
                                  if (showEmoji) {
                                    FocusScope.of(context).unfocus();
                                  }
                                  setState(() {
                                    showEmoji = !showEmoji;
                                  });
                                },
                                icon: (showEmoji)
                                    ? Icon(Icons.emoji_emotions_outlined)
                                    : Icon(Icons.keyboard)),
                            hintText: 'type a message',
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () => showModalBottomSheet(
                                          context: context,
                                          builder: (context) => menu(),
                                        ),
                                    icon: Icon(Icons.attach_file)),
                                UtilityWidget().widthSpacer(30),
                                Icon(Icons.currency_rupee_rounded),
                                UtilityWidget().widthSpacer(30),
                                Icon(Icons.camera_alt),
                                UtilityWidget().widthSpacer(30),
                              ],
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            messageList.add(SingleChat(
                                isSend: true,
                                isReaded: false,
                                message: _msgController.text,
                                sendAt: '10:25 AM'));
                          });
                          _msgController.clear();
                        },
                        child: CircleAvatar(
                            radius: 25,
                            child: (showSend)
                                ? Icon(Icons.send)
                                : Icon(
                                    Icons.mic,
                                  )),
                      ),
                    ),
                  ],
                ),
                Offstage(
                    offstage: showEmoji,
                    child: SizedBox(
                      height: 300,
                      child: EmojiPicker(
                        textEditingController: _msgController,
                        onEmojiSelected: (category, emoji) {
                          setState(() {
                            showSend = true;
                          });
                        },
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget iconWidget(Icon icon, Color color, String text, Function fun) {
    return GestureDetector(
      onTap: () {
        fun();
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: icon,
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }

  Widget menu() {
    return Container(
      height: 350,
      width: MediaQuery.of(context).size.width ,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              iconWidget(
                  Icon(Icons.insert_drive_file,color: Colors.white,), Colors.indigo, 'document',
                  () {
                print('Document');
              }),
              iconWidget(Icon(Icons.camera_alt,color: Colors.white,),
                  const Color.fromARGB(255, 181, 63, 63), 'camera', () {
                print('camera');
              }),
              UtilityWidget().widthSpacer(10),
              iconWidget(Icon(Icons.insert_photo,color: Colors.white,),
                  const Color.fromARGB(255, 177, 63, 181), 'Gallery', () {
                print('Gallery');
              }),
              UtilityWidget().widthSpacer(10)
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              iconWidget(Icon(Icons.headset,color: Colors.white,), Colors.orange, 'Audio', () {
                print('Audio');
              }),
              iconWidget(Icon(Icons.location_pin,color: Colors.white,), Colors.teal, 'Location',
                  () {
                print('Location');
              }),
              iconWidget(Icon(Icons.payment,color: Colors.white,), Colors.blue, 'Payment',
                  () {
                print('Payment');
              }),
            ],
          ),
          SizedBox(
            height: 10,
          
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              iconWidget(Icon(Icons.contact_phone,color: Colors.white,), Colors.blue, 'Contact', () {
                print('Contact');
              }),
              
              iconWidget(Icon(Icons.poll,color: Colors.white,), Colors.green, 'Poll',
                  () {
                print('Poll');
              }),
              UtilityWidget().widthSpacer(80)
            ],
          ),
        ],
      ),
    );
  }
}

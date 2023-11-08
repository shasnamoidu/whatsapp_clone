import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/chat_Model.dart';
import 'package:whatsapp_clone/pages/chatDetailsScreen.dart';

class ChatTile extends StatelessWidget {
   ChatTile({Key? key,required this.chatData}):super(key: key);
  Chat chatData;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetails(chatData: chatData,),)),
      title: Text(chatData.nAme),
      leading: CircleAvatar(backgroundImage: (chatData.avatar=="")?NetworkImage((chatData.isGroup)?"https://www.shutterstock.com/image-vector/avatar-icon-design-buddy-chat-260nw-1485904172.jpg":"https://t4.ftcdn.net/jpg/05/49/98/39/360_F_549983970_bRCkYfk0P6PP5fKbMhZMIb07mCJ6esXL.webp"):NetworkImage(chatData.avatar)
      ),
      subtitle: Text(chatData.message),
      trailing: Text(chatData.updatedAt),
    );
  }
}
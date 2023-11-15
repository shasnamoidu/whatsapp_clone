import 'package:flutter/material.dart';
import 'package:whatsapp_clone/pages/cameraPage.dart';
import 'package:whatsapp_clone/pages/chatPage.dart';
import 'package:whatsapp_clone/widgets/utilityWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'whatsApp',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        actions: [
          SizedBox(
            width: 30.0,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 30.0,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          ),
          UtilityWidget().widthSpacer(30),
          PopupMenuButton(
            color: Colors.white,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(child: Text("new Group")),
                PopupMenuItem(child: Text("new broadcast")),
                PopupMenuItem(child: Text("Linked devices")),
                PopupMenuItem(child: Text("stared messages")),
                PopupMenuItem(child: Text("payments")),
                PopupMenuItem(child: Text("settings")),
              ];
            },
          )
        ],
        bottom: TabBar(
          tabs: [
            Tab(
              icon: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
            Tab(
              child: Text(
                "chats",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                "status",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                "Calls",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          controller: _controller,
        ),
      ),
      body: TabBarView(controller: _controller, children: [
        CameraPAge(),
        ChatPage(),
        Text("status page"),
        Text("calls page"),
      ]),
    );
  }
}

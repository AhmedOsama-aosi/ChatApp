import 'package:chat_app/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/cubit/chat_cubit.dart';

import 'chat_screen.dart';

class AllChatsScreen extends StatelessWidget {
  List<Map> chats = [{}];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: false,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SettingScreen()));
        },
        child: Icon(
          Icons.add_rounded,
          size: 40,
        ),
      ),
      appBar: AppBar(
        title: Text("ChatRoom"),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.search), splashRadius: 20),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                ChatCubit chatCubit = ChatCubit.get(context);
                List usersList = chatCubit.listOfUsers;
                return ListView.builder(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    padding: EdgeInsets.all(12.0),
                    //shrinkWrap: true,
                    itemCount: usersList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (constext) => ChatScreen(
                                        title: "${usersList[index]["name"]}",
                                        theReciver: usersList[index],
                                      )));
                        },
                        child: SizedBox(
                          height: 75,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: const CircleAvatar(
                                  child: Icon(
                                    Icons.person,
                                    size: 40,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${usersList[index]["name"]}",
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text("12/5/2022")
                                      ],
                                    ),
                                    const Text("hello i watting you")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}

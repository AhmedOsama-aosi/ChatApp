import 'package:chat_app/all_chats_screen.dart';
import 'shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/chat_cubit.dart';

class LoginScreen extends StatelessWidget {
  final namecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "ChatRoom",
                  style: TextStyle(
                      fontSize: 30,
                      color: primarycolor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 8.0),
                  child: TextField(
                    controller: namecontroller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        //border: InputBorder.none,

                        hintText: "type your name"),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
                BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    ChatCubit chatCubit = ChatCubit.get(context);
                    return MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                        color: primarycolor,
                        textColor: Colors.white,
                        height: 45,
                        minWidth: 200,
                        child: Text("start chatting"),
                        onPressed: () {
                          if (namecontroller.text != "") {
                            chatCubit.name = namecontroller.text;
                            chatCubit.connectToServer();

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return AllChatsScreen();
                            }));
                          }
                        });
                  },
                )
              ],
            )),
      ),
    );
  }
}

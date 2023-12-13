import 'package:chat_app/cubit/chat_cubit.dart';
import 'package:chat_app/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'all_chats_screen.dart';
import 'shared.dart';

void main() {
  runApp(MyApp());
}

// List<Map> listOfMessages = [
//   {
//     "senderName": "mike",
//     "message": "This class is the configuration for the state. It holds the values in this" +
//         "case the title provided by the parentin this case the App widget) and" +
//         "used by the build method of the State. Fields in a Widget subclass are",
//     "time": "8:30pm"
//   },
//   {"senderName": "jack", "message": "hello ", "time": "8:31pm"},
//   {"senderName": "mike", "message": "hello guys", "time": "8:30pm"},
//   {"senderName": "mike", "message": "ok", "time": "8:30pm"},
//   {"senderName": "jack", "message": "hello ", "time": "8:31pm"},
//   {"senderName": "jack", "message": "ok ", "time": "8:31pm"},
// ];

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        theme: ThemeData(
          primarySwatch: materialcolor,
        ),
        // home: ChatScreen(title: 'Chat room'),
        //home: AllChatsScreen(),
        home: LoginScreen(),
      ),
    );
  }
}

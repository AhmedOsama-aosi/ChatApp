import 'package:chat_app/cubit/chat_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'shared.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key, required this.title, required this.theReciver})
      : super(key: key);

  final String title;
  final Map theReciver;
  final messageController = TextEditingController();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ChatCubit, ChatState>(
          buildWhen: ((previous, current) {
            if (current.runtimeType == Typing) {
              return true;
            } else {
              ChatCubit.get(context).typeing = "";
              return true;
            }
          }),
          builder: (context, state) {
            ChatCubit chatCubit = ChatCubit.get(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                chatCubit.typeing == ""
                    ? SizedBox()
                    : Text(
                        chatCubit.typeing,
                        style: TextStyle(fontSize: 12),
                      ),
              ],
            );
          },
        ),
      ),
      body: Column(
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.start,

        children: <Widget>[
          BlocBuilder<ChatCubit, ChatState>(
            buildWhen: ((previous, current) {
              if (current.runtimeType == NewMessage) {
                return true;
              } else {
                return false;
              }
            }),
            builder: (context, state) {
              ChatCubit chatCubit = ChatCubit.get(context);

              return chatCubit.name == ""
                  ? Spacer()
                  : Expanded(
                      child: MessageListView(
                          scrollController: scrollController,
                          chatCubit: chatCubit),
                    );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<ChatCubit, ChatState>(
              buildWhen: ((previous, current) {
                return true;
              }),
              builder: (context, state) {
                ChatCubit chatCubit = ChatCubit.get(context);
                return Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 4),
                                spreadRadius: 2),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextField(
                            onChanged: (value) {
                              chatCubit.sendTyping(to: theReciver["name"]);
                            },
                            minLines: 1,
                            maxLines: 4,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "type message"),
                            style: const TextStyle(fontSize: 20),
                            controller: messageController,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        splashRadius: 25,
                        iconSize: 45,
                        onPressed: () {
                          if (chatCubit.name == "") {
                            chatCubit.showAccountListDialog(context);
                          } else {
                            if (messageController.text != "") {
                              // final result = messageController.text.split('-');
                              // print(result);
                              // chatCubit.sendMessage(result[1], to: result[0]);
                              chatCubit.sendMessage(messageController.text,
                                  to: theReciver["name"]);
                              messageController.text = "";
                            }
                          }
                        },
                        icon: CircleAvatar(
                            radius: 25,
                            backgroundColor: primarycolor,
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                            )))
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class MessageListView extends StatelessWidget {
  const MessageListView({
    Key? key,
    required this.scrollController,
    required this.chatCubit,
  }) : super(key: key);

  final ScrollController scrollController;
  final ChatCubit chatCubit;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) =>
        {scrollController.jumpTo(scrollController.position.maxScrollExtent)});
    return ListView.builder(
        controller: scrollController,
        padding: EdgeInsets.all(12.0),
        shrinkWrap: true,
        itemCount: chatCubit.listOfMessages.length,
        itemBuilder: (context, index) {
          Map message = chatCubit.listOfMessages[index];
          bool isMe = message["senderName"] == chatCubit.name;

          return Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomRight: isMe ? Radius.zero : Radius.circular(15),
                    bottomLeft: isMe ? Radius.circular(15) : Radius.zero,
                  ),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: primarycolor.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                        spreadRadius: 2),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isMe)
                        SizedBox()
                      else
                        Text(
                          message["senderName"],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message["message"],
                                ),
                                SizedBox(
                                  width: 90,
                                )
                              ],
                            ),
                          ),
                          Text(
                            message["time"],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

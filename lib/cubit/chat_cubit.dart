import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  late io.Socket socket;
  List<Map> listOfMessages = [];
  List listOfUsers = [];

  String message = "";
  String name = "";
  String typeing = "";

  void connectToServer() {
    try {
      socket = io.io(
          'http://192.168.43.40:3000',
          io.OptionBuilder()
              .setQuery({"name": name})
              .setTransports(['websocket']) // for Flutter or Dart VM
              .disableAutoConnect() // disable auto-connection
              .build());

      // Connect to websocket
      socket.connect();

      // Handle socket events
      socket.on('connect', (_) => print('connect: ${socket.id}'));
      socket.on('users', (_) => sendUserInfo(_));
      socket.on('location', handleLocationListen);
      socket.on('typing', handleTyping);
      socket.on('message', handleMessage);
      socket.on('privatemassage', handlePrivateMessage);
      socket.on('disconnect', (_) => handleDisconnet);
      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e.toString());
    }
  }

// Send user info to assign socket id to it
  sendUserInfo(data) {
    print(data);
    listOfUsers = data;
    print(name);
    emit(ChatInitial());
  }

// Send Location to Server
  sendLocation(Map<String, dynamic> data) {
    socket.emit("location", data);
  }

// Listen to Location updates of connected usersfrom server
  handleLocationListen(data) async {
    print(data);
  }

// Send update of user's typing status
  sendTyping({String? to}) {
    socket.emit("typing", {"text": "$name is typing....", "to": "$to"});
  }

// Listen to update of typing status from connected users
  void handleTyping(data) {
    print(data);
    typeing = data;
    emit(Typing());
  }

// Send a Message to the server
  sendMessage(String message, {String to = ''}) {
    DateTime now = DateTime.now();
    String amORpm = "";
    int hour = 0;

    if (now.hour > 12) {
      hour = now.hour - 12;
      amORpm = "pm";
    } else {
      hour = now.hour;
      amORpm = "am";
    }
    String time = "$hour:${now.minute}$amORpm";
    if (to != '') {
      Map messageMap = {
        "senderName": name,
        "message": message,
        "time": time,
        "to": to
      };
      socket.emit('privatemassage', messageMap);
    } else {
      Map messageMap = {"senderName": name, "message": message, "time": time};
      socket.emit('message', messageMap);
    }

    emit(ChatInitial());
  }

// Listen to all message events from connected users
  void handleMessage(data) {
    print(data);
    listOfMessages.add(data);
    emit(NewMessage());
  }

// Listen to all message events from connected users
  void handlePrivateMessage(data) {
    typeing = "";
    print(data);
    listOfMessages.add(data);
    emit(NewMessage());
  }

  void handleDisconnet() {
    print("disconnected");
    // sendUserInfo();
  }

  Future<dynamic> showAccountListDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          final namecontroller = TextEditingController();
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: EdgeInsets.all(8.0),
            // title: Text("your name"),
            content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: namecontroller,
                        decoration: InputDecoration(
                            //border: InputBorder.none,
                            hintText: "type your name"),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 10),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                        color: Colors.blue,
                        textColor: Colors.white,
                        height: 45,
                        minWidth: 200,
                        child: Text("start chatting"),
                        onPressed: () {
                          name = namecontroller.text;

                          Navigator.pop(context);
                        })
                  ],
                )),
          );
        });
  }
}

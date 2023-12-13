part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class NewMessage extends ChatState {}

class Typing extends ChatState {}

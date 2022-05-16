import 'package:equatable/equatable.dart';
import 'package:phuquoc/feature/chatbot/domain/entities/chat_bot_request.dart';

abstract class ChatBotEvent extends Equatable {
  const ChatBotEvent();
}

class PostQuestionE extends ChatBotEvent{
  final ChatBotRequest request;

  PostQuestionE(this.request);

  @override
  // TODO: implement props
  List<Object?> get props => [request];
}

class ChatBotLoadingE extends ChatBotEvent{

  ChatBotLoadingE();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


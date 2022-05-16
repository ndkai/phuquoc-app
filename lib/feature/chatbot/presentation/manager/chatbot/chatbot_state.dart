import 'package:equatable/equatable.dart';
import 'package:phuquoc/feature/chatbot/data/models/chatbot_swagger.dart';

abstract class ChatBotState extends Equatable {
  const ChatBotState();
}

class ChatBotInitial extends ChatBotState {
  @override
  List<Object> get props => [];
}

class ChatBotLoading extends ChatBotState {
  @override
  List<Object> get props => [];
}

class ChatBotError extends ChatBotState {
  final String msg;

  ChatBotError(this.msg);
  @override
  List<Object> get props => [msg];
}


class PostQuestionLoaded extends ChatBotState {
  final ChatbotSwagger response;

  PostQuestionLoaded(this.response);
  @override
  List<Object> get props => [response];
}





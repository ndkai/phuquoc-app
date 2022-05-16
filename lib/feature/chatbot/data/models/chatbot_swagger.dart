import 'package:phuquoc/feature/chatbot/data/models/ChatBotResponse.dart';

class ChatbotSwagger{
  List<ChatBotResponse>? chatResponces;
  String? error;

  ChatbotSwagger({this.chatResponces, this.error});

  ChatbotSwagger.fromJson(Map<String, dynamic> json) {
    if (json['chatbotswagger'] != null) {
      chatResponces = <ChatBotResponse>[];
      json['chatbotswagger'].forEach((v) {
        chatResponces!.add(new ChatBotResponse.fromJson(v));
      });
    }
  }

}
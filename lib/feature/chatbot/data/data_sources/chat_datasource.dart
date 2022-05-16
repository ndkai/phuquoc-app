import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phuquoc/feature/chatbot/data/models/chatbot_swagger.dart';
import 'package:phuquoc/feature/chatbot/domain/entities/chat_bot_request.dart';

abstract class ChatDataSource {
  Future<ChatbotSwagger> postQuestion(ChatBotRequest request);
}

class ChatDataSourceImpl implements ChatDataSource {
  final http.Client? client;

  ChatDataSourceImpl({@required this.client});


  @override
  Future<ChatbotSwagger> postQuestion(ChatBotRequest request) {
    return _postQuestion(request);
  }

  Future<ChatbotSwagger> _postQuestion(ChatBotRequest request) async{
    try{
      await Future.delayed(Duration(seconds: 1));
      var data = json.encode(request);
      final response = await client!
          .post(Uri.parse("http://202.78.227.48:5005/webhooks/rest/webhook"), headers: {
          // .post(Uri.parse("https://chatbot.titkul.edu.vn/webhooks/rest/webhook"), headers: {
          // .post(Uri.parse("https://chatbotpq.bakco.vn"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
          body: data).timeout(Duration(seconds: 20));
      print("_postQuestion ${request.toJson()}");
      print("_postQuestion ${response.statusCode}");
      print("_postQuestion ${response.body}");
      if(response.statusCode == 200){
        String body = "{\"chatbotswagger\": ${response.body}}";
        ChatbotSwagger data = ChatbotSwagger.fromJson(jsonDecode(body));
        print("_postQuestion data ${data.chatResponces!.length}");
        return data;
      } else{
        return ChatbotSwagger(error: response.body);
      }
    }  catch(e){
      return ChatbotSwagger(error: e.toString());
    }

  }










}

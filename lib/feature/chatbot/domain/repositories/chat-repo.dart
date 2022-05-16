import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/feature/chatbot/data/models/chatbot_swagger.dart';
import 'package:phuquoc/feature/chatbot/domain/entities/chat_bot_request.dart';

abstract class ChatRepo {
  Future<Either<Failure, ChatbotSwagger>> postQuestion(ChatBotRequest request);
}

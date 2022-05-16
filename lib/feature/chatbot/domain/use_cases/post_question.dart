import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/chatbot/data/models/chatbot_swagger.dart';
import 'package:phuquoc/feature/chatbot/domain/entities/chat_bot_request.dart';
import 'package:phuquoc/feature/chatbot/domain/repositories/chat-repo.dart';

class PostQuestionUc implements UseCase<ChatbotSwagger, ChatBotRequest> {
  final ChatRepo chatRepo;

  PostQuestionUc(this.chatRepo);

  @override
  Future<Either<Failure, ChatbotSwagger>> call(ChatBotRequest params) async {
    return chatRepo.postQuestion(params);
  }
}

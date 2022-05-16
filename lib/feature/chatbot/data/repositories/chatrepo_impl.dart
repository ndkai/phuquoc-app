import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/constants.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/network/network_info.dart';
import 'package:phuquoc/feature/chatbot/data/data_sources/chat_datasource.dart';
import 'package:phuquoc/feature/chatbot/data/models/chatbot_swagger.dart';
import 'package:phuquoc/feature/chatbot/domain/entities/chat_bot_request.dart';
import 'package:phuquoc/feature/chatbot/domain/repositories/chat-repo.dart';

class ChatRepoImpl extends ChatRepo {
  final NetworkInfo? networkInfo;
  final ChatDataSource? chatDataSource;

  ChatRepoImpl({
    this.networkInfo,
    this.chatDataSource,
  });

  @override
  Future<Either<Failure, ChatbotSwagger>> postQuestion(ChatBotRequest request) {
    return _postQuestion(chatDataSource!.postQuestion(request));
  }


  Future<Either<Failure, ChatbotSwagger>> _postQuestion(
      Future<ChatbotSwagger> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(data.error != null){
          return Left(ServerFailure(data.error.toString()));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }






}

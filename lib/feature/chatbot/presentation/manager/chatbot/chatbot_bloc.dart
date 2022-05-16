import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:phuquoc/feature/chatbot/domain/use_cases/post_question.dart';

import 'bloc.dart';

class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  final PostQuestionUc postQuestionUc;

  ChatBotBloc(this.postQuestionUc) : super(ChatBotInitial()){
    on<PostQuestionE>(_postQuestion);
    on<ChatBotLoadingE>(_loading);
  }


  Future<void> _postQuestion(PostQuestionE event, Emitter<ChatBotState> emit) async {
    var result = await postQuestionUc(event.request);
    return emit(
        result.fold(
                (l) => ChatBotError(l.msg),
                (r) => r.error == null? PostQuestionLoaded(r) : ChatBotError(r.error.toString())));
  }

  Future<void> _loading(ChatBotLoadingE event, Emitter<ChatBotState> emit) async {
    return emit(
        ChatBotLoading()
    );
  }

}

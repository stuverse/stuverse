import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/mentor/models/mentor_post.dart';


part 'mentor_home_state.dart';

class MentorHomeCubit extends Cubit<MentorHomeState> {
  MentorHomeCubit() : super(MentorHomeInitial());
  void getMentorHomeData(
    {String? search}
  )async{
    emit(MentorHomeLoading());
    try {
      final resp =await dioClient.get('/mentor/posts', queryParameters: {'search': search});
      final List <MentorPost> posts=[];
      for(final post in resp.data){
        posts.add(MentorPost.fromJson(post));
      }
      emit(MentorHomeLoaded(posts));
    } catch (e) {
      emit(MentorHomeFailure(e.toString()));
      print(e);
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';

import '../../models/community/community.dart';

part 'forum_home_state.dart';

class ForumHomeCubit extends Cubit<ForumHomeState> {
  ForumHomeCubit() : super(ForumHomeInitial());
  void getHomeData({bool isSilent = false}) async {
    if (!isSilent) emit(ForumHomeLoading());

    try {
      final resp = await dioClient.get(FORUM_HOME_API);
      final data = resp.data;
      final List<Community> popularCommunities = [
        for (final community in data["popular"]) Community.fromJson(community)
      ];
      final List<Community> yourCommunities = [
        for (final community in data["userCommunities"])
          Community.fromJson(community)
      ];

      final List<Thread> threads = [
        for (final thread in data["latestThreads"]) Thread.fromJson(thread)
      ];

      emit(ForumHomeLoaded(
        popularCommunities: popularCommunities,
        yourCommunities: yourCommunities,
        threads: threads,
      ));
    } catch (e) {
      emit(ForumHomeError(message: e.toString()));
    }
  }
}

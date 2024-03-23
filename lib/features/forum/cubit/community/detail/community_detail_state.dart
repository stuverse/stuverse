part of 'community_detail_cubit.dart';

@immutable
final class CommunityDetailState {
  final Community? community;
  final List<Thread> threads;
  final APIStatus communityStatus;
  final APIStatus threadsStatus;
  final String? message;

  CommunityDetailState(
      {required this.threads,
      required this.communityStatus,
      required this.threadsStatus,
      this.community,
      this.message});

  CommunityDetailState copyWith(
      {Community? community,
      List<Thread>? threads,
      APIStatus? communityStatus,
      APIStatus? threadsStatus,
      String? message}) {
    return CommunityDetailState(
        community: community ?? this.community,
        threads: threads ?? this.threads,
        communityStatus: communityStatus ?? this.communityStatus,
        threadsStatus: threadsStatus ?? this.threadsStatus,
        message: message ?? this.message);
  }
}

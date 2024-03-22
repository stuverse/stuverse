import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

import '../../cubit/community/members/community_members_cubit.dart';
import '../../../../app/models/mini_user.dart';
import '../../widgets/community/member_card.dart';

class CommunityMembersManageScreen extends StatefulWidget {
  const CommunityMembersManageScreen({super.key, required this.communityId});
  final int communityId;

  @override
  State<CommunityMembersManageScreen> createState() =>
      _CommunityMembersManageScreenState();
}

class _CommunityMembersManageScreenState
    extends State<CommunityMembersManageScreen> {
  final _searchController = TextEditingController();

   List<MiniUser> filteredMembers = [];
  @override
  void initState() {
    context.read<CommunityMembersCubit>().getCommunityMembers(widget.communityId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BgGradient(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Members list'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                  context.push(
                    CommonRoutes.usersList,
                    extra: (List<MiniUser> usersList){
                      context.read<CommunityMembersCubit>().addMembers(
                        communityId: widget.communityId,
                        users: usersList
                      );
                    }
                  );
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocConsumer<CommunityMembersCubit, CommunityMembersState>(
            listener: (context, state) {
              if (state is CommunityMembersError) {
                context.showErrorMessage(
                  message: state.message,
                  duration: 3.seconds,
                );
              }
              if(state is CommunityMemberAddError){
                context.showErrorMessage(
                  message: state.message,
                  duration: 3.seconds,
                );
              }
              if(state is CommunityMemberRemoveError){
                context.showErrorMessage(
                  message: state.message,
                  duration: 3.seconds,
                );
              }

              if(state is CommunityMemberAdded){
                context.showMessage(
                  message: "Member added successfully",
                  duration: 3.seconds,
                );
              }
              if(state is CommunityMemberRemoved){
                context.showMessage(
                  message: "Member removed successfully",
                  duration: 3.seconds,
                );
              }
              if(state is CommunityMembersLoaded){
                filteredMembers = state.members;
              }

             
              
            },
            builder: (context, state) {
              if (state is CommunityMembersLoaded) {
                
                   return SingleChildScrollView(
                     child: Column(
                                     children: [
                                       TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          filteredMembers = state.members
                              .where((member) => member.name!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(
                          Icons.search,
                        ),
                      ),
                                       ),
                                       10.heightBox,
                                      for(final member in filteredMembers)
                                       MembersCard(
                                         member: member,
                                         communityId: widget.communityId,
                                       )
                                     ],
                                   ),
                   );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
             
            },
          ).paddingAll(8),
        ),
      ),
    );
  }
}

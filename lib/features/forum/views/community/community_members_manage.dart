import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

import '../../widgets/community/member_card.dart';

class CommunityMembersManageScreen extends StatefulWidget {
  const CommunityMembersManageScreen({super.key});

  @override
  State<CommunityMembersManageScreen> createState() => _CommunityMembersManageScreenState();
}

class _CommunityMembersManageScreenState extends State<CommunityMembersManageScreen> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user= context.read<CoreCubit>().state.user;
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
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      body: SafeArea(child: Column(
        children: [
                  TextField(
                              controller: _searchController,
                               decoration: InputDecoration(
                                hintText: 'Search',
                                prefixIcon: Icon(
                                  Icons.search,
                                ),
                              ),
                  ),
                  10.heightBox,
                  MembersCard(
                    image: user?.image ?? "",
                    title: user?.name ?? "",
                    subtitle: '1 mo ago . Full Permissions',
                  )
                  ],
                ).paddingAll(8),
      ),),
             
            
          );
        
     
  }
}


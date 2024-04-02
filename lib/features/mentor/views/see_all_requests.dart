import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/mentor/cubit/mentor_request/cubit/mentorship_request_cubit.dart';

import '../widgets/request_card.dart';

class seeAllRequestsScreen extends StatefulWidget {
  const seeAllRequestsScreen({super.key});

  @override
  State<seeAllRequestsScreen> createState() => _seeAllRequestsScreenState();
}

class _seeAllRequestsScreenState extends State<seeAllRequestsScreen> {
   void initState() {
    context
        .read<MentorshipRequestCubit>()
        .getMentorRequestData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _searchController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(child: SingleChildScrollView(
           
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(27),
                              color: Color.fromARGB(242, 231, 230, 230),
                            ),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                context
                                    .read<MentorshipRequestCubit>()
                                    .getMentorRequestData(
                                        search: _searchController.text);
                              },
                              decoration: InputDecoration(
                                hintText: 'Search',
                                prefixIcon: Icon(
                                  Icons.search,
                                ),
                              ),
                            ),
                          ).paddingSymmetric(horizontal: 20),
              BlocBuilder<MentorshipRequestCubit, MentorshipRequestState>(
                builder: (context, state) {
                  if(state is MentorshipRequestFailure){
                    return Center(
                      child: Text('Error'),);
                  }
                  if(state is MentorshipRequestLoaded){
                   return Padding(
                     padding: const EdgeInsets.all(10),
                     child: Column(
                      children: [
                        for(final request in state.requests)
                        RequestCard(request: request),
                      ],
                                 ),
                   );
              
                  }
                 return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        )
        )
        );
  }
}

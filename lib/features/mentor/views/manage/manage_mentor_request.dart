import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/mentor/cubit/mentor_request/cubit/mentorship_request_cubit.dart';
import 'package:stuverse/features/mentor/models/mentor_request.dart';

import '../../cubit/manage_mentor_request/cubit/manage_mentor_request_cubit.dart';
import '../../routes/mentor_routes.dart';

class ManageMentorRequest extends StatefulWidget {
  const ManageMentorRequest({super.key, required this.mentorRequest});
  final MentorRequest? mentorRequest;

  @override
  State<ManageMentorRequest> createState() => _ManageMentorRequestState();
}

class _ManageMentorRequestState extends State<ManageMentorRequest> {
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void initState() {
    if (widget.mentorRequest != null) {
    _descriptionController.text= widget.mentorRequest!.description;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final user = context.read<CoreCubit>().state.user;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Form(
        key: _formKey,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Post Your Mentorship Request',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              20.heightBox,
             
              LabeledFormInput(child: TextFormField(controller: _descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Share your mentorship needs here',
          
              ),), label: 'Description'),
              10.heightBox,
              BlocConsumer<ManageMentorRequestCubit, ManageMentorRequestState>(
                listener: (context, state) {
                  if(state is ManageMentorRequestFailure){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message))
                    );
                  }
                  if(state is ManageMentorRequestLoaded){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message))
                    );
                    context.pushReplacement(MentorRoutes.mentorHome);
                    context.read<MentorshipRequestCubit>().getMentorRequestData();
                  }
                },
                builder: (context, state) =>state is ManageMentorRequestLoading? Center(child: CircularProgressIndicator())
                  
                  :ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final description = _descriptionController.text;
                       widget.mentorRequest == null
                       ? context.read<ManageMentorRequestCubit>().addRequest(mentorId: user!.id!, description: description)
                        :context.read<ManageMentorRequestCubit>().editRequest(mentorId: user!.id!, description: description, id: widget.mentorRequest!.id);
                      }
                    },
                    child: Text(
                      widget.mentorRequest!=null
                      ?'Save'
                      :'Post',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 40),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),),

              
              
            ],
          ),
        )),
      ),
    );
  }
}

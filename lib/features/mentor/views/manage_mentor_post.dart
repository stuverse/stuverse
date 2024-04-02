import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/mentor/mentor.dart';
import 'package:stuverse/features/mentor/models/mentor_post.dart';
import '../cubit/manage_mentor_post/manage_mentor_post_cubit.dart';
import '../cubit/manage_mentor_post/manage_mentor_post_state.dart';
import '../cubit/search/mentor_search_cubit.dart';

class ManageMentorPostScreen extends StatefulWidget {
  const ManageMentorPostScreen({super.key, this.post});
  final MentorPost? post;
  @override
  State<ManageMentorPostScreen> createState() => _ManageMentorPostScreenState();
}

class _ManageMentorPostScreenState extends State<ManageMentorPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _postController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  bool isFree = true;

  @override
  void initState() {
    if (widget.post != null) {
      _postController.text = widget.post!.name;
      _descriptionController.text = widget.post!.description;
      _priceController.text = widget.post!.price.toString();
      if (widget.post!.isFree) {
        isFree = true;
      }
      if (!widget.post!.isFree) {
        isFree = false;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<CoreCubit>().state.user;
    return Form(
      key: _formKey,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post != null
                          ? 'Edit Your Mentorship Post'
                          : 'Craft Your Mentorship Offer',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Mentorship Focus',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                      controller: _postController,
                      decoration: InputDecoration(
                        hintText: 'Enter your mentorship focus',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Description',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.push(CommonRoutes.markdownEditor,
                                extra: MarkDownScreenProps(
                                  onSaved: (value) {
                                    _descriptionController.text = value;
                                    setState(() {});
                                    context.pop();
                                  },
                                  initialText: _descriptionController.text,
                                ));
                          },
                          icon: const Icon(Icons.visibility),
                          label: const Text("Preview / Edit"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                      enabled: true,
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Enter the post description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Mentorship Fee',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        RadioMenuButton<bool>(
                          value: true,
                          groupValue: isFree,
                          onChanged: (value) {
                            setState(() {
                              isFree = value!;
                            });
                          },
                          child: Text('Free'),
                        ),
                        RadioMenuButton<bool>(
                          value: false,
                          groupValue: isFree,
                          onChanged: (value) {
                            setState(() {
                              isFree = value!;
                            });
                          },
                          child: Text('Paid'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (!isFree)
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          return null;
                        },
                        controller: _priceController,
                        decoration: InputDecoration(
                          hintText: 'Enter the fee per hour',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    SizedBox(height: 10),
                    BlocConsumer<ManageMentorPostCubit, ManageMentorPostState>(
                      listener: (context, state) {
                        if (state is ManageMentorPostFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.message),
                          ));
                        }
                        if (state is ManageMentorPostLoaded) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.message),
                          ));
                          context.pushReplacement(MentorRoutes.mentorHome);
                          context
                              .read<MentorSearchCubit>()
                              .getMentorSearchData();
                        }
                      },
                      builder: (context, state) => state
                              is ManageMentorPostLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final postName = _postController.text;
                                  final fee =
                                      isFree ? '0.00' : _priceController.text;
                                  final description =
                                      _descriptionController.text;
                                  widget.post == null
                                      ? context
                                          .read<ManageMentorPostCubit>()
                                          .addPost(
                                            postName: postName,
                                            fee: double.parse(fee),
                                            isFree: isFree,
                                            description: description,
                                            mentorId: user!.id!,
                                          )
                                      : context
                                          .read<ManageMentorPostCubit>()
                                          .editPost(
                                            id: widget.post!.id,
                                            postName: postName,
                                            fee: double.parse(fee),
                                            isFree: isFree,
                                            description: description,
                                            mentorId: user!.id!,
                                          );
                                }
                              },
                              child: Text(widget.post != null ? 'Save' : 'Post',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(double.infinity, 40),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

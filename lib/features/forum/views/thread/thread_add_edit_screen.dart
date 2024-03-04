// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';

class ThreadAddEditScreen extends StatefulWidget {
  const ThreadAddEditScreen({
    super.key,
    required this.props,
  });
  final ThreadAddEditScreenProps props;

  @override
  State<ThreadAddEditScreen> createState() => _ThreadAddEditScreenState();
}

class _ThreadAddEditScreenState extends State<ThreadAddEditScreen> {
  late final bool isEdit;

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  XFile? _selectedImage;

  void _pickImage() async {
    try {
      final imagePicker = ImagePicker();
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _selectedImage = pickedImage;
        });
      }
    } catch (e) {
      log("Crash Error: $e");
    }
  }

  @override
  void initState() {
    isEdit = widget.props.thread != null;
    if (isEdit) {
      _titleController.text = widget.props.thread!.title ?? "";
      _contentController.text = widget.props.thread!.content ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Thread" : "Add Thread"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: context.height * 0.3,
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.2),
                  child: Stack(
                    children: [
                      if (_selectedImage != null)
                        Positioned.fill(
                          child: Image.file(
                            File(_selectedImage!.path),
                            fit: BoxFit.cover,
                          ),
                        )
                      else if (widget.props.thread != null &&
                          widget.props.thread!.image != null)
                        Positioned.fill(
                          child: Image.network(
                            widget.props.thread!.image ?? "",
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                      else if (_selectedImage == null)
                        Center(
                          child: Text("No Image Selected"),
                        ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: ElevatedButton(
                          onPressed: _pickImage,
                          child: Text("Pick Image"),
                        ),
                      ),
                    ],
                  ),
                ),
                LabeledFormInput(
                  child: TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Title is required";
                      }
                      if (value.length < 3) {
                        return "Title must be at least 3 characters";
                      }
                      if (value.length > 50) {
                        return "Title must be at most 50 characters";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Title",
                    ),
                    maxLength: 50,
                  ),
                  label: "Title",
                ),
                LabeledFormInput(
                  child: TextFormField(
                    controller: _contentController,
                    validator: (value) {
                      if (value!.length > 400) {
                        return "Content must be at most 400 characters";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Content",
                    ),
                    maxLines: 5,
                    maxLength: 400,
                  ),
                  label: "Content",
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.tonal(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (isEdit) {
                          context.read<ThreadManageCubit>().editThread(
                                threadId: widget.props.thread!.id!,
                                title: _titleController.text,
                                content: _contentController.text,
                                image: _selectedImage,
                              );
                        } else {
                          context.read<ThreadManageCubit>().addThread(
                                title: _titleController.text,
                                content: _contentController.text,
                                communityId: widget.props.communityId,
                                image: _selectedImage,
                              );
                        }
                      }
                    },
                    child: BlocConsumer<ThreadManageCubit, ThreadManageState>(
                      listener: (context, state) {
                        if (state is ThreadUpdateError ||
                            state is ThreadCreateError) {
                          context.showErrorMessage(
                            message: "Something went wrong",
                            duration: 3.seconds,
                          );
                        }
                        if (state is ThreadUpdateSuccess ||
                            state is ThreadCreateSuccess) {
                          context.showMessage(
                            message:
                                isEdit ? "Thread Updated" : "Thread Created",
                            duration: 3.seconds,
                          );
                          context
                              .read<CommunityDetailCubit>()
                              .getCommunityThreads(
                                  communityId: widget.props.communityId);
                          context.pop();
                        }
                      },
                      builder: (context, state) {
                        if (state is ThreadUpdateLoading ||
                            state is ThreadCreateLoading) {
                          return const CircularProgressIndicator();
                        }

                        return Text(isEdit ? "Edit" : "Add");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThreadAddEditScreenProps {
  final Thread? thread;
  final int communityId;

  ThreadAddEditScreenProps({
    required this.communityId,
    this.thread,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'thread': thread?.toJson(),
      'communityId': communityId,
    };
  }

  factory ThreadAddEditScreenProps.fromMap(Map<String, dynamic> map) {
    return ThreadAddEditScreenProps(
      thread: map['thread'] != null
          ? Thread.fromJson(map['thread'] as Map<String, dynamic>)
          : null,
      communityId: map['communityId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ThreadAddEditScreenProps.fromJson(String source) =>
      ThreadAddEditScreenProps.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

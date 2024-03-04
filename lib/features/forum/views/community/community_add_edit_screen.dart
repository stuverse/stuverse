import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';

class CommunityAddEditScreen extends StatefulWidget {
  const CommunityAddEditScreen({super.key, this.community});
  final Community? community;

  @override
  State<CommunityAddEditScreen> createState() => _CommunityAddEditScreenState();
}

class _CommunityAddEditScreenState extends State<CommunityAddEditScreen> {
  late final bool isEdit;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  XFile? _selectedImage;

  bool _isPrivate = false;

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
    isEdit = widget.community != null;
    if (isEdit) {
      _nameController.text = widget.community!.name ?? "";
      _descriptionController.text = widget.community!.description ?? "";
      _isPrivate = widget.community!.isPrivate ?? false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Community" : "Add Community"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: context.width * 0.5,
                width: context.width * 0.5,
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
                    else if (widget.community != null)
                      Positioned.fill(
                        child: Image.network(
                          widget.community!.image ?? "",
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
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is required";
                    }
                    if (value.length < 3) {
                      return "Name must be at least 3 characters";
                    }
                    if (value.length > 15) {
                      return "Name must be at most 15 characters";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Name",
                  ),
                  maxLength: 15,
                ),
                label: "Name",
              ),
              LabeledFormInput(
                child: TextFormField(
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description is required";
                    }
                    if (value.length < 3) {
                      return "Description must be at least 3 characters";
                    }
                    if (value.length > 400) {
                      return "Description must be at most 400 characters";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Description",
                  ),
                  maxLines: 5,
                  maxLength: 400,
                ),
                label: "Description",
              ),
              CheckboxListTile(
                value: _isPrivate,
                onChanged: (value) {
                  setState(() {
                    _isPrivate = value!;
                  });
                },
                title: Text("Private"),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonal(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (isEdit) {
                        context.read<CommunityManageCubit>().editCommunity(
                              communityId: widget.community!.id!,
                              name: _nameController.text,
                              description: _descriptionController.text,
                              isPrivate: _isPrivate,
                              image: _selectedImage,
                            );
                      } else {
                        context.read<CommunityManageCubit>().addCommunity(
                              name: _nameController.text,
                              description: _descriptionController.text,
                              isPrivate: _isPrivate,
                              image: _selectedImage,
                            );
                      }
                    }
                  },
                  child:
                      BlocConsumer<CommunityManageCubit, CommunityManageState>(
                    listener: (context, state) {
                      if (state is CommunityUpdateError ||
                          state is CommunityCreateError) {
                        context.showErrorMessage(
                          message: "Something went wrong",
                          duration: 3.seconds,
                        );
                      }
                      if (state is CommunityUpdateSuccess ||
                          state is CommunityCreateSuccess) {
                        context.showMessage(
                          message: isEdit
                              ? "Community Updated"
                              : "Community Created",
                          duration: 3.seconds,
                        );
                        context.read<CommunityAdminCubit>().getAllCommunities();
                        context.pop();
                      }
                    },
                    builder: (context, state) {
                      if (state is CommunityUpdateLoading ||
                          state is CommunityCreateLoading) {
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
    );
  }
}

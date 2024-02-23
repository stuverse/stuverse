// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../cubit/add_edit/manage_job_cubit.dart';
import '../../cubit/home/job_home_cubit.dart';
import '../../models/job_post.dart';

class AddEditJobPostScreen extends StatefulWidget {
  const AddEditJobPostScreen({super.key, this.post});

  final JobPost? post;

  @override
  State<AddEditJobPostScreen> createState() => _AddEditJobPostScreenState();
}

class _AddEditJobPostScreenState extends State<AddEditJobPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _placeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _jobTypeController = TextEditingController();
  final _urlController = TextEditingController();
  XFile? _selectedImage;
  String? _selectedJobType;

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
    if (widget.post != null) {
      _titleController.text = widget.post!.title;
      _companyNameController.text = widget.post!.companyName;
      _placeController.text = widget.post!.place;
      _descriptionController.text = widget.post!.description;
      _jobTypeController.text = widget.post!.jobType;
      _urlController.text = widget.post!.url;
      _selectedJobType = widget.post!.jobType;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post != null ? "Edit Job " : " Add Job "),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _pickImage();
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: _selectedImage != null
                        ? FileImage(File(_selectedImage!.path))
                        : widget.post?.image != null
                            ? NetworkImage(widget.post!.image) as ImageProvider
                            : null,
                  ),
                ),
                TextButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: Text("Pick Image")),
                const SizedBox(height: 20),
                TextFormField(
                    maxLength: 50,
                    controller: _titleController,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'job title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    }),
                const SizedBox(height: 10),
                TextFormField(
                    maxLength: 50,
                    controller: _companyNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "company name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    }),
                const SizedBox(height: 10),
                TextFormField(
                    maxLength: 50,
                    controller: _placeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'place',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    }),
                const SizedBox(height: 10),
                // DescriptionSheetField(
                //     onSaved: (String? value) {
                //       setState(() {
                //         _descriptionController.text = value ?? "";
                //       });
                //     },
                //     descriptionController: _descriptionController),
                TextFormField(
                    maxLength: 5000,
                    maxLines: 7,
                    onTap: () {},
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'description',
                      alignLabelWithHint: true,
                      hintText: "description",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    }),
                const SizedBox(height: 10),
                DropdownButton(
                    value: _selectedJobType,
                    items: [
                      DropdownMenuItem(
                        child: Text("Full Time"),
                        value: JOB_TYPE.FULL_TIME,
                      ),
                      DropdownMenuItem(
                        child: Text("Part Time"),
                        value: JOB_TYPE.PART_TIME,
                      ),
                      DropdownMenuItem(
                        child: Text("Contract"),
                        value: JOB_TYPE.CONTRACT,
                      ),
                      DropdownMenuItem(
                        child: Text("Internship"),
                        value: JOB_TYPE.INTERNSHIP,
                      ),
                      DropdownMenuItem(
                        child: Text("Temporary"),
                        value: JOB_TYPE.TEMPORARY,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedJobType = value;
                      });
                    }),
                const SizedBox(height: 10),
                TextFormField(
                    maxLength: 50,
                    onTap: () {},
                    controller: _urlController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'url',
                    ),
                    validator: (value) {
                      //regex validation of url
                      final pattern =
                          r"^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$";
                      final regExp = RegExp(pattern);
                      if (!regExp.hasMatch(value!)) {
                        return "Please enter a valid url";
                      }

                      return null;
                    }),
                const SizedBox(height: 30),
                BlocBuilder<ManageJobCubit, ManageJobState>(
                  builder: (context, state) {
                    if (state is ManageJobLoading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_selectedJobType == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please select a job type"),
                              ),
                            );
                            return;
                          }
                          widget.post == null
                              ? context.read<ManageJobCubit>().addJob(
                                    title: _titleController.text,
                                    description: _descriptionController.text,
                                    place: _placeController.text,
                                    companyName: _companyNameController.text,
                                    jobType: _jobTypeController.text,
                                    url: _urlController.text,
                                    image: _selectedImage,
                                  )
                              : context.read<ManageJobCubit>().editJob(
                                    id: widget.post!.id,
                                    title: _titleController.text,
                                    description: _descriptionController.text,
                                    place: _placeController.text,
                                    companyName: _companyNameController.text,
                                    jobType: _jobTypeController.text,
                                    url: _urlController.text,
                                    image: _selectedImage,
                                  );
                        }
                      },
                      child: Text(
                        widget.post != null ? "Edit Post" : "Post Job",
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, 50),
                        backgroundColor: Color.fromARGB(255, 1, 27, 72),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

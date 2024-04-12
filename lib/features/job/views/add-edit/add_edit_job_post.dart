// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stuverse/app/app.dart';
import '../../cubit/add_edit/manage_job_cubit.dart';
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

  final _urlController = TextEditingController();
  XFile? _selectedImage;
  String? _selectedJobType;
  String? _selectedJobLocationType;
  List<Skill> _selectedSkills = [];

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
    context.read<SkillCubit>().getSkills();
    if (widget.post != null) {
      _titleController.text = widget.post?.title ?? "";
      _companyNameController.text = widget.post?.companyName ?? "";
      _placeController.text = widget.post?.place ?? "";
      _descriptionController.text = widget.post?.description ?? "";
      _urlController.text = widget.post?.url ?? "";
      _selectedJobType = widget.post!.jobType;
      _selectedJobLocationType = widget.post!.jobLocationType;
      _selectedSkills = [...widget.post?.skills ?? []];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BgGradient(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.post != null ? "Edit Job " : " Add Job "),
        ),
        body: Form(
          key: _formKey,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: BlocConsumer<SkillCubit, SkillState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is SkillSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _pickImage();
                          },
                          child: Center(
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: _selectedImage != null
                                  ? FileImage(File(_selectedImage!.path))
                                  : widget.post?.image != null
                                      ? CachedNetworkImageProvider(
                                              widget.post?.image ?? "")
                                          as ImageProvider
                                      : null,
                            ),
                          ),
                        ),
                        Center(
                          child: TextButton.icon(
                              onPressed: _pickImage,
                              icon: const Icon(Icons.image),
                              label: Text("Pick Image")),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Job Title",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
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
                        Text(
                          "Job Company Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
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
                        Text(
                          "Job Place",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
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

                        const Text(
                          "Choose job type",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField(
                            isExpanded: true,
                            value: _selectedJobType,
                            validator: (value) {
                              if (value == null) {
                                return "Please select a job type";
                              }
                              return null;
                            },
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
                        SizedBox(height: 15),
                        const Text(
                          "Choose job Location type",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        DropdownButtonFormField(
                            isExpanded: true,
                            value: _selectedJobLocationType,
                            validator: (value) {
                              if (value == null) {
                                return "Please select a job Location type";
                              }
                              return null;
                            },
                            items: [
                              DropdownMenuItem(
                                child: Text("Remote"),
                                value: JOB_LOCATION_TYPE.REMOTE,
                              ),
                              DropdownMenuItem(
                                child: Text("Hybrid"),
                                value: JOB_LOCATION_TYPE.HYBRID,
                              ),
                              DropdownMenuItem(
                                  child: Text("Onsite"),
                                  value: JOB_LOCATION_TYPE.ONSITE),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedJobLocationType = value;
                              });
                            }),

                        const SizedBox(height: 15),
                        Text(
                          "Select Your  skills",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        DropdownSearch<Skill>.multiSelection(
                          items: state.skills,
                          selectedItems: _selectedSkills,
                          onChanged: (selectedItems) {
                            setState(() {
                              _selectedSkills = selectedItems;
                            });
                          },
                          itemAsString: (item) {
                            return item.name.toString();
                          },
                          popupProps: PopupPropsMultiSelection.dialog(
                            searchDelay: 100.milliseconds,
                            showSearchBox: true,
                          ),
                        ),
                        15.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Job Description",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
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
                        const SizedBox(height: 10),

                        TextFormField(
                            maxLength: 5000,
                            maxLines: 7,
                            enabled: false,
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
                        Text(
                          "Job Apply Url",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
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
                              return Center(
                                  child: const CircularProgressIndicator());
                            }
                            return Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (_selectedJobType == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Please select a job type"),
                                        ),
                                      );
                                      return;
                                    }
                                    widget.post == null
                                        ? context.read<ManageJobCubit>().addJob(
                                              title: _titleController.text,
                                              description:
                                                  _descriptionController.text,
                                              place: _placeController.text,
                                              companyName:
                                                  _companyNameController.text,
                                              jobType: _selectedJobType!,
                                              jobLocationType:
                                                  _selectedJobLocationType!,
                                              url: _urlController.text,
                                              skillsId: _selectedSkills
                                                  .map((e) => e.id!)
                                                  .toList(),
                                              image: _selectedImage,
                                            )
                                        : context
                                            .read<ManageJobCubit>()
                                            .editJob(
                                              id: widget.post!.id!,
                                              title: _titleController.text,
                                              description:
                                                  _descriptionController.text,
                                              place: _placeController.text,
                                              companyName:
                                                  _companyNameController.text,
                                              jobType: _selectedJobType!,
                                              jobLocationType:
                                                  _selectedJobLocationType!,
                                              url: _urlController.text,
                                              skillsId: _selectedSkills
                                                  .map((e) => e.id!)
                                                  .toList(),
                                              image: _selectedImage,
                                            );
                                  }
                                },
                                child: Text(
                                  widget.post != null
                                      ? "Edit Post"
                                      : "Post Job",
                                ),
                                style: ElevatedButton.styleFrom(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                  minimumSize: Size(150, 50),
                                  backgroundColor:
                                      Color.fromARGB(255, 1, 27, 72),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          )),
        ),
      ),
    );
  }
}

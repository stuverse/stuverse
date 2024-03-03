import 'dart:developer';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/profile/cubit/manage_profile_cubit.dart';

import '../cubit/skill/skill_cubit.dart';

class ManageProfileScreen extends StatefulWidget {
  const ManageProfileScreen({super.key});

  @override
  State<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _aboutController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _githubController = TextEditingController();

  final _experienceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  User? user;
  @override
  void initState() {
    context.read<SkillCubit>().getSkills();
    user = context.read<CoreCubit>().state.user;
    _nameController.text = user!.name.toString();
    _mobileController.text = user!.mobile.toString();
    _aboutController.text = user!.about.toString();
    _linkedinController.text = user!.linkedin.toString();
    _githubController.text = user!.github.toString();
    _experienceController.text = user!.experienceYears.toString();
    _selectedSkills = [...List.castFrom<Skill, Skill>(user!.skills!)];

    super.initState();
  }

  File? _resumeFile;
  File? _imageFile;
  List<Skill> _selectedSkills = [];

  void pickImage({
    required ImageSource source,
  }) async {
    try {
      final imagePicker = ImagePicker();
      final pickedImage = await imagePicker.pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          _imageFile = File(pickedImage.path);
        });
      }
    } catch (e) {
      log("Crash Error: $e");
    }
  }

  void pickFile() async {
    try {
      // final status = await Permission.manageExternalStorage.request();
      // if (status.isDenied ||
      //     status.isPermanentlyDenied ||
      //     status.isRestricted) {
      //   throw "Please allow storage permission to upload files";
      // }
      // log("status: $status");
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: [
          'pdf',
        ],
      );
      if (result != null) {
        setState(() {
          _resumeFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      print('errror is $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    user = context.watch<CoreCubit>().state.user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
        ),
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: BlocConsumer<SkillCubit, SkillState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is SkillSuccess) {
            return BgGradient(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.heightBox,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Stack(children: [
                                      Container(
                                        height: context.width * 0.2,
                                        width: context.width * 0.2,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            style: BorderStyle.solid,
                                          ),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: _imageFile == null
                                                ? NetworkImage(
                                                    user!.image.toString())
                                                : FileImage(_imageFile!)
                                                    as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.camera_alt,
                                            ),
                                            iconSize: context.width * 0.05,
                                          ))
                                    ]),
                                    10.widthBox,
                                    Expanded(
                                      child: LabeledFormInput(
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter your name";
                                            }
                                            return null;
                                          },
                                          controller: _nameController,
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.person)),
                                        ),
                                        label: 'Name',
                                      ),
                                    ),
                                  ],
                                ),
                                10.heightBox,
                                LabeledFormInput(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value != null ||
                                          (value?.isNotEmpty ?? false)) {
                                        try {
                                          if (value!.length != 10) {
                                            return "Mobile number should be of 10 digits";
                                          }
                                          int.parse(value);
                                        } catch (e) {
                                          return "Please enter a valid number";
                                        }
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.mail),
                                    ),
                                    controller: _mobileController,
                                  ),
                                  label: 'Mobile',
                                ),
                                10.heightBox,
                                LabeledFormInput(
                                  child: TextFormField(
                                    controller: _aboutController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.menu_book),
                                    ),
                                  ),
                                  label: 'About',
                                ),
                                10.heightBox,
                                LabeledFormInput(
                                  child: TextFormField(
                                    controller: _linkedinController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.link),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return null;
                                      }

                                      RegExp regex = RegExp(
                                        r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)',
                                      );

                                      if (!regex.hasMatch(value)) {
                                        return 'Invalid LinkedIn link';
                                      }

                                      return null;
                                    },
                                  ),
                                  label: 'Linkedin',
                                ),

                                10.heightBox,
                                LabeledFormInput(
                                  child: TextFormField(
                                    controller: _githubController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.link),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return null;
                                      }

                                      RegExp regex = RegExp(
                                        r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)',
                                      );

                                      if (!regex.hasMatch(value)) {
                                        return 'Invalid GitHub link';
                                      }

                                      return null;
                                    },
                                  ),
                                  label: 'Github',
                                ),

                                10.heightBox,
                                Text(
                                  'Skills',
                                  style: context.bodyMedium!.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer),
                                ),
                                Wrap(
                                  children: [
                                    for (final skill in _selectedSkills)
                                      Chip(
                                        label: Text(skill.name.toString()),
                                        deleteIcon: Icon(
                                          Icons.close,
                                          size: 15,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                        onDeleted: () {
                                          setState(() {
                                            _selectedSkills.remove(skill);
                                          });
                                        },
                                      )
                                  ],
                                ),
                                DropdownButtonFormField<Skill>(
                                    hint: const Text("Search skills"),
                                    items: [
                                      for (final skill in state.skills)
                                        DropdownMenuItem(
                                          value: skill,
                                          child: Text(skill.name.toString()),
                                        ),
                                    ],
                                    onChanged: (value) {
                                      bool isAlreadySelected =
                                          _selectedSkills.any((element) =>
                                              element.id == value?.id);
                                      if (isAlreadySelected) {
                                        return;
                                      }
                                      setState(() {
                                        _selectedSkills.add(value!);
                                      });
                                    }),
                                //  DropdownSearch<Skill>(
                                //   items: state.skills,
                                //   showClearButton: true,
                                //   onChanged: (Skill? value) {
                                //     if (value != null) {
                                //       setState(() {
                                //         _selectedSkills.add(value);
                                //       });
                                //     }
                                //   },
                                //   selectedItem: null,
                                //   searchBoxDecoration: InputDecoration(
                                //     labelText: "Skills", // Use labelText for label
                                //     hintText: "Select a skill", // Use hintText for hint
                                //     border: OutlineInputBorder(),
                                //     contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                //   ),
                                // ),

                                10.heightBox,
                                LabeledFormInput(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return null;
                                      }
                                      return null;
                                    },
                                    controller: _experienceController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.work),
                                    ),
                                  ),
                                  label: 'Experience',
                                ),

                                10.heightBox,
                                Text(
                                  'Add Resume',
                                  style: context.bodyMedium!.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer),
                                ),
                                5.heightBox,
                                InkWell(
                                  onTap: pickFile,
                                  child: Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color:
                                                  context.colorScheme.primary),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.upload_file),
                                            5.heightBox,
                                            Text(
                                              'Choose file to upload',
                                              style: context.bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            5.heightBox,
                                            Text(
                                              'Select pdf only',
                                              style: context.bodyMedium!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurfaceVariant),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                10.heightBox,
                                if (_resumeFile != null)
                                  InkWell(
                                    onTap: () {
                                      context.go(CommonRoutes.pdfViewer,
                                          extra: _resumeFile!.path);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: context.colorScheme
                                                    .surfaceVariant),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            )),
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.insert_drive_file),
                                              2.widthBox,
                                              Expanded(
                                                child: Text(
                                                  _resumeFile!.path
                                                      .split('/')
                                                      .last,
                                                  style: context.bodyMedium,
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _resumeFile = null;
                                                    });
                                                  },
                                                  icon: Icon(Icons.close))
                                            ],
                                          ),
                                        )),
                                  ),
                                20.heightBox,
                                BlocConsumer<ManageProfileCubit,
                                    ManageProfileState>(
                                  listener: (context, state) {
                                    if (state is ManageProfileSuccess) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        'Profile Updated successfully',
                                      )));

                                      context
                                          .read<CoreCubit>()
                                          .setUser(state.user);

                                      context.pop();
                                    }
                                    if (state is ManageProfileError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        'Profile is not Updated ',
                                      )));
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is ManageProfileLoading) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return FilledButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context
                                                .read<ManageProfileCubit>()
                                                .editProfile(
                                                    id: user!.id.toString(),
                                                    name: _nameController.text,
                                                    about:
                                                        _aboutController.text,
                                                    experience_years: int.parse(
                                                        _experienceController
                                                            .text),
                                                    linkedin:
                                                        _linkedinController
                                                            .text,
                                                    github:
                                                        _githubController.text,
                                                    mobile:
                                                        _mobileController.text,
                                                    skillsIDList:
                                                        _selectedSkills
                                                            .map((e) => e.id!)
                                                            .toList(),
                                                    imageFile: _imageFile,
                                                    resumeFile: _resumeFile);
                                          }
                                        },
                                        child: Text(
                                          'Save',
                                          style: context.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        style: FilledButton.styleFrom(
                                            minimumSize:
                                                Size(double.infinity, 40)));
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';


import '../cubit/skill/skill_cubit.dart';

class ManageProfileScreen extends StatefulWidget {
  const ManageProfileScreen({super.key});

  @override
  State<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {
  late final User? user;
  @override
  void initState() {
    context.read<SkillCubit>().getSkills();
    user = context.read<CoreCubit>().state.user;
    super.initState();
  }

  int? _selectedSkill;
  FilePickerResult? result;
  PlatformFile? pickedFile;
  File? fileToDisplay;
  List<Skill> _selectedSkills = [];
  void pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );
      if (result != null) {
        pickedFile = result.files.first;
        setState(() {
          fileToDisplay = File(pickedFile!.path!);
        });
      }
    } catch (e) {
      print('errror is $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                        image: NetworkImage(user?.image ?? ""),
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
                                      initialValue: user?.name ?? '',
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
                                initialValue: user?.mobile ?? '',
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.mail),
                                ),
                              ),
                              label: 'Mobile',
                            ),
                            10.heightBox,
                            LabeledFormInput(
                              child: TextFormField(
                                initialValue: user?.about ?? '',
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.menu_book),
                                ),
                              ),
                              label: 'About',
                            ),
                            10.heightBox,
                           LabeledFormInput(
  child: TextFormField(
    initialValue: user?.linkedin ?? '',
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.link),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return null; 
      }


      RegExp regex = RegExp(
        r'^https:\/\/www\.linkedin\.com\/in\/[a-zA-Z0-9-]+\/?$',
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
    initialValue: user?.github ?? '',
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.link),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return null; 
      }

      
      RegExp regex = RegExp(
        r'^https:\/\/github\.com\/[a-zA-Z0-9-]+\/?$',
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
                                for(final skill in _selectedSkills)
                                  Chip(
                                    label: Text(skill.name.toString()),
                                   deleteIcon: Icon(Icons.close,
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

                                items: [
                                  
                                  for (final skill in state.skills)
                                    DropdownMenuItem(
                                      value: skill,
                                      child: Text(skill.name.toString()),
                                    ),
                                  
                                ],


                                onChanged: (value) {
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
                                initialValue: user?.experienceYears.toString()?? '',
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
                                          color: context.colorScheme.primary),
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
                                          style: context.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        5.heightBox,
                                        Text(
                                          'Select pdf only',
                                          style: context.bodyMedium!.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurfaceVariant),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            10.heightBox,
                            if(fileToDisplay != null)
                           Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: context.colorScheme.surfaceVariant),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                )),
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                Icon(Icons.insert_drive_file),
                                2.widthBox,
                                 Text(fileToDisplay!.path.split('/').last,
                                 style: context.bodyMedium,
                                 ),
                                 Spacer(),
                                 if(fileToDisplay != null)
                                 IconButton(
                                      onPressed: () {
                                        setState(() {
                                          fileToDisplay = null;
                                        });
                                      }, icon: Icon(Icons.close))
                               ],
                                                         ),
                            )),
                            20.heightBox,
                            FilledButton(
                                onPressed: () {},
                                child: Text(
                                  'Save',
                                  style: context.bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                style: FilledButton.styleFrom(
                                    minimumSize: Size(double.infinity, 40)))
                          ],
                        ),
                      ),
                    ],
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

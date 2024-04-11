import 'dart:developer';

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/fund/cubit/add_edit_fundProject/cubit/add_edit_fund_project_cubit.dart';
import 'package:stuverse/features/fund/cubit/home/fund_home_cubit.dart';
import 'package:stuverse/features/fund/models/projects.dart';
import 'package:stuverse/features/fund/routes/fund_routes.dart';

class AddFundProjectScreen extends StatefulWidget {
  const AddFundProjectScreen({super.key, this.post});

  final Projects? post;

  @override
  State<AddFundProjectScreen> createState() => _AddFundProjectScreenState();
}

class _AddFundProjectScreenState extends State<AddFundProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetamountController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _upiIdController = TextEditingController();

  String? _selectedCategory;
  XFile? _selectedImage;

  void _chooseImage() async {
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
    context.read<CoreCubit>().state.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.post != null ? "Edit Project " : " Create Project ",
          style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BgGradient(
        child: Form(
            key: _formKey,
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    30.heightBox,
                    Text(
                      widget.post != null
                          ? "Make it amazing! \nEdit & relaunch your project"
                          : " Small steps, big change.\nCreate your project! ",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    30.heightBox,
                    GestureDetector(
                      onTap: () {
                        _chooseImage();
                      },
                      child: Center(
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: _selectedImage != null
                              ? FileImage(File(_selectedImage!.path))
                              : widget.post?.images != null
                                  ? CachedNetworkImageProvider(
                                      widget.post!.images) as ImageProvider
                                  : null,
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton.icon(
                          onPressed: _chooseImage,
                          icon: const Icon(Icons.image),
                          label: Text("Pick an Image")),
                    ),
                    Text(
                      "Title",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    10.heightBox,
                    TextFormField(
                        maxLength: 50,
                        controller: _titleController,
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Project title',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w100,
                              fontSize: 15,
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                    15.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Project Description",
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
                    10.heightBox,
                    TextFormField(
                        maxLength: 5000,
                        maxLines: 7,
                        enabled: true,
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                          alignLabelWithHint: true,
                          hintText: "Talk about your project",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                    15.heightBox,
                    Text(
                      "Target Amount",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    15.heightBox,
                    TextFormField(
                        controller: _targetamountController,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Target Amount',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w100,
                              fontSize: 15,
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Amount';
                          }
                          final regExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
                          if (!regExp.hasMatch(value)) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        }),
                    30.heightBox,
                    Text("Account Number",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    15.heightBox,
                    TextFormField(
                        controller: _accountNumberController,
                        maxLength: 15,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Account Number',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w100,
                              fontSize: 15,
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your account number';
                          }
                          final regExp = RegExp(r'^[0-9]+$');
                          if (!regExp.hasMatch(value)) {
                            return 'Please enter a valid account number';
                          }
                          return null;
                        }),
                    30.heightBox,
                    Text("UPI ID",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    15.heightBox,
                    TextFormField(
                        maxLength: 50,
                        controller: _upiIdController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'UPI ID',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w100,
                            fontSize: 15,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your UPI ID';
                          }
                          final regexp =
                              RegExp(r'^[a-zA-Z0-9.\-]{2,256}@[a-zA-Z]{2,64}$');
                          if (!regexp.hasMatch(value)) {
                            return 'Please enter a valid UPI ID';
                          }

                          return null;
                        }),
                    30.heightBox,
                    Text('Category',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    15.heightBox,
                    DropdownButtonFormField(
                        isExpanded: true,
                        value: _selectedCategory,
                        validator: (value) {
                          if (value == null) {
                            return "Please select a Category";
                          }
                          return null;
                        },
                        items: [
                          DropdownMenuItem(
                              child: Text("Charity"),
                              value: FundCategoryChoice.charity),
                          DropdownMenuItem(
                              child: Text("Disaster"),
                              value: FundCategoryChoice.disaster),
                          DropdownMenuItem(
                              child: Text("Education"),
                              value: FundCategoryChoice.education),
                          DropdownMenuItem(
                              child: Text("Medical"),
                              value: FundCategoryChoice.medical),
                          DropdownMenuItem(
                              child: Text("Others"),
                              value: FundCategoryChoice.others),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        }),
                    30.heightBox,
                    Text("Start Date",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    15.heightBox,
                    TextFormField(
                      controller: _startDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Start Date',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w100,
                            fontSize: 15,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () async {
                                final DateTime? _pickedDate =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2024),
                                  lastDate:
                                      DateTime(2030).add(Duration(days: 365)),
                                );
                                setState(() {
                                  _startDateController.text =
                                      DateFormat('yyyy-MM-dd')
                                          .format(_pickedDate!)
                                          .toString();
                                });
                              },
                              icon: Icon(Icons.calendar_month_outlined))),
                    ),
                    30.heightBox,
                    Text("End Date",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    15.heightBox,
                    TextFormField(
                      controller: _endDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'End Date',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w100,
                            fontSize: 15,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () async {
                                final DateTime? _pickedDate =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2024),
                                  lastDate:
                                      DateTime(2030).add(Duration(days: 365)),
                                );
                                setState(() {
                                  _endDateController.text =
                                      DateFormat('yyyy-MM-dd')
                                          .format(_pickedDate!)
                                          .toString();
                                });
                              },
                              icon: Icon(Icons.calendar_month_outlined))),
                    ),
                    30.heightBox,
                    BlocConsumer<AddEditFundProjectCubit,
                        AddEditFundProjectState>(
                      listener: (context, state) {
                        if (state is AddEditFundProjectError) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.errorMessage),
                          ));
                        }
                        if (state is AddEditFundProjectSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.message),
                          ));
                          context.pushReplacement(FundRoutes.fundHome);
                          context.read<FundHomeCubit>().getProjects();
                        }
                      },
                      builder: (context, state) {
                        if (state is AddEditFundProjectLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_selectedCategory == null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    'Please select a category',
                                  )));
                                }
                              }

                              widget.post == null
                                  ? context
                                      .read<AddEditFundProjectCubit>()
                                      .addFundProject(
                                        user: context
                                            .read<CoreCubit>()
                                            .state
                                            .user!,
                                        title: _titleController.text,
                                        description:
                                            _descriptionController.text,
                                        category: _selectedCategory!,
                                        startDate: DateTime.parse(
                                            _startDateController.text),
                                        endDate: DateTime.parse(
                                            _endDateController.text),
                                        targetAmount: double.parse(
                                            _targetamountController.text),
                                        accountNumber:
                                            _accountNumberController.text,
                                        upiId: _upiIdController.text,
                                        image: _selectedImage,
                                      )
                                  : context
                                      .read<AddEditFundProjectCubit>()
                                      .editFundProject(
                                        user: context
                                            .read<CoreCubit>()
                                            .state
                                            .user!,
                                        id: widget.post!.id,
                                        title: _titleController.text,
                                        description:
                                            _descriptionController.text,
                                        targetAmount: double.parse(
                                            _targetamountController.text),
                                        startDate: DateTime.parse(
                                            _startDateController.text),
                                        endDate: DateTime.parse(
                                            _endDateController.text),
                                        accountNumber:
                                            _accountNumberController.text,
                                        upiId: _upiIdController.text,
                                        category: _selectedCategory!,
                                        image: _selectedImage,
                                      );
                            },
                            child: Text(widget.post != null ? 'Update' : 'Post',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 40),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ));
                      },
                    )
                  ],
                ),
              ),
            ))),
      ),
    );
  }
}

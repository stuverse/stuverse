import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/fund/models/projects.dart';

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
                          ? "Make it amazing! \n Edit & relaunch your project"
                          : " Small steps, big change.\n Create your project! ",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    30.heightBox,
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
                        enabled: false,
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
                            return 'Please enter some text';
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
                  ],
                ),
              ),
            ))),
      ),
    );
  }
}

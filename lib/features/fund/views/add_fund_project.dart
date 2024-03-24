import 'package:flutter/material.dart';

class AddFundProjectScreen extends StatefulWidget {
  const AddFundProjectScreen({super.key});

  @override
  State<AddFundProjectScreen> createState() => _AddFundProjectScreenState();
}

class _AddFundProjectScreenState extends State<AddFundProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetamountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
          key: _formKey,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Text("Title"),
                ],
              ),
            ),
          ))),
    );
  }
}

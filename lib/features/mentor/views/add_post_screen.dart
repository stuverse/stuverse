
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/mentor/mentor.dart';

import '../cubit/add_post/add_post_cubit.dart';
import '../cubit/add_post/add_post_state.dart';
import '../cubit/home/mentor_home_cubit.dart';


class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});
  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _postController = TextEditingController();
  final _feeController = TextEditingController();
  final _descriptionController=TextEditingController();
  final _priceController=TextEditingController();


  bool isFree=true;
  String _selectedFee = 'Select';
  List<String> _fee = ['Select', 'Free', 'Paid'];
  
  @override
  Widget build(BuildContext context) {
    final user=context.read<CoreCubit>().state.user;
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
                    'Craft Your Mentorship Offer',
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
                  Text(
                    'Description',
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
                         TextFormField(
                          controller: _feeController,
                          validator: (value) {
                                  if(_selectedFee=='Select'){
                        return 'Please select an option';
                      }
                      return null;
                
                          },
                           decoration: InputDecoration(
                            prefixIcon:  Padding(
                              padding: const EdgeInsets.all(12),
                              child: DropdownButton<String>(
                              value: _selectedFee,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _feeController.clear();
                                  _selectedFee = newValue!;
                                  if (_selectedFee == 'Free') {
                                    isFree=true;
                                  }
                                    if (_selectedFee == 'Paid') {
                                    isFree=false;
                                  }
                                });
                              },
                              items: _fee.map<DropdownMenuItem<String>>(
                                  (String _feevalue) {
                                return DropdownMenuItem<String>(
                                  value: _feevalue,
                                  child: Text(_feevalue),
                                );
                              }).toList(),
                                                         ),
                            ),
                           ),
                          
                         ),
                         SizedBox(height: 20,),
              
                  if(_selectedFee=='Paid')
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
                  BlocConsumer<AddPostCubit, AddPostState>(
                    listener: (context, state) {
                      if(state is AddPostFailure){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Cannot post'),
                        ));
                      }
                      if(state is AddPostLoaded){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Posted successfully'),
                        ));
                            context.pushReplacement(MentorRoutes.mentorHome);
                            context.read<MentorHomeCubit>().getMentorHomeData();
                    
                      }
                    },
                    builder: (context, state) =>state is AddPostLoading
                    ? CircularProgressIndicator()
                    :
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                          final postName = _postController.text;
                          final fee=
                          _selectedFee=='Free'
                          ?'0.00'
                         : _priceController.text;
                            final description = _descriptionController.text;

                            context.read<AddPostCubit>().addPost(
                                postName: postName,
                                fee:double.parse(fee),
                                isFree: isFree,
                                description: description,
                                mentorId:user!.id!
                                );
                         context.pushReplacement(
                          MentorRoutes.mentorHome,
                         );
      
                          }
                        },
                        child: Text('Post',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 40),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                                
                                )),
                    
                      ),
                    
                  ),
                ],
              ),
            ),
          
        ),
          ),),
          ),
    );
  }
}

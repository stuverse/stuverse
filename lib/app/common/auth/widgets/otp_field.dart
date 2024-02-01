import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stuverse/app/app.dart';

class OtpField extends StatefulWidget {

  const OtpField({super.key, required this.otpController,  this.isLastField = false});



  final TextEditingController  otpController;
  final bool isLastField;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  


  @override
  Widget build(BuildContext context) {
    return SizedBox(
          width: context.minSize * 0.15,
          child: TextFormField(
            textAlign: TextAlign.center,
            validator: (value){
              if(value!.isEmpty){
                return 'Empty';
              }
              return null;
            },
            onSaved: (pin1) {},
            onChanged: (value){
              if (value.length == 1 && !widget.isLastField) {
      FocusScope.of(context).nextFocus();
    }
            },
            controller: widget.otpController,
            
            decoration: InputDecoration(

             
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            style:
                Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 30,

                ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        );
  }
}
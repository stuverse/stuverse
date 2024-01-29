import 'package:flutter/material.dart';
import 'package:stuverse/features/common/core/widgets/bg_gradient.dart';

class BoardingPage extends StatelessWidget {
  const BoardingPage({super.key,required this.title,required this.description,required this.img});
  final String title;
  final String description;
  final String img;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BgGradient(
      child: Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.05, 
            ),
            child: Column(
              children: [
               Image.asset(img,
               height: 350,
               width: 350,
               ),
               SizedBox(height: 10,),
                Text(title,
                textAlign: TextAlign.center,
                style:
                  Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                              ),
                ),
                SizedBox(height: 10),
                Text(description,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
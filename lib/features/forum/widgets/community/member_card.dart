import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

class MembersCard extends StatelessWidget {
  const MembersCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });
  final String title;
  final String subtitle;
  final String image;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: context.colorScheme.surface,
      leading:   CircleAvatar(
      radius: context.height * 0.02,
      backgroundImage: NetworkImage(
        image,
      ),
    ),
    title: Text(title),
    subtitle: Text(subtitle),
    trailing: PopupMenuButton(itemBuilder: (context)
    {
      return [
         PopupMenuItem(
          onTap: (){},
          child: Row(
            children: [
              Icon(Icons.account_circle_sharp,
              ),
              SizedBox(width: 10),
              Text('View Profile'),
            ],
          ),
        ),
         PopupMenuItem(
          onTap: () {
           showDialog(context: context, builder: (context){
             return AlertDialog(
               content: Text('Are you sure you want to remove this member?',
               style: context.bodyMedium,
               ),
               actions: [
                TextButton(onPressed: (){
                 context.pop();
                }, child: Text('No',style: context.bodyMedium,)),
                TextButton(onPressed: (){
                  context.pop();
                }, child: Text('Yes',style: context.bodyMedium,)),
               ],
             );
           });
          },
          child: Row(
            children: [
              Icon(Icons.close,
              color: Colors.red),
              SizedBox(width: 10),
              Text('Remove',
              style: TextStyle(
                color: Colors.red)
              ),
            ],
          ),
        ),
      ];
    }
    
    ),
    );
  }
}
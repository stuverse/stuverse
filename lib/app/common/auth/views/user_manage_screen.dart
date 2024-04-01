import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

class UserManageScreen extends StatelessWidget {
  const UserManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Users'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: Text('User Requests'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                context.push(CommonRoutes.userRequest);
              },
              tileColor:
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.7),
            ),
            5.heightBox,
            ListTile(
              title: Text('Students List'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                context.push(CommonRoutes.usersList);
              },
              tileColor:
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

class BlockUserDialogue extends StatefulWidget {
  const BlockUserDialogue({
    super.key,
    required this.userId,
    required this.onSuccess,
    required this.onError,
  });

  final int userId;
  final VoidCallback onSuccess;
  final VoidCallback onError;

  @override
  State<BlockUserDialogue> createState() => _ReportCommentDialogState();
}

class _ReportCommentDialogState extends State<BlockUserDialogue> {
  final _reasonController = TextEditingController();

  String? _reportType = ReportType.spam;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        "Block User",
        style: context.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Why are you blocking this user?",
              style: context.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
          5.heightBox,
          ...ReportType.values
              .map((e) => RadioMenuButton(
                    value: e,
                    groupValue: _reportType,
                    onChanged: (value) {
                      setState(() {
                        _reportType = value!;
                      });
                    },
                    child: Text(CommonUtils.toTitleCase(e)),
                  ))
              .toList(),
          5.heightBox,
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: context.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        BlocConsumer<ReportCubit, ReportState>(
          listener: (context, state) {
            if (state is ReportSuccess) {
              widget.onSuccess();
              Navigator.pop(context);
              context.showAlertDialog(
                  title: "User Blocked 🚫 ",
                  message:
                      "User has been blocked. Now you won't see any comments or mentor posts from this user.");
            }
            if (state is ReportError) {
              widget.onError();
              Navigator.pop(context);
              context.showErrorMessage(message: state.message);
            }
          },
          builder: (context, state) {
            if (state is ReportLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return TextButton(
              onPressed: () {
                context.read<ReportCubit>().report(
                    itemId: widget.userId,
                    reason: _reasonController.text,
                    item: ReportItem.user,
                    type: _reportType ?? ReportType.other);
              },
              child: Text(
                "Block User",
                style: context.bodyMedium!.copyWith(
                    color: context.colorScheme.error,
                    fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ],
    );
  }
}

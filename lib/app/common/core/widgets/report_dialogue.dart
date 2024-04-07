import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

import '../cubit/report/report_cubit.dart';

class ReportDialogue extends StatefulWidget {
  const ReportDialogue({
    super.key,
    required this.itemId,
    required this.item,
    required this.onSuccess,
    required this.onError,
  });

  final int itemId;
  final String item;
  final VoidCallback onSuccess;
  final VoidCallback onError;

  @override
  State<ReportDialogue> createState() => _ReportCommentDialogState();
}

class _ReportCommentDialogState extends State<ReportDialogue> {
  final _reasonController = TextEditingController();

  String? _reportType = ReportType.spam;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        "Report",
        style: context.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Why are you reporting this ${widget.item}?",
              style: context.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
          5.heightBox,
          // DropdownButton<String>(
          //   value: _reportType,
          //   onChanged: (v) {
          //     setState(() {
          //       _reportType = v;
          //     });
          //   },
          //   items: ReportType.values
          //       .map(
          //         (e) => DropdownMenuItem<String>(
          //           value: e,
          //           child: Text(CommonUtils.toTitleCase(e)),
          //         ),
          //       )
          //       .toList(),
          // ),
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
          Text(
            "What is the reason for reporting this ${widget.item}?",
            style: context.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          10.heightBox,

          LabeledFormInput(
              child: TextFormField(
                controller: _reasonController,
                maxLines: 2,
              ),
              label: 'Reason')
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
              context.showMessage(message: "Reported successfully");
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
                    itemId: widget.itemId,
                    reason: _reasonController.text,
                    item: widget.item,
                    type: _reportType ?? ReportType.other);
              },
              child: Text(
                "Report",
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

// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:stuverse/app/app.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';

// class FundHomeScreen extends StatefulWidget {
//   const FundHomeScreen({super.key});

//   @override
//   State<FundHomeScreen> createState() => _FundHomeScreenState();
// }

// class _FundHomeScreenState extends State<FundHomeScreen> {
//   final channel =
//       WebSocketChannel.connect(Uri.parse('ws://localhost:8000/ws/'));
//   bool isLoading = true;
//   @override
//   void initState() {
//     _loadData();
//     super.initState();
//   }

//   List<String> messages = [];
//   Future<void> _loadData() async {
//     await channel.ready;
//     setState(() {
//       isLoading = false;
//     });
//     final jsonData = {
//       "action": "subscribe_to_comment_activity",
//       "request_id": 1234,
//     };
//     channel.sink.add(jsonEncode(jsonData));
//     channel.stream.listen((message) {
//       final data = jsonDecode(message);
//       messages = [];
//       for (final data in data["data"]) {
//         messages.add(data["message"]);
//       }
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = context.read<CoreCubit>().state.user;
//     return SafeArea(
//         child: Column(
//       children: [
//         if (isLoading)
//           const LinearProgressIndicator()
//         else
//           for (final message in messages)
//             ListTile(
//               title: Text(message),
//             ),
//       ],
//     ));
//   }
// }

// class TestMessage {
//   final String message;
//   final int id;

//   TestMessage({
//     required this.message,
//     required this.id,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'message': message,
//       'request_id': id,
//     };
//   }

//   factory TestMessage.fromMap(Map<String, dynamic> map) {
//     return TestMessage(
//       message: map['message'],
//       id: map['id'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory TestMessage.fromJson(String source) =>
//       TestMessage.fromMap(json.decode(source));
// }

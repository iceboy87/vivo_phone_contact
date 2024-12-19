import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailComposePage extends StatefulWidget {
  final String toAddress;
  EmailComposePage({required this.toAddress, Key? key}) : super(key: key);

  @override
  State<EmailComposePage> createState() => _EmailComposePageState();
}

class _EmailComposePageState extends State<EmailComposePage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController toAddress = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  sendCustomEmail(
      String fromAddress,
      String toAddress,
      String emailBody,
      String subject,
      ) async {
    print("username: $fromAddress");
    final smtpServer = gmail(
        fromAddress,// replace your Login EmailId, As String
        "VIGNESHwaran123@",// replace your Two factor passcode then your auth verification is successful
    );
    final emailMessage =
    Message()
      ..from = Address(fromAddress)
      ..recipients.add(toAddress)
      ..subject = subject
      ..text = emailBody;

    try {
      final sendReport = await send(emailMessage , smtpServer);
      print('Message sent: $sendReport');
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String fromAddress = FirebaseAuth.instance.currentUser!.email!;
    return Scaffold(
      appBar: AppBar(title: const Text('Compose Email')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Text("From:"), Text(fromAddress)]),
                SizedBox(height: 0.5.h),
                Text("To:"),
                TextField(
                  controller: toAddress,
                  decoration: const InputDecoration(labelText: 'Enter Email'),
                ),
                SizedBox(height: 1.h),
                TextField(
                  controller: subjectController,
                  decoration: const InputDecoration(
                    labelText: 'Subject',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 1.h),
                TextField(
                  controller: messageController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 1.h),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _key.currentState!.save();
                      sendCustomEmail(
                        fromAddress,
                        toAddress.text,
                        messageController.text,
                        subjectController.text,
                      );
                      print("sendCustomEmail()");
                      // Navigator.pop(context); // Optional, if you want to close the page after sending
                    },
                    child: const Text('Send'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
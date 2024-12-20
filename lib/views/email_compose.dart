import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../controllers/email_controller.dart';

class EmailComposePage extends StatefulWidget {
  final String toAddress;

  EmailComposePage({required this.toAddress, Key? key}) : super(key: key);

  @override
  State<EmailComposePage> createState() => _EmailComposePageState();
}

class _EmailComposePageState extends State<EmailComposePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController toAddressController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  late final EmailController emailController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = EmailController(context: context);
    // toAddressController.text = widget.toAddress;
  }

  @override
  void dispose() {
    // toAddressController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compose Email')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("From: "),
                    Text(FirebaseAuth.instance.currentUser?.email ?? 'Unknown'),
                  ],
                ),
                SizedBox(height: 0.5.h),
                const Text("To:"),
                TextField(
                  controller: toAddressController,
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
                  child:
                      _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                emailController.sendCustomEmail(
                                  toAddress: toAddressController.text,
                                  subject: subjectController.text,
                                  emailBody: messageController.text,
                                  onLoading: (isLoading) {
                                    setState(() {
                                      _isLoading = isLoading;
                                    });
                                  },
                                );
                              }
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

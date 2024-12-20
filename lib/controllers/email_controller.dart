import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailController {
  final BuildContext context;

  EmailController({required this.context});

  Future<void> sendCustomEmail({
    required String toAddress,
    required String subject,
    required String emailBody,
    required void Function(bool) onLoading,
  }) async {
    final String? fromAddress = FirebaseAuth.instance.currentUser?.email;

    if (fromAddress == null) {
      _showSnackBar(
        message: 'User is not logged in!',
        isError: true,
      );
      return;
    }

    final smtpServer = gmail(
      fromAddress,
      "exoe cfmw iylu huip", //enter your 2-factor authentication password.
      // Go to From address email => security => app passwords => register "Email" => copy password.
    );

    final emailMessage = Message()
      ..from = Address(fromAddress)
      ..recipients.add(toAddress)
      ..subject = subject
      ..text = emailBody;

    onLoading(true); // Show loading indicator

    try {
      final sendReport = await send(emailMessage, smtpServer);
      print('Message sent: $sendReport');
      _showSnackBar(message: 'Email sent successfully!');
    } catch (e) {
      print('Error occurred: $e');
      _showSnackBar(
        message: 'Failed to send email: $e',
        isError: true,
      );
    } finally {
      onLoading(false); // Hide loading indicator
    }
  }

  void _showSnackBar({required String message, bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

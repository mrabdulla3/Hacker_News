import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ContactusController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  bool isSent = false;

  void sendEmail() async {
    isSent = true;
    update();
    final username = dotenv.env['MAIL_USERNAME']!;
    final password = dotenv.env['MAIL_PASSWORD']!;

    final smtpServer = SmtpServer(
      dotenv.env['MAIL_HOST']!,
      port: int.parse(dotenv.env['MAIL_PORT']!),
      username: username,
      password: password,
      ssl: false,
    );

    final message = Message()
      ..from = Address(username, 'Hacker News Contact_Us')
      ..recipients.add(username)
      ..subject = '📩 Message from ${nameController.text}'
      ..text = '''
Name: ${nameController.text}
Email: ${emailController.text}
Message:
${messageController.text}
    '''
      ..html = """
        <h2>📩 New Contact Form Submission</h2>
        <p><b>Name:</b> ${nameController.text}</p>
        <p><b>Email:</b> ${emailController.text}</p>
        <p><b>Message:</b><br>${messageController.text}</p>
    """;

    try {
      await send(message, smtpServer);
      Get.snackbar('Success', 'Message Sent Successfully!');
      nameController.clear();
      emailController.clear();
      messageController.clear();
    } on MailerException catch (e) {
      Get.snackbar('Failed', 'Message not sent');
    } finally {
      isSent = false;
      update();
    }
  }
}

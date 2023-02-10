import 'package:flutter/material.dart';
import 'package:project/component/app_text_form_field.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({Key? key}) : super(key: key);
  final currentPassCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        elevation: 1,
        title: Text(
          translation(context).change_password,
          style: typoInterNomal18,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            formText(translation(context).current_pass, currentPassCtrl),
          ],
        ),
      ),
    );
  }

  Column formText(String title, TextEditingController controller) {
    return Column(
      children: [
        Text(
          title,
          style: typoInterNomal16.copyWith(color: colorTextMedium),
        ),
        const SizedBox(
          height: 8,
        ),
        const AppTextFormField(
          borderRadius: 5,
        ),
      ],
    );
  }
}

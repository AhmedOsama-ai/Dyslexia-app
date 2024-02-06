import 'package:dyslexia/constants/styles.dart';
import 'package:dyslexia/presentation/handwritting_page.dart';
import 'package:dyslexia/presentation/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';

class HandWrittingResultPage extends StatelessWidget {
  final bool isNormal;
  final String text;
  const HandWrittingResultPage({required this.isNormal, super.key})
      : text = isNormal ? 'Normal' : 'Not Normal';

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HandwrittingPage()),
              (route) => false);
        },
        child: MyScaffold(
            title: 'Handwritting Result',
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'The Result is  ',
                  style: bodyTextStyle.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                Text(text, style: bodyTextStyle.copyWith(fontSize: 28)),
              ],
            )));
  }
}

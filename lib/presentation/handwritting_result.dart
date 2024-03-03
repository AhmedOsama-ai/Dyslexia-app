import 'package:dyslexia/constants/styles.dart';
import 'package:dyslexia/presentation/handwritting_page.dart';
import 'package:dyslexia/presentation/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';

class HandWrittingResultPage extends StatelessWidget {
  final bool isNormal;
  final String originalText;
  final String writtenText;
  final String result;
  const HandWrittingResultPage(
      {required this.originalText,
      required this.writtenText,
      required this.isNormal,
      super.key})
      : result = isNormal ? 'Normal' : 'Not Normal';

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (_) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => HandwrittingPage()),
              (_) => false);
        },
        child: MyScaffold(
            title: 'Handwritting Result',
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Original Text',
                  style: bodyTextStyle.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    originalText,
                    style: bodyTextStyle.copyWith(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'You Wrote',
                  style: bodyTextStyle.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    writtenText,
                    style: bodyTextStyle.copyWith(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'The Result is  ',
                  style: bodyTextStyle.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                Text(
                  result,
                  style: bodyTextStyle.copyWith(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ],
            )));
  }
}

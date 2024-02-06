import 'package:dyslexia/constants/styles.dart';
import 'package:dyslexia/data/models/handwritting_audio.dart';
import 'package:dyslexia/data/web_services/ml_services.dart';
import 'package:dyslexia/presentation/handwritting_upload.dart';
import 'package:dyslexia/presentation/widgets/loading_indicator.dart';
import 'package:dyslexia/presentation/widgets/my_button.dart';
import 'package:dyslexia/presentation/widgets/my_scaffold.dart';
import 'package:dyslexia/presentation/widgets/player.dart';
import 'package:flutter/material.dart';

class HandwrittingPage extends StatelessWidget {
  final HandwrittingAudio audio = HandwrittingAudio(audioUrl: '', text: '');

  HandwrittingPage({super.key});
  @override
  Widget build(BuildContext context) {
    print(audio);
    return MyScaffold(
        title: 'LEXI LEARN',
        body: FutureBuilder(
          future: MLServices().getHandwrittingAudio(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              audio.audioUrl = snapshot.data!.audioUrl;
              audio.text = snapshot.data!.text;
              print(audio);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    'Handwriting',
                    style: bodyTextStyle,
                  ),
                  const SizedBox(height: 60),
                  const Text(
                    'Please listten and write',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 60),
                  Player(url: audio.audioUrl),
                  const SizedBox(height: 100),
                  MyButton(
                      text: 'CONTINUE',
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>
                                HandwrittingUpload(correctText: audio.text)));
                      })
                ],
              );
            } else {
              return const LoadingIndicator();
            }
          },
        ));
  }
}

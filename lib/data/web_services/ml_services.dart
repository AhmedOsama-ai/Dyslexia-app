import 'package:dio/dio.dart';
import 'package:dyslexia/constants/strings.dart';
import 'package:dyslexia/data/models/handwritting_audio.dart';

class MLServices {
  final Dio dio;
  MLServices() : dio = Dio(BaseOptions(baseUrl: baseUrl));

  uploadHandWriting(String path) async {
    FormData data =
        FormData.fromMap({'file': await MultipartFile.fromFile(path)});
    Response response = await dio.post(
      handwritingPredictEndpoint,
      data: data,
    );
    return response;
  }

  Future<HandwrittingAudio> getHandwrittingAudio() async {
    Response r = await dio.get(handwritingAudioEndpoint);
    return HandwrittingAudio.fromJson(r.data);
  }

  uploadEyeTracking() {}
  uploadEEG() {}
  uploadMRI() {}
}

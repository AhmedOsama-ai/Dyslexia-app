import 'package:dio/dio.dart';

class MLServices {
  final Dio dio;
  MLServices() : dio = Dio(BaseOptions(baseUrl: ''));

  uploadHandWriting() {
    dio.post('/');
  }

  uploadEyeTracking() {}
  uploadEEG() {}
  uploadMRI() {}
}

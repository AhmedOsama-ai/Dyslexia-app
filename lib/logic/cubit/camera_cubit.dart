// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:meta/meta.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  late Future<void> _initializeControllerFuture;
  late CameraController _controller;
  CameraCubit() : super(CameraInitial());

  initCamera() async {
    final List<CameraDescription> cameras = await availableCameras();
    _controller = CameraController(
      cameras.first,
      ResolutionPreset.max,
    );

    _initializeControllerFuture = _controller.initialize();
    await _initializeControllerFuture;
    _controller.setFlashMode(FlashMode.off);
    emit(CameraLoaded(controller: _controller));
  }

  takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      emit(PictureTaken(path: image.path));
    } catch (e) {
      // print(e);
    }
  }

  dispose() {
    _controller.dispose();
  }
}

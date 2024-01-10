part of 'camera_cubit.dart';

@immutable
sealed class CameraState {}

final class CameraInitial extends CameraState {}

final class CameraLoaded extends CameraState {
  final CameraController controller;
  CameraLoaded({required this.controller});
}

final class PictureTaken extends CameraState {
  final String path;
  PictureTaken({required this.path});
}

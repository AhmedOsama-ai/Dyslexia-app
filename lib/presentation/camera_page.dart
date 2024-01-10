import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dyslexia/logic/cubit/camera_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late final CameraCubit cameraCubit;

  @override
  void initState() {
    super.initState();
    cameraCubit = context.read<CameraCubit>();
  }

  @override
  void dispose() {
    cameraCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cameraCubit.initCamera();
    return Scaffold(
      body: Center(
        child: BlocBuilder<CameraCubit, CameraState>(
          builder: (context, state) {
            if (state is CameraLoaded) {
              return CameraPreview(state.controller);
            } else if (state is PictureTaken) {
              return Image.file(File(state.path));
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _cameraButton(),
    );
  }

  Widget _cameraButton() {
    const BorderRadius r = BorderRadius.all(Radius.circular(50));
    const double s = 44;
    return FloatingActionButton(
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: r),
      backgroundColor: Colors.red,
      onPressed: () async {
        cameraCubit.takePicture();
      },
      child: Container(
        width: s,
        height: s,
        decoration: const BoxDecoration(
          borderRadius: r,
          color: Colors.white,
        ),
      ),
    );
  }
}

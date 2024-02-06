import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dyslexia/constants/colors.dart';
import 'package:dyslexia/constants/strings.dart';
import 'package:dyslexia/constants/styles.dart';
import 'package:dyslexia/data/models/handwritting_response.dart';
import 'package:dyslexia/data/web_services/ml_services.dart';
import 'package:dyslexia/presentation/handwritting_result.dart';
import 'package:dyslexia/presentation/widgets/loading_indicator.dart';
import 'package:dyslexia/presentation/widgets/my_button.dart';
import 'package:dyslexia/presentation/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HandwrittingUpload extends StatefulWidget {
  final String correctText;
  const HandwrittingUpload({required this.correctText, super.key});

  @override
  State<HandwrittingUpload> createState() => _HandwrittingUploadState();
}

class _HandwrittingUploadState extends State<HandwrittingUpload> {
  bool isLoading = false;
  File? selectedImg;
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        title: 'LEXI LEARN',
        body: isLoading
            ? const LoadingIndicator()
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 30),
                    const Text('Handwriting', style: bodyTextStyle),
                    _buildImage(),
                    MyButton(
                      text: selectIamge,
                      icon: const Icon(Icons.image),
                      onPressed: () {
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                    const SizedBox(height: 12),
                    MyButton(
                      text: pickUpImage,
                      icon: const Icon(Icons.camera),
                      onPressed: () {
                        _pickImage(ImageSource.camera);
                      },
                    ),
                    const SizedBox(height: 30),
                    MaterialButton(
                      color: primaryColor,
                      disabledColor: Colors.grey,
                      minWidth: 140,
                      height: 60,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: selectedImg != null
                          ? () {
                              _uploadImg();
                            }
                          : null,
                      child: const Text('Result',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ));
  }

  _uploadImg() async {
    setState(() => isLoading = true);
    try {
      Response response =
          await MLServices().uploadHandWriting(selectedImg!.path);
      if (response.statusCode == 200) {
        var r = HandwrittingResponse.fromJson(response.data);
        bool isNormal =
            r.parsedText.toUpperCase() == widget.correctText.toUpperCase();
        if (!context.mounted) return;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => HandWrittingResultPage(isNormal: isNormal)));
      } else {}
    } catch (e) {
      if (!context.mounted) return;
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error please try again..')));
    }
  }

  _pickImage(ImageSource src) async {
    final img = await ImagePicker().pickImage(source: src);
    if (img == null) return;
    setState(() {
      selectedImg = File(img.path);
    });
  }

  _buildImage() {
    Widget holder = Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(imgPlaceholder),
        const Text(
          chooseAPicture,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 300),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: selectedImg != null ? Image.file(selectedImg!) : holder,
          ),
        ));
  }
}

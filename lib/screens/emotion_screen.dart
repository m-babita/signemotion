import 'dart:io';

import 'package:flutter/material.dart';
import 'package:signemotion/widgets/customizedBtn.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class EmotionScreen extends StatefulWidget {
  const EmotionScreen({Key? key}) : super(key: key);

  @override
  State<EmotionScreen> createState() => _EmotionScreenState();
}

class _EmotionScreenState extends State<EmotionScreen> {
  bool _loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 4,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model_emotion.tflite',
      labels: 'assets/elabels.txt',
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Tflite.close();
    super.dispose();
  }

  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Let's Understand Emotions:",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.purple,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _loading
                  ? Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            child: Image(
                              image: AssetImage("assets/emotions.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          Container(
                            height: 250,
                            child: Image.file(_image),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _output != null
                              ? Text(
                                  '${_output[0]}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
              Container(
                child: Column(
                  children: [
                    CustomizedBtn(
                      btnColor: Colors.purple[200],
                      btnTxt: "Take a photo",
                      txtColor: Colors.white,
                      onPressed: pickImage,
                    ),
                    CustomizedBtn(
                      btnColor: Colors.purple[200],
                      btnTxt: "Image Gallery",
                      txtColor: Colors.white,
                      onPressed: pickGalleryImage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:signemotion/dl_model/sclassifier_quant.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class SingnScreen extends StatefulWidget {
  static String routeName = '/signs';
  const SingnScreen({Key? key}) : super(key: key);

  @override
  State<SingnScreen> createState() => _SingnScreenState();
}

class _SingnScreenState extends State<SingnScreen> {
  bool _loading = true;

  late ClassifierSQuant classifier;
  late File _image;

  final picker = ImagePicker();

  Image? _imageWidget;
  img.Image? fox;
  Category? category;
  late num score;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    classifier = ClassifierSQuant();
  }

  Future pickImage() async {
    var image = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 300,
      maxWidth: 300,
      imageQuality: 100,
    );

    setState(() {
      _image = File(image!.path);
      _imageWidget = Image.file(_image);
      _loading = false;
      _predict();
    });
  }

  pickGalleryImage() async {
    var image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 300,
      maxWidth: 300,
      imageQuality: 100,
    );

    setState(() {
      _image = File(image!.path);
      _imageWidget = Image.file(_image);
      _loading = false;
      _predict();
    });
  }

  void _predict() async {
    img.Image imageInput = img.decodeImage(_image.readAsBytesSync())!;
    var pred = classifier.predict(imageInput);

    setState(() {
      category = pred;
      score = category!.score * 10000;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[200],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "What gestures can you make?",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              _loading
                  ? Column(
                      children: [
                        Container(
                          height: 300,
                          child: const Image(
                            image: AssetImage("assets/signs.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                            height: 300,
                            width: 300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: _imageWidget,
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Pridictions',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          category != null
                              ? '${category!.label} ${score.toStringAsFixed(2)}%'
                              : '',
                          style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Colors.white,
                            fixedSize: const Size(60, 60),
                            shadowColor: Colors.pink[100]),
                        onPressed: pickImage,
                        child: Icon(Icons.photo_camera,
                            size: 30, color: Colors.purple[300]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.purple[400],
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Colors.white,
                            fixedSize: const Size(60, 60),
                            shadowColor: Colors.pink[100]),
                        onPressed: pickGalleryImage,
                        child: Icon(Icons.photo,
                            size: 30, color: Colors.purple[300]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.purple[400],
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

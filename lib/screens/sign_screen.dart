import 'dart:io';
import 'package:signemotion/dl_model/eclassifier.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SingnScreen extends StatefulWidget {
  const SingnScreen({Key? key}) : super(key: key);

  @override
  State<SingnScreen> createState() => _SingnScreenState();
}

class _SingnScreenState extends State<SingnScreen> {
  bool _loading = true;

  final Classifier classifier = Classifier();
  File? _image;

  final picker = ImagePicker();
  late String emotionType = 'Happy';
  late String probab = '70%';

  Future pickImage() async {
    var image = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 300,
      maxWidth: 300,
      imageQuality: 100,
    );

    if (image == null) return;
    final outputs = await classifier.classifyImage(image);

    setState(() {
      _image = File(image.path);
      _loading = false;
      emotionType = outputs[0];
      probab = outputs[1];
    });
  }

  pickGalleryImage() async {
    var image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 300,
      maxWidth: 300,
      imageQuality: 100,
    );

    if (image == null) return;
    final outputs = await classifier.classifyImage(image);

    setState(() {
      _image = File(image.path);
      _loading = false;

      emotionType = outputs[0];
      probab = outputs[1];
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
                "What signs can you make?",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              _image == null
                  ? Column(
                      children: [
                        Container(
                          height: 280,
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
                            height: 280,
                            width: 280,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
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
                          emotionType == '' ? '' : '$probab $emotionType',
                          style: const TextStyle(
                            color: Colors.purpleAccent,
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

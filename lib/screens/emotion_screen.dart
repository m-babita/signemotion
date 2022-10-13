import 'dart:io';
// import 'package:signemotion/dl_model/classifier.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EmotionScreen extends StatefulWidget {
  const EmotionScreen({Key? key}) : super(key: key);

  @override
  State<EmotionScreen> createState() => _EmotionScreenState();
}

class _EmotionScreenState extends State<EmotionScreen> {
  bool _loading = true;
  late File _image;
  // final Classifier classifier = Classifier();
  late String eType = 'Happy';
  late String Prob = '70%';
  final picker = ImagePicker();

  Future pickImage() async {
    final image = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 300,
      maxWidth: 300,
      imageQuality: 100,
    );
    // final outputs = await classifier.classifyImage(image!);
    if (image == null) return;
    final tempimage = File(image.path);

    setState(() {
      _image = tempimage;
      _loading = false;
      // eType = outputs[0];
      // Prob = outputs[1];
    });
  }

  pickGalleryImage() async {
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 300,
      maxWidth: 300,
      imageQuality: 100,
    );
    // final outputs = await classifier.classifyImage(image!);

    if (image == null) return;
    final tempimage = File(image.path);

    setState(() {
      _image = tempimage;
      _loading = false;

      // eType = outputs[0];
      // Prob = outputs[1];
    });
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
                "How are you feeling?",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.purple,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              _loading
                  ? Container(
                      child: Column(
                        children: [
                          Container(
                            height: 300,
                            child: Image(
                              image: AssetImage("assets/emotions.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          Container(
                              height: 300,
                              width: 300,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  _image,
                                  fit: BoxFit.contain,
                                ),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Pridictions',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            eType == '' ? '' : '$eType $Prob',
                            style: TextStyle(
                              color: Colors.purpleAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: 40,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor: Colors.white,
                              fixedSize: Size(60, 60),
                              shadowColor: Colors.pink[100]),
                          onPressed: pickImage,
                          child: Icon(Icons.photo_camera,
                              size: 30, color: Colors.purple[300]),
                        ),
                        SizedBox(
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
                    SizedBox(
                      width: 60,
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor: Colors.white,
                              fixedSize: Size(60, 60),
                              shadowColor: Colors.pink[100]),
                          onPressed: pickGalleryImage,
                          child: Icon(Icons.photo,
                              size: 30, color: Colors.purple[300]),
                        ),
                        SizedBox(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

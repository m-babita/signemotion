import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:io';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class Classifier {
  Classifier();

  classifyImage(var image) async {
    final inputImage = File(image.path);

    ImageProcessor imageProcessor = ImageProcessorBuilder()
        .add(ResizeOp(300, 300, ResizeMethod.BILINEAR))
        .add(NormalizeOp(0, 255))
        .build();

    TensorImage tensorImage = TensorImage.fromFile(inputImage);
    tensorImage = imageProcessor.process(tensorImage);

    TensorBuffer probabilityBuffer =
        TensorBuffer.createFixedSize(<int>[1, 4], TfLiteType.float32);

    try {
      Interpreter interpreter =
          await Interpreter.fromAsset('model_signs.tflite');
      interpreter.run(tensorImage.buffer, probabilityBuffer.buffer);
      print(probabilityBuffer);
    } catch (e) {
      print(e);
    }

    List<String> labels = await FileUtil.loadLabels('assets/slabels.txt');

    SequentialProcessor<TensorBuffer> probabilityProcessor =
        TensorProcessorBuilder().build();
    TensorLabel tensorLabel = TensorLabel.fromList(
        labels, probabilityProcessor.process(probabilityBuffer));

    Map labeledProb = tensorLabel.getMapWithFloatValue();
    double highestProb = 0;
    String eType = '';

    labeledProb.forEach((Type, probability) {
      if (probability * 100 > highestProb) {
        highestProb = probability * 100;
        eType = Type;
      }
    });
    print(labeledProb);
    var outputProb = highestProb.toStringAsFixed(1);
    return [eType, outputProb];
  }
}
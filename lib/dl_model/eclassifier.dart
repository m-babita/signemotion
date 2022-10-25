import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:image/image.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

abstract class Classifier {
  late Interpreter interpreter;
  late InterpreterOptions _interpreterOptions;

  late List<int> _inputShape;
  late List<int> _outputShape;

  late TensorImage _inputImage;
  late TensorBuffer _outputBuffer;

  late TfLiteType _inputType;
  late TfLiteType _outputType;

  final String _labelsFileName = 'assets/elabels.txt';

  final int _labelsLength = 4;

  late var _probabilityProcessor;

  late List<String> labels;

  String get modelName;

  NormalizeOp get preProcessNormalizeOp;
  NormalizeOp get postProcessNormalizeOp;

  Classifier({int? numThreads}) {
    _interpreterOptions = InterpreterOptions();

    if (numThreads != null) {
      _interpreterOptions.threads = numThreads;
    }

    loadModel();
    loadLabels();
  }
  Future<void> loadModel() async {
    try {
      interpreter =
          await Interpreter.fromAsset(modelName, options: _interpreterOptions);
      print('Interpreter Created Successfully');

      _inputShape = interpreter.getInputTensor(0).shape;
      _outputShape = interpreter.getOutputTensor(0).shape;
      _inputType = interpreter.getInputTensor(0).type;
      _outputType = interpreter.getOutputTensor(0).type;

      _outputBuffer = TensorBuffer.createFixedSize(_outputShape, _outputType);
      _probabilityProcessor =
          TensorProcessorBuilder().add(postProcessNormalizeOp).build();
    } catch (e) {
      print('Unable to create interpreter, Caught Exception: ${e.toString()}');
    }
  }

  Future<void> loadLabels() async {
    labels = await FileUtil.loadLabels(_labelsFileName);
    if (labels.length == _labelsLength) {
      print('Labels loaded successfully');
    } else {
      print('Unable to load labels');
    }
  }

  TensorImage _preProcess() {
    int cropSize = min(_inputImage.height, _inputImage.width);
    return ImageProcessorBuilder()
        .add(ResizeWithCropOrPadOp(cropSize, cropSize))
        .add(ResizeOp(
            _inputShape[1], _inputShape[2], ResizeMethod.NEAREST_NEIGHBOUR))
        .add(preProcessNormalizeOp)
        .build()
        .process(_inputImage);
  }

  Category predict(Image image) {
    final pres = DateTime.now().millisecondsSinceEpoch;
    _inputImage = TensorImage(_inputType);
    _inputImage.loadImage(image);
    _inputImage = _preProcess();
    final pre = DateTime.now().millisecondsSinceEpoch - pres;

    print('Time to load image: $pre ms');

    final runs = DateTime.now().millisecondsSinceEpoch;
    interpreter.run(_inputImage.buffer, _outputBuffer.getBuffer());
    final run = DateTime.now().millisecondsSinceEpoch - runs;

    print('Time to run inference: $run ms');

    Map<String, double> labeledProb = TensorLabel.fromList(
            labels, _probabilityProcessor.process(_outputBuffer))
        .getMapWithFloatValue();
    final pred = getTopProbability(labeledProb);

    return Category(pred.key, pred.value);
  }

  void close() {
    interpreter.close();
  }
}

MapEntry<String, double> getTopProbability(Map<String, double> labeledProb) {
  var pq = PriorityQueue<MapEntry<String, double>>(compare);
  pq.addAll(labeledProb.entries);

  return (pq.first);
}

int compare(MapEntry<String, double> e1, MapEntry<String, double> e2) {
  if (e1.value > e2.value) {
    return -1;
  } else if (e1.value == e2.value) {
    return 0;
  } else {
    return 1;
  }
}
//     Map labeledProb = tensorLabel.getMapWithFloatValue();
//     double highestProb = 0;
//     String eType = '';

//     labeledProb.forEach((Type, probability) {
//       if (probability * 100 > highestProb) {
//         highestProb = probability * 100;
//         eType = Type;
//       }
//     });
//     print(labeledProb);
//     var outputProb = highestProb.toStringAsFixed(1);
//     return [eType, outputProb];
//   }
// }
//   classifyImage(var image) async {
//     final inputImage = File(image.path);

//     ImageProcessor imageProcessor = ImageProcessorBuilder()
//         .add(ResizeOp(300, 300, ResizeMethod.BILINEAR))
//         .add(NormalizeOp(0, 255))
//         .build();

//     TensorImage tensorImage = TensorImage.fromFile(inputImage);
//     tensorImage = imageProcessor.process(tensorImage);

//     TensorBuffer probabilityBuffer =
//         TensorBuffer.createFixedSize(<int>[1, 4], TfLiteType.float32);

//     try {
//       Interpreter interpreter =
//           await Interpreter.fromAsset('model_emotion.tflite');
//       interpreter.run(tensorImage.buffer, probabilityBuffer.buffer);
//       print(probabilityBuffer);
//     } catch (e) {
//       print(e);
//     }

//     List<String> labels = await FileUtil.loadLabels('assets/elabels.txt');

//     SequentialProcessor<TensorBuffer> probabilityProcessor =
//         TensorProcessorBuilder().build();
//     TensorLabel tensorLabel = TensorLabel.fromList(
//         labels, probabilityProcessor.process(probabilityBuffer));

//     Map labeledProb = tensorLabel.getMapWithFloatValue();
//     double highestProb = 0;
//     String eType = '';

//     labeledProb.forEach((Type, probability) {
//       if (probability * 100 > highestProb) {
//         highestProb = probability * 100;
//         eType = Type;
//       }
//     });
//     print(labeledProb);
//     var outputProb = highestProb.toStringAsFixed(1);
//     return [eType, outputProb];
//   }
// }

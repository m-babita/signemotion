import 'package:signemotion/dl_model/sclassifier.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class ClassifierSQuant extends Classifier {
  ClassifierSQuant();

  @override
  String get modelName => 'model_signs.tflite';

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(0, 1);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 255);
}

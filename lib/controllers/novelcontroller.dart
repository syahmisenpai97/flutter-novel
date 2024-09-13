import 'package:get/get.dart';
import 'package:kacs/models/view_model_novel.dart';

class Novelcontroller extends GetxController {
  var novelList = List<ViewModelNovel>.empty().obs;

  void snackBarError(String msg) {
    Get.snackbar(
      "Error",
      msg,
      duration: const Duration(seconds: 2),
    );
  }
  
}

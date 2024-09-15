import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kacs/constants/enum.dart';
import 'package:kacs/views/pages/HomeScreen/model/view_model_novel_list.dart';
import 'package:kacs/services/api_services.dart';
import 'package:kacs/views/pages/NovelDetailScreen/model/view_model_novel_details.dart';

class NovelDetailsController extends GetxController {
  final _api = ApiService();
  ViewModelNovelDetails? _novelDetailsData;
  RxList<String> genres = <String>[].obs;

  final rxRequestStatus = Status.COMPLETED.obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  RxList<ViewModelNovelCollection> novelCollection = <ViewModelNovelCollection>[].obs;

  Future<ViewModelNovelDetails?> novelIDApi(int id) async {
    try {
      setRxRequestStatus(Status.LOADING);
      final response = await _api.fetchNovelByID(id);

      if (response != null) {
        updateNovelDetailsData(response.data);
        setRxRequestStatus(Status.COMPLETED);
        return _novelDetailsData;
      } else {
        error.value = "Error fetching data";
        setRxRequestStatus(Status.ERROR);
      }
    } catch (e) {
      error.value = e.toString();
      setRxRequestStatus(Status.ERROR);
    }
    return null;
  }

  void updateNovelDetailsData(ViewModelNovelDetails? data) {
    _novelDetailsData = data;
  }

  String convertToYear(DateTime date) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    return formattedDate;
  }


}

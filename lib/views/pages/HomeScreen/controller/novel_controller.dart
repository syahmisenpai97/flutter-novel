import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kacs/constants/enum.dart';
import 'package:kacs/controllers/auth/http/service_url.dart';
import 'package:kacs/models/view_model_novel.dart';
import 'package:kacs/views/pages/HomeScreen/model/view_model_novel_list.dart';
import 'package:kacs/services/api_services.dart';
import 'package:kacs/utils/utils.dart';

class NovelController extends GetxController {
  final _api = ApiService();
  List<ViewModelNovel>? _novelData;
  RxList<String> genres = <String>[].obs;

  final rxRequestStatus = Status.COMPLETED.obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  RxList<ViewModelNovelCollection> novelCollection = <ViewModelNovelCollection>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchApi();
  }

  Future<void> fetchApi() async {
    try {
      setRxRequestStatus(Status.LOADING);
      final response = await _api.fetchNovel();

      if (response != null) {
        updateNovelData(response.data);
        updateNovelCollection();
        setRxRequestStatus(Status.COMPLETED);
      } else {
        error.value = "Error fetching data";
        setRxRequestStatus(Status.ERROR);
      }
    } catch (e) {
      error.value = e.toString();
      setRxRequestStatus(Status.ERROR);
    }
  }

  void updateNovelData(List<ViewModelNovel> data) {
    _novelData = data;
    genres.value = extractGenres(_novelData!);
  }

  List<String> extractGenres(List<ViewModelNovel> novels) {
    List<String> uniqueGenres = novels.map((novel) => novel.genre).toSet().toList();
    uniqueGenres.insert(0, 'All Genres');
    return uniqueGenres;
  }

  void updateNovelCollection() {
    if (_novelData != null) {
      novelCollection.value = _novelData!
          .map((novel) => ViewModelNovelCollection(
                id: novel.id,
                imageUrl: ServiceUrl.baseUrl + novel.cover.url,
                author: novel.author,
                title: novel.title,
              ))
          .toList();
    }
  }
}

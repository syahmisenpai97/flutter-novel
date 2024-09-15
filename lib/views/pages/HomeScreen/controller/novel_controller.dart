import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kacs/constants/enum.dart';
import 'package:kacs/constants/http/service_url.dart';

import 'package:kacs/models/view_model_novel.dart';
import 'package:kacs/views/pages/HomeScreen/model/view_model_novel_list.dart';
import 'package:kacs/services/api_services.dart';

class NovelController extends GetxController {
  final _api = ApiService();
  List<ViewModelNovel>? _novelData;
  RxList<String> genres = <String>[].obs;

  final searchController = TextEditingController().obs;
  final rxRequestStatus = Status.COMPLETED.obs;
  final rxSearchLoading = Status.COMPLETED.obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  RxList<ViewModelNovelCollection> novelCollection = <ViewModelNovelCollection>[].obs;
  RxList<ViewModelNovelCollection> filteredData = <ViewModelNovelCollection>[].obs;
  RxList<ViewModelNovelCollection> searchResults = <ViewModelNovelCollection>[].obs;

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
              id: novel.id, imageUrl: ServiceUrl.baseUrl + novel.cover.url, author: novel.author, title: novel.title, genre: novel.genre))
          .toList();
    }

    // Initially, show all novels in filteredData
    filteredData.value = novelCollection.toList();
  }

  // New function to filter novels by genre
  void filterNovelsByGenre(String selectedGenre) {
    if (selectedGenre == 'All Genres') {
      // Reset to show all novels
      filteredData.value = novelCollection.toList();
    } else {
      // Filter based on the selected genre
      filteredData.value = novelCollection.where((novel) => novel.genre == selectedGenre).toList();
    }
  }

  void searchNovelsByTitle(String query) {
    if (query.isEmpty || query.length < 2) {
      // Clear the searchResults if the query is empty or less than 2 characters
      searchResults.clear();
    } else {
      // Perform search based on the title
      searchResults.value = novelCollection.where((novel) => novel.title.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }

  Map<String, IconData> getGreetingMessageAndIcon() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return {'Good Morning': Icons.light_mode};
    } else if (hour >= 12 && hour < 19) {
      return {'Good Afternoon': Icons.light_mode};
    } else {
      return {'Good Night': Icons.dark_mode};
    }
  }
}

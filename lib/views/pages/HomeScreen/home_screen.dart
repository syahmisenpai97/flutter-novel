import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kacs/constants/gender.dart';
import 'package:kacs/constants/image_asset.dart';
import 'package:kacs/models/view_model_user.dart';
import 'package:kacs/views/pages/HomeScreen/controller/novel_controller.dart';
import 'package:kacs/views/pages/HomeScreen/view/widget_novel_collection.dart';
import 'package:kacs/views/pages/HomeScreen/view/widget_search_novel.dart';
import 'package:kacs/views/pages/NovelDetailScreen/controller/novel_details_controller.dart';

import 'package:kacs/views/themes/theme_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final novelController = Get.put(NovelController());
  final novelDetailsController = Get.put(NovelDetailsController());
  final getBox = GetStorage();
  late final ViewModelUser userData;

  int _isSelected = 0;

  @override
  void initState() {
    super.initState();

    final userDataJson = getBox.read('userData');
    if (userDataJson != null) {
      userData = ViewModelUser.fromJson(userDataJson);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (userData.isBlank == false) {
          novelController.fetchApi();
        } else {
          Get.offAllNamed('/splash');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    userData.gender.toLowerCase() == Gender.male ? ImageAsset.avatarMale : ImageAsset.avatarFemale,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello ${userData.firstName.capitalize} ${userData.lastName.capitalize},',
                  style: semiBoldText16,
                ),
                Row(
                  children: [
                    Text(
                      novelController.getGreetingMessageAndIcon().keys.first,
                      style: regularText14.copyWith(color: greyColor),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      novelController.getGreetingMessageAndIcon().values.first,
                      size: 14,
                      color: greyColor,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                final getStorage = GetStorage();

                getStorage.erase();

                Get.offAllNamed('/splash');
              },
              child: const Icon(
                Icons.logout_outlined,
                size: 25,
              ),
            ),
          ],
        ),
      );
    }

    Widget searchField() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Obx(() => TextField(
              controller: novelController.searchController.value,
              onChanged: (value) {
                novelController.searchController.refresh();

                if (value.length > 2) {
                  novelController.searchNovelsByTitle(value);
                } else {
                  novelController.searchNovelsByTitle('');
                }
              },
              decoration: InputDecoration(
                hintText: 'Search Your Favorite Novel',
                hintStyle: mediumText12.copyWith(color: greyColor),
                fillColor: greyColorSearchField,
                filled: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                isCollapsed: true,
                contentPadding: const EdgeInsets.all(18),
                suffixIcon: novelController.searchController.value.text.isEmpty
                    ? InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: Icon(
                            Icons.search_rounded,
                            color: whiteColor,
                          ),
                        ),
                      )
                    : Padding(
                        padding: textFieldRPadding,
                        child: IconButton(
                          onPressed: () {
                            novelController.searchController.value.clear();
                            novelController.searchController.refresh();
                            novelController.searchNovelsByTitle(''); // Reset search when cleared
                          },
                          icon: const Icon(Icons.cancel, color: Colors.grey),
                        ),
                      ),
              ),
            )),
      );
    }

    Widget searchNovel() {
      return Obx(() => novelController.searchResults.isEmpty
          ? Container()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Search Found',
                    style: semiBoldText16.copyWith(color: blackColor),
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: novelController.searchResults
                        .asMap()
                        .entries
                        .map(
                          (MapEntry map) => Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: SearchNovel(
                              imageUrl: novelController.searchResults[map.key].imageUrl,
                              title: novelController.searchResults[map.key].title,
                              onTap: () async {
                                var novelDetails = await novelDetailsController.novelIDApi(novelController.searchResults[map.key].id);

                                if (novelDetails != null) {
                                  Get.toNamed(
                                    '/details',
                                    arguments: {
                                      'imageUrl': novelController.searchResults[map.key].imageUrl,
                                      'author': novelDetails.author,
                                      'title': novelDetails.title,
                                      'genre': novelDetails.genre,
                                      'ratings': novelDetails.ratings,
                                      'summary': novelDetails.summary,
                                      'publication': novelDetailsController.convertToYear(novelDetails.publication),
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ));
    }

    Widget categories(int index, String category) {
      return InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          setState(() {
            _isSelected = index;
            novelController.filterNovelsByGenre(novelController.genres[index]);
            // print("Selected genre: ${novelController.genres[index]}");
          });
        },
        child: Container(
          margin: const EdgeInsets.only(right: 10, left: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: _isSelected == index ? greenColor : transParentColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            category,
            style: semiBoldText14.copyWith(color: _isSelected == index ? whiteColor : greyColor),
          ),
        ),
      );
    }

    Widget listCategories() {
      return Obx(() {
        if (novelController.genres.isEmpty) {
          return const CircularProgressIndicator();
        } else {
          return SingleChildScrollView(
            padding: EdgeInsets.only(left: 15.w),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: novelController.genres.asMap().entries.map((MapEntry map) => categories(map.key, map.value)).toList(),
            ),
          );
        }
      });
    }

    Widget listNovel() {
      return Obx(() {
        if (novelController.filteredData.isEmpty) {
          return const CircularProgressIndicator();
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: novelController.filteredData
                    .asMap()
                    .entries
                    .map(
                      (MapEntry map) => NovelCollection(
                        info: novelController.filteredData[map.key],
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        }
      });
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                const SizedBox(height: 30),
                searchField(),
                const SizedBox(height: 10),
                searchNovel(),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          listCategories(),
          Padding(
            padding: EdgeInsets.only(left: 15.w, top: 30),
            child: Text(
              'Trending Now',
              style: semiBoldText16.copyWith(color: blackColor),
            ),
          ),
          listNovel(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

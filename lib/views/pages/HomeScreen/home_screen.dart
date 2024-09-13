import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kacs/services/api_services.dart';
import 'package:kacs/views/pages/HomeScreen/controller/novel_controller.dart';
import 'package:kacs/views/pages/HomeScreen/view/widget_novel_collection.dart';

import 'package:kacs/views/themes/theme_config.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kacs/services/api_services.dart';
import 'package:kacs/views/pages/HomeScreen/controller/novel_controller.dart';

import 'package:kacs/views/themes/theme_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final novelController = Get.put(NovelController());

  int _isSelected = 0;

  bool isSearch = false;

  @override
  void initState() {
    super.initState();

    novelController.fetchApi();
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
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage("https://img.icons8.com/?size=100&id=18907&format=png&color=000000"),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello Sarah,',
                  style: semiBoldText16,
                ),
                Text(
                  'Good Morning',
                  style: regularText14.copyWith(color: greyColor),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.menu,
              size: 30,
            ),
          ],
        ),
      );
    }

    Widget searchField() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: TextField(
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
            suffixIcon: InkWell(
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
            ),
          ),
        ),
      );
    }

    Widget recentNovel() {
      return const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            // RecentBook(
            //   image: 'assets/images/recentbook_1.png',
            //   title: 'The Magic',
            // ),
            // SizedBox(width: 20),
            // RecentBook(
            //   image: 'assets/images/recentbook_2.png',
            //   title: 'The Martian',
            // ),
          ],
        ),
      );
    }

    Widget categories(int index, String category) {
      return InkWell(
        // hoverColor: Colors.transparent,
        // splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            _isSelected = index;
            novelController.filterNovelsByGenre(novelController.genres[index]);
            // print("Selected genre: ${novelController.genres[index]}");
          });
        },
        child: Container(
          // margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                isSearch ? const SizedBox(height: 30) : Container(),
                isSearch
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Recent Book',
                          style: semiBoldText16.copyWith(color: blackColor),
                        ),
                      )
                    : Container(),
                const SizedBox(height: 12),
                recentNovel(),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kacs/views/pages/HomeScreen/controller/novel_controller.dart';
import 'package:kacs/views/pages/HomeScreen/model/view_model_novel_list.dart';
import 'package:kacs/views/pages/NovelDetailScreen/controller/novel_details_controller.dart';
import 'package:kacs/views/pages/NovelDetailScreen/model/view_model_novel_details.dart';
import 'package:kacs/views/themes/theme_config.dart';

class NovelCollection extends StatelessWidget {
  NovelCollection({
    super.key,
    required this.info,
  });

  final ViewModelNovelCollection info;
  final novelController = Get.put(NovelDetailsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            var novelDetails = await novelController.novelIDApi(info.id);

            if (novelDetails != null) {
              Get.toNamed(
                '/details',
                arguments: {
                  'imageUrl': info.imageUrl,
                  'author': info.author,
                  'title': info.title,
                  'genre': novelDetails.genre,
                  'ratings': novelDetails.ratings,
                  'summary': novelDetails.summary,
                  'publication': novelController.convertToYear(novelDetails.publication),
                },
              );
            }
          },
          child: Hero(
            tag: context,
            child: Container(
              height: 160,
              width: 110,
              margin: const EdgeInsets.only(top: 12, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(info.imageUrl),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 110,
          child: Text(
            info.author,
            style: mediumText12.copyWith(color: greyColor),
          ),
        ),
        SizedBox(
          width: 110,
          child: Text(
            info.title,
            style: semiBoldText14.copyWith(color: blackColor),
          ),
        ),
      ],
    );
  }
}

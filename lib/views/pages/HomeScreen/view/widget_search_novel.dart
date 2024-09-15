import 'package:flutter/material.dart';
import 'package:kacs/views/themes/theme_config.dart';

class SearchNovel extends StatelessWidget {
  const SearchNovel({
    super.key,
    required this.imageUrl,
    required this.title,
    this.onTap,
  });

  final String imageUrl;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: borderColorRecentBook),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Image.network(
          imageUrl,
          width: 90,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error, color: Colors.red);
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

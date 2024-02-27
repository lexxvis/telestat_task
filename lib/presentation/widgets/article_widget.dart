import 'package:flutter/material.dart';
import 'package:telestat_task/utils/extensions/app_localizations_x.dart';

import '../../data/remote/article.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;

  const ArticleWidget(this.article, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(
          start: 14, end: 14, bottom: 7, top: 7),
      height: MediaQuery.of(context).size.width / 2.2,
      child: Row(
        children: [
          _buildImage(context),
          _buildTitleAndDescription(),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
          ),
          child: Image.network(
            article.urlToImage ?? '',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return  Center(
                child: Text(
                  context.l10n.no_image,
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.black54, // .black87,
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  article.description ?? '',
                  maxLines: 2,
                ),
              ),
            ),

            Row(
              children: [
                const Icon(Icons.timelapse, size: 16),
                const SizedBox(width: 4),
                Text(
                  article.publishedAt ?? '',
                  style: const TextStyle(fontSize: 12,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:telestat_task/utils/constants/api_constants.dart';
import 'package:telestat_task/utils/extensions/app_localizations_x.dart';
import '../../data/remote/news_api.dart';
import '../../data/remote/response.dart';
import '../../utils/colors/app_colors.dart';
import '../widgets/article_widget.dart';

class ApiListScreen extends StatefulWidget {
  const ApiListScreen({super.key});

  @override
  State<ApiListScreen> createState() => _ApiListScreenState();
}

class _ApiListScreenState extends State<ApiListScreen> {
  bool _isLoading = false;
  bool _loadedSuccess = false;
  late Response fetchedData;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
        child: Stack(children: [
          _loadedSuccess
              ? ListView(
                  children: [
                    ...List<Widget>.from(
                      fetchedData.articles!.map(
                        (article) => Builder(
                          builder: (context) => ArticleWidget(article),
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColors.buttonActive,
                ))
              : const SizedBox.shrink(),
          Positioned(
            right: 16,
            bottom: 16,
            child: RawMaterialButton(
              onPressed: _isLoading ? null : _startDownloading,
              elevation: 2.0,
              fillColor: _isLoading
                  ? AppColors.buttonInactive
                  : AppColors.buttonActive,
              padding: const EdgeInsets.all(15.0),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.download_outlined,
                size: 35.0,
              ),
            ),
          )
        ]));
  }

  void _startDownloading() async {
    setState(() => _isLoading = true);

    try {
      fetchedData = await getBreakingNewsArticles(apiKey: apiKey, pageSize: 50);
      _loadedSuccess = true;
    } catch (error) {
      _loadedSuccess = false;
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(context.l10n.error_loading),
      ));
    }

    setState(() => _isLoading = false);
  }
}

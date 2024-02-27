import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telestat_task/utils/colors/app_colors.dart';
import 'package:telestat_task/utils/extensions/app_localizations_x.dart';

import '../../main.dart';
import '../../utils/constants/constants.dart';
import 'api_list_screen.dart';
import 'editable_list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;
  late List<Widget> _children;

  void _onItemTapped(int index) => pageController.jumpToPage(index);

  // {
  //   Locale myLocale = Localizations.localeOf(context);
  //   print('my locale ${myLocale}');
  //   Provider.of<LocaleModel>(context, listen: false).set(Locale('en'));
  // }//=> pageController.jumpToPage(index);

  final pageController = PageController();

  void onPageChanged(int index) {
    setState(() => _currentPageIndex = index);
  }

  @override
  void initState() {
    super.initState();
    _children = [
      const EditListScreen(),
      const ApiListScreen(),
    ];
    //currentLocale = Localizations.localeOf(context).languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.app_title,
          style: const TextStyle(color: AppColors.buttonText),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: OutlinedButton(
              child: Text(
                Localizations.localeOf(context).languageCode,
                style:
                    const TextStyle(color: AppColors.buttonText, fontSize: 18),
              ),
              onPressed: () {
                if (Localizations.localeOf(context).languageCode == 'uk') {
                  Provider.of<LocaleModel>(context, listen: false)
                      .set(const Locale('en'));
                } else if (Localizations.localeOf(context).languageCode ==
                    'en') {
                  Provider.of<LocaleModel>(context, listen: false)
                      .set(const Locale('uk'));
                }
              },
            ),
          ),
        ],
        centerTitle: true,
        toolbarOpacity: 0.8,
        shape: roundedRectangleBorder,
        elevation: 4.00,
        backgroundColor: AppColors.appBar,
        iconTheme: const IconThemeData(
          color: AppColors.buttonText, //change your color here
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.bottomBar,
        unselectedItemColor: AppColors.bottomBarUnselected,
        selectedItemColor: AppColors.bottomBarSelected,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.task_outlined),
            label: context.l10n.app_title,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.task_outlined),
            label: context.l10n.api_task,
          ),
        ],
        currentIndex: _currentPageIndex,
        onTap: _onItemTapped,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: _children,
      ),
    );
  }
}

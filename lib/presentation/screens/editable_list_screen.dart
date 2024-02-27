import 'package:flutter/material.dart';
import 'package:telestat_task/data/editable_list_model.dart';
import 'package:telestat_task/utils/constants/constants.dart';
import 'package:telestat_task/utils/extensions/app_localizations_x.dart';

import '../../utils/colors/app_colors.dart';
import '../widgets/item_card.dart';
import 'item_screen.dart';

class EditListScreen extends StatefulWidget {
  const EditListScreen({super.key});

  @override
  State<EditListScreen> createState() => _EditListScreenState();
}

class _EditListScreenState extends State<EditListScreen>   with AutomaticKeepAliveClientMixin<EditListScreen> {
  late ScrollController _controller;

  var notifications = <EditableListModel>[];

  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
        child: Center(
          child: SizedBox(
            width: 360, //AppDimensions.figmaWidth,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                      child: CustomScrollView(
                    shrinkWrap: true,
                    controller: _controller,
                    slivers: [
                      SliverAnimatedList(
                        key: _listKey,
                        initialItemCount: notifications.length,
                        itemBuilder: (BuildContext context, int index,
                            Animation<double> animation) {
                          return InkWell(
                              onTap: () => _edit(index),
                              child: ItemCard(
                                index: index,
                                onTapDelete: _remove,
                                animation: animation,
                                model: notifications[index],
                              ));
                        },
                      ),
                    ],
                  )),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 0,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0, top: 8, right: 0, bottom: 8),
                          child: SizedBox(
                              width: 360,
                              height: 48,
                              child: TextButton.icon(
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ItemScreen(
                                          appTitle: context.l10n.add_new_item),
                                    ),
                                  );
                                  if (!mounted || result == null) return;
                                  if (result is EditableListModel) {
                                    notifications.add(result);

                                    _listKey.currentState!
                                        .insertItem(notifications.length - 1);
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      _controller.animateTo(
                                        _controller.position.maxScrollExtent,
                                        curve: Curves.easeOut,
                                        duration:
                                            const Duration(milliseconds: 300),
                                      );
                                    });
                                  }
                                },
                                icon: const Icon(Icons.add_circle_rounded,
                                    size: 20, color: AppColors.buttonText),
                                label: Text(context.l10n.add_new_item,
                                    style: buttonTextStyle),
                              ))))
                ]),
          ),
        ));
  }

  void _remove(int index) {
    assert(index < notifications.length, ' invalid remove index value');
    final element = notifications.removeAt(index);
    _listKey.currentState!.removeItem(
        index,
        (context, animation) => SizeTransition(
            sizeFactor: animation,
            child: ItemCard(
              index: index,
              onTapDelete: _remove,
              animation: animation,
              model: element,
            )));
  }

  void _edit(int index) async {
    if (index > notifications.length) return;
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemScreen.edit(
            appTitle: context.l10n.edit_item, model: notifications[index]),
      ),
    );
    if (!mounted || result == null) return;
    if (result is EditableListModel) {
      _listKey.currentState!.setState(() {
        notifications[index] = result;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:telestat_task/data/editable_list_model.dart';
import 'package:telestat_task/utils/extensions/app_localizations_x.dart';

import '../../utils/colors/app_colors.dart';
import '../../utils/constants/constants.dart';


typedef OnTapDelete = void Function(int index);

class ItemCard extends StatelessWidget {
  final int index;
  final EditableListModel model;
  final Animation<double> animation;
  final OnTapDelete onTapDelete;

  const ItemCard({
    super.key,
    required this.index,
    required this.model,
    required this.animation,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: animation,
        child: Card(
          color: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: AppColors.cardBorder, width: 1),
              borderRadius: BorderRadius.circular(16.0)),
          margin: const EdgeInsets.only(left: 0, top: 8, right: 0, bottom: 8),
          child: SizedBox(
              width: 360,
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: 14, top: 16, right: 16, bottom: 16),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(0.0),
                            height: 24,
                            width: 24,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.delete_forever),
                              color: AppColors.deleteIcon,
                              iconSize: 24,
                              onPressed: _delete,
                            ),
                          )),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                  text: context.l10n.time,
                                  style: grayFontStyle,
                                  children: [
                                    TextSpan(
                                        text:
                                            '${model.hour}:${(model.minutes.length == 1) ?
                                            '0${model.minutes}' : model.minutes}',
                                        style: blackFontStyle)
                                  ]),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              model.title,
                              style: blackFontStyle,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                  text: context.l10n.description,
                                  style: grayFontStyle,
                                  children: [
                                    TextSpan(
                                        text: model.description,
                                        style: blackFontStyle)
                                  ]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ))),
        ));
  }

  void _delete() => onTapDelete(index);
}

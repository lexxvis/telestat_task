import 'package:flutter/material.dart';
import 'package:telestat_task/data/editable_list_model.dart';
import 'package:telestat_task/utils/extensions/app_localizations_x.dart';

import '../../utils/colors/app_colors.dart';
import '../../utils/constants/constants.dart';
import '../widgets/pin_widget.dart';

final inputDecorationWithPadding = InputDecoration(
  counterText: '',
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
  // center input text
  errorStyle: const TextStyle(fontSize: 12, color: AppColors.errorMessage),
);

class ItemScreen extends StatefulWidget {
  final EditableListModel model;
  final String appTitle;

  const ItemScreen(
      {super.key,
      required this.appTitle,
      this.model = const EditableListModel(
          title: '', description: '', hour: '', minutes: '')});

  const ItemScreen.edit({
    super.key,
    required this.appTitle,
    required this.model,
  });

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _hours = '';
  String _minutes = '';

  bool _isInputTimeError = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.model.title;
    _descriptionController.text = widget.model.description;
    _hours = widget.model.hour;
    _minutes = widget.model.minutes;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            widget.appTitle,
            style: const TextStyle(color: AppColors.buttonText),
          ),
          centerTitle: true,
          toolbarOpacity: 0.8,
          shape: roundedRectangleBorder,
          elevation: 4.00,
          backgroundColor: AppColors.appBar,
          iconTheme: const IconThemeData(
            color: AppColors.buttonText, //change your color here
          ),
        ),
        body: Form(
            key: _formKey,
            child: Center(
                child: SizedBox(
                    width: 360,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        context.l10n.title,
                                        style: textStyle,
                                      ))),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: TextFormField(
                                    style: textStyle,
                                    controller: _titleController,
                                    decoration: inputDecorationWithPadding,
                                    textAlign: TextAlign.center,
                                    showCursor: true,
                                    cursorHeight: 24,
                                    cursorWidth: 1,
                                    cursorColor: Colors.black,
                                    maxLength: 256,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return context.l10n.enter_title;
                                      }
                                      return null;
                                    },
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        context.l10n.description,
                                        style: textStyle,
                                      ))),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: TextFormField(
                                    maxLines: 4,
                                    style: textStyle,
                                    controller: _descriptionController,
                                    decoration: inputDecorationWithPadding,
                                    textAlign: TextAlign.left,
                                    showCursor: true,
                                    cursorHeight: 24,
                                    cursorWidth: 1,
                                    cursorColor: Colors.black,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return context.l10n.enter_description;
                                      }
                                      return null;
                                    },
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        context.l10n.time,
                                        style: textStyle,
                                      ))),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: PinWidget(
                                        onChanged: (pin) {
                                          _hours = pin.$1;
                                          _minutes = pin.$2;
                                        },
                                        hours: _hours,
                                        minutes: _minutes,
                                      ))),
                              _isInputTimeError
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(context.l10n.enter_time,
                                            style: const TextStyle(
                                                color: AppColors.errorMessage,
                                                fontSize: 12)),
                                      ))
                                  : const SizedBox.shrink(),
                              Flexible(
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          child: SizedBox(
                                              width: 360,
                                              height: 48,
                                              child: TextButton(
                                                onPressed: _confirmPressed,
                                                child: Text(
                                                    context.l10n.confirm,
                                                    style: buttonTextStyle),
                                              )))))
                            ]))))));
  }

  void _confirmPressed() {
    if (_hours.isEmpty || _minutes.isEmpty) {
      setState(() => _isInputTimeError = true);
    } else {
      setState(() => _isInputTimeError = false);
    }
    if (_formKey.currentState!.validate() && (!_isInputTimeError)) {
      Navigator.pop(
          context,
          EditableListModel(
              title: _titleController.text,
              description: _descriptionController.text,
              hour: _hours,
              minutes: _minutes));
    }
  }
}

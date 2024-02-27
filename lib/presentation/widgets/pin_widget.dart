import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final inputDecoration = InputDecoration(
  counterText: '',
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
  contentPadding: EdgeInsets.zero, // center input text
  errorStyle: const TextStyle(fontSize: 0),
);

const textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

const keyboardType = TextInputType.numberWithOptions(decimal: true);

class PinWidget extends StatefulWidget {
  final String hours;
  final String minutes;

  final ValueChanged<(String hours, String minutes)> onChanged;

  const PinWidget(
      {super.key, required this.onChanged, this.hours = '', this.minutes = ''});

  @override
  State<PinWidget> createState() => _PinWidgetState();
}

class _PinWidgetState extends State<PinWidget> {
  final _focuses =
      List<FocusNode>.generate(4, (_) => FocusNode(), growable: false);
  final _pin = List<String>.filled(4, '');

  @override
  void initState() {
    super.initState();
    try {
      int hours = int.parse(widget.hours);
      int minutes = int.parse(widget.minutes);
      if (hours > 23 || hours < 0) return;
      if (minutes > 59 || minutes < 0) return;
    } catch (e) {
      debugPrint('parsing error + $e');
      return;
    }

    if (widget.hours.length == 1) {
      _pin[1] = widget.hours[0];
    } else {
      _pin[0] = widget.hours[0];
      _pin[1] = widget.hours[1];
    }
    if (widget.minutes.length == 1) {
      _pin[2] = '0';
      _pin[3] = widget.minutes[0];
    } else {
      _pin[2] = widget.minutes[0];
      _pin[3] = widget.minutes[1];
    }
  }

  @override
  void dispose() {
    for (var element in _focuses) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 232,
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: TextFormField(
                  initialValue: _pin[0],
                  onChanged: (text) {
                    if (text.length == 1) {
                      FocusScope.of(context).requestFocus(_focuses[1]);
                    }
                    _pin[0] = text;
                    setState(() {});
                    _onChangedCall();
                  },
                  keyboardType: keyboardType,
                  inputFormatters: _checkHighHourFormat()
                      ? [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-2]')),
                        ]
                      : [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-1]')),
                        ],
                  focusNode: _focuses[0],
                  textAlign: TextAlign.center,
                  showCursor: true,
                  cursorHeight: 24,
                  cursorWidth: 1,
                  cursorColor: Colors.black,
                  maxLength: 1,
                  style: textStyle,
                  decoration: inputDecoration)),
          const Expanded(child: SizedBox()),
          Expanded(
              flex: 4,
              child: TextFormField(
                  initialValue: _pin[1],
                  onChanged: (text) {
                    if (text.length == 1) {
                      FocusScope.of(context).requestFocus(_focuses[2]);
                    }
                    _pin[1] = text;
                    setState(() {});
                    _onChangedCall();
                  },
                  keyboardType: keyboardType,
                  inputFormatters: _checkLowHourFormat()
                      ? [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ]
                      : [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-3]')),
                        ],
                  focusNode: _focuses[1],
                  textAlign: TextAlign.center,
                  showCursor: true,
                  cursorHeight: 24,
                  cursorWidth: 1,
                  cursorColor: Colors.black,
                  maxLength: 1,
                  style: textStyle,
                  decoration: inputDecoration)),
          const Expanded(child: SizedBox()),
          const Expanded(
              child: Text(
            ':',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          )),
          const Expanded(child: SizedBox()),
          Expanded(
              flex: 4,
              child: TextFormField(
                  initialValue: _pin[2],
                  onChanged: (text) {
                    if (text.length == 1) {
                      FocusScope.of(context).requestFocus(_focuses[3]);
                    }
                    _pin[2] = text;
                    _onChangedCall();
                  },
                  keyboardType: keyboardType,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-5]')),
                  ],
                  focusNode: _focuses[2],
                  textAlign: TextAlign.center,
                  showCursor: true,
                  cursorHeight: 24,
                  cursorWidth: 1,
                  cursorColor: Colors.black,
                  maxLength: 1,
                  style: textStyle,
                  decoration: inputDecoration)),
          const Expanded(child: SizedBox()),
          Expanded(
              flex: 4,
              child: TextFormField(
                  onChanged: (text) {
                    _pin[3] = text;
                    _onChangedCall();
                  },
                  initialValue: _pin[3],
                  keyboardType: keyboardType,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  focusNode: _focuses[3],
                  textAlign: TextAlign.center,
                  showCursor: true,
                  cursorHeight: 24,
                  cursorWidth: 1,
                  cursorColor: Colors.black,
                  maxLength: 1,
                  style: textStyle,
                  decoration: inputDecoration)),
        ],
      ),
    );
  }

  void _onChangedCall() =>
      widget.onChanged((_pin[0] + _pin[1], _pin[2] + _pin[3]));

  bool _checkLowHourFormat() {
    if (_pin[0].isEmpty) return true;
    if (int.parse(_pin[0]) < 2) return true;
    return false;
  }

  bool _checkHighHourFormat() {
    if (_pin[1].isEmpty) return true;
    if (int.parse(_pin[1]) < 3) return true;
    return false;
  }
}

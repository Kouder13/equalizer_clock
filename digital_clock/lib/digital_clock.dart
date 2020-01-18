// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum _Clock {
  hourTens,
  hourOnes,
  minuteTens,
  minuteOnes,
  secondTens,
  secondOnes
}

final hourColor = Colors.green;
final minuteColor = Colors.white;
final secondeColor = Colors.red;
final borderColor = Colors.cyanAccent;
final emptyColor = Colors.black;
final backgroundColor = Colors.black87;

/// A basic digital clock.
///
/// You can do better than this! Thank you :)
class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  EqualizerTime _now = EqualizerTime();
  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      Timer.periodic(Duration(seconds: 1), (v) {
        setState(() {
          _now = EqualizerTime();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: EqualizerClockColumn(
              color: hourColor,
              digit: _now.hourTens,
              row: _Clock.hourTens,
            ),
          ),
          Expanded(
            flex: 2,
            child: EqualizerClockColumn(
              color: hourColor,
              digit: _now.hourOnes,
              row: _Clock.hourOnes,
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 2,
            child: EqualizerClockColumn(
              color: minuteColor,
              digit: _now.minuteTens,
              row: _Clock.minuteTens,
            ),
          ),
          Expanded(
            flex: 2,
            child: EqualizerClockColumn(
              color: minuteColor,
              digit: _now.minuteOnes,
              row: _Clock.minuteOnes,
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 2,
            child: EqualizerClockColumn(
              color: secondeColor,
              digit: _now.secondTens,
              row: _Clock.secondTens,
            ),
          ),
          Expanded(
            flex: 2,
            child: EqualizerClockColumn(
              color: secondeColor,
              digit: _now.secondOnes,
              row: _Clock.secondOnes,
            ),
          ),
        ],
      ),
    );
  }
}

/// class [EqualizerClockColumn] to display column clock as equalizer & digit
class EqualizerClockColumn extends StatelessWidget {
  final String digit;
  final Color color;
  final _Clock row;
  EqualizerClockColumn({this.digit, this.color, this.row});

  List<int> itemColumnList(String digitNumber) {
    List<int> itemList = [];
    EqualizerTime _now = EqualizerTime();
    var n = int.parse(digitNumber);

    if (row == _Clock.secondOnes ||
        row == _Clock.minuteOnes ||
        (row == _Clock.hourOnes && _now.hourTens == '0') ||
        (row == _Clock.hourOnes && _now.hourTens == '1'))
      switch (n) {
        case 0:
          itemList = [0, 0, 0, 0, 0, 0, 0, 0, 0];
          break;
        case 1:
          itemList = [0, 0, 0, 0, 0, 0, 0, 0, 1];
          break;
        case 2:
          itemList = [0, 0, 0, 0, 0, 0, 0, 1, 1];
          break;
        case 3:
          itemList = [0, 0, 0, 0, 0, 0, 1, 1, 1];
          break;
        case 4:
          itemList = [0, 0, 0, 0, 0, 1, 1, 1, 1];
          break;
        case 5:
          itemList = [0, 0, 0, 0, 1, 1, 1, 1, 1];
          break;
        case 6:
          itemList = [0, 0, 0, 1, 1, 1, 1, 1, 1];
          break;
        case 7:
          itemList = [0, 0, 1, 1, 1, 1, 1, 1, 1];
          break;
        case 8:
          itemList = [0, 1, 1, 1, 1, 1, 1, 1, 1];
          break;
        case 9:
          itemList = [1, 1, 1, 1, 1, 1, 1, 1, 1];
          break;
      }
    else if (row == _Clock.secondTens || row == _Clock.minuteTens)
      switch (n) {
        case 0:
          itemList = [0, 0, 0, 0, 0];
          break;
        case 1:
          itemList = [0, 0, 0, 0, 1];
          break;
        case 2:
          itemList = [0, 0, 0, 1, 1];
          break;
        case 3:
          itemList = [0, 0, 1, 1, 1];
          break;
        case 4:
          itemList = [0, 1, 1, 1, 1];
          break;
        case 5:
          itemList = [1, 1, 1, 1, 1];
          break;
      }
    else if (row == _Clock.hourOnes && _now.hourTens == '2')
      switch (n) {
        case 0:
          itemList = [0, 0, 0];
          break;
        case 1:
          itemList = [0, 0, 1];
          break;
        case 2:
          itemList = [0, 1, 1];
          break;
        case 3:
          itemList = [1, 1, 1];
          break;
      }
    else if (row == _Clock.hourTens)
      switch (n) {
        case 0:
          itemList = [0, 0];
          break;
        case 1:
          itemList = [0, 1];
          break;
        case 2:
          itemList = [1, 1];
          break;
      }
    return itemList;
  }

  List<Widget> _buildItemColumnList(
      String digitNumber, Color color, double itemWidth, double itemHeight) {
    List<Widget> drawClock = [];
    List<int> items = itemColumnList(digitNumber);
    for (int i = 0; i < items.length; i++) {
      drawClock.add(
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: itemWidth,
          height: itemHeight,
          decoration: ShapeDecoration(
            color: items[i] == 1 ? color : emptyColor,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(itemHeight),
              side: BorderSide(
                color: borderColor,
                width: 0.25,
              ),
            ),
          ),
        ),
      );
    }
    return drawClock;
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width / 6;
    final containerHeight = fontSize * 1.5;
    final itemWidth = containerHeight / 3;
    final itemHeight = containerHeight / 9;
    final defaultStyle = TextStyle(
      color: color,
      fontFamily: 'Vraangoe',
      fontSize: fontSize,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: containerHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _buildItemColumnList(digit, color, itemWidth, itemHeight),
          ),
        ),
        Container(
          child: Text(digit, style: defaultStyle),
        ),
      ],
    );
  }
}

/// class [EqualizerTime] to access values as digits
class EqualizerTime {
  List<String> digitNumbers;

  EqualizerTime() {
    DateTime now = DateTime.now();
    String hhmmss = DateFormat('Hms').format(now).replaceAll(':', '');
    digitNumbers =
        hhmmss.split('').map((str) => int.parse(str).toString()).toList();
  }

  get hourTens => digitNumbers[0];
  get hourOnes => digitNumbers[1];
  get minuteTens => digitNumbers[2];
  get minuteOnes => digitNumbers[3];
  get secondTens => digitNumbers[4];
  get secondOnes => digitNumbers[5];
}

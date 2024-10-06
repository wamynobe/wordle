import 'package:flutter/material.dart';
import 'package:wordle/shared/out_words.dart';

const kBackSpaceKey = 'back_space';

const firstKeyboardLine = {
  'q',
  'w',
  'e',
  'r',
  't',
  'y',
  'u',
  'i',
  'o',
  'p',
};

const secondKeyboardLine = {
  'a',
  's',
  'd',
  'f',
  'g',
  'h',
  'j',
  'k',
  'l',
};

const thirdKeyboardLine = {
  'z',
  'x',
  'c',
  'v',
  'b',
  'n',
  'm',
  'back_space',
};

extension StringExt on String {
  bool isAWord() => listWords.contains(this);
}

extension ListDivideExt<T extends Widget> on Iterable<T> {
  Iterable<MapEntry<int, Widget>> get enumerate => toList().asMap().entries;

  List<Widget> divide(Widget t) => isEmpty
      ? <Widget>[]
      : enumerate.map((e) => <Widget>[e.value, t]).expand((ex) => ex).toList()
    ..removeLast();
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum LetterState {
  init,
  inCorrect,
  correct,
  wrongPlace;

  Color get color => switch (this) {
        LetterState.correct => Colors.green[200] ?? Colors.green,
        LetterState.inCorrect => Colors.grey[400] ?? Colors.grey,
        LetterState.wrongPlace => Colors.yellow[200] ?? Colors.yellow,
        _ => Colors.transparent,
      };
}

class LetterModel extends Equatable {
  final String text;

  final LetterState letterState;

  const LetterModel({
    required this.text,
    this.letterState = LetterState.init,
  });

  @override
  List<Object?> get props => [
        text,
        letterState,
      ];

  LetterModel copyWith({
    String? text,
    LetterState? letterState,
  }) {
    return LetterModel(
      text: text ?? this.text,
      letterState: letterState ?? this.letterState,
    );
  }
}

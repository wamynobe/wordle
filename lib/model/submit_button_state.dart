import 'package:flutter/material.dart';

enum SubmitButtonState {
  disable,
  enable,
  notAWord;

  String get title => switch (this) {
        SubmitButtonState.notAWord => 'NOT A WORD',
        _ => 'SUBMIT',
      };

  ({Color top, Color bottom}) get buttonColor => switch (this) {
        SubmitButtonState.notAWord => (
            top: Colors.red,
            bottom: Colors.red[600] ?? Colors.red,
          ),
        SubmitButtonState.disable => (
            top: Colors.white,
            bottom: Colors.grey[300] ?? Colors.grey,
          ),
        SubmitButtonState.enable => (
            top: Colors.green,
            bottom: Colors.green[600] ?? Colors.green,
          ),
      };
  Color get titleColor => switch (this) {
        SubmitButtonState.notAWord => Colors.white,
        SubmitButtonState.disable => Colors.grey,
        SubmitButtonState.enable => Colors.white,
      };
}

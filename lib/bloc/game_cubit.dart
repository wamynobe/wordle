import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:wordle/model/letter_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/model/submit_button_state.dart';
import 'package:wordle/shared/out_words.dart';
import 'package:wordle/shared/utils.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(const GameState());

  void onInitialize() {
    final answer = getRandomWord();
    final letters = List<List<LetterModel?>>.generate(
      state.totalRows,
      (_) => List<LetterModel?>.generate(state.totalColumns, (_) => null),
    );
    emit(state.copyWith(
      letters: letters,
      answer: answer,
    ));
  }

  void onAddNewLetter(String? letter) {
    if (state.currentColumn >= state.totalColumns && letter != null) {
      return;
    }
    var letters = state.letters;
    final safeRow = state.currentRow.clamp(0, state.totalRows - 1);
    final safeColumn = state.currentColumn.clamp(0, state.totalColumns - 1);
    var currentColumn = safeColumn;
    if (letter?.isEmpty ?? true) {
      if (safeColumn < 0) {
        return;
      }
      letters[safeRow] = letters[safeRow]
        ..removeAt(safeColumn)
        ..insert(safeColumn, null);
      currentColumn = currentColumn - 1;
    } else {
      letters[safeRow] = letters[safeRow]
        ..removeAt(safeColumn)
        ..insert(safeColumn, LetterModel(text: letter!));
      currentColumn = currentColumn + 1;
    }
    var submitButtonState = SubmitButtonState.disable;
    final rowString =
        letters[safeRow].map((element) => element?.text ?? '').join();
    if (state.currentColumn == state.totalColumns - 1) {
      submitButtonState = rowString.isAWord()
          ? SubmitButtonState.enable
          : SubmitButtonState.notAWord;
    }
    emit(state.copyWith(
      letters: letters,
      currentColumn: currentColumn,
      submitButtonState: submitButtonState,
    ));
  }

  void onSumbitWord() {
    print('anwser ${state.answer}');
    var currentWord = state.letters[state.currentRow];
    final answerSplitted = state.answer.split('');
    if (currentWord.length != answerSplitted.length) {
      return;
    }
    var currentRow = state.currentRow;
    var letters = List.of(state.letters);
    var isRightAnswer = true;
    answerSplitted.mapIndexed((index, letter) {
      if (letter != currentWord[index]?.text) {
        isRightAnswer = false;
      }
    }).toList();
    if (isRightAnswer) {
      //TODO: end game logic
    } else {
      currentRow = currentRow + 1;
    }
    currentWord = currentWord.mapIndexed((index, letter) {
      var letterState = LetterState.inCorrect;
      if (letter?.text != answerSplitted[index]) {
        if (answerSplitted.contains(letter?.text ?? '')) {
          letterState = LetterState.wrongPlace;
        }
      } else {
        letterState = LetterState.correct;
      }

      return letter?.copyWith(letterState: letterState);
    }).toList();
    letters[state.currentRow] = currentWord;
    emit(state.copyWith(
      letters: letters,
      currentRow: currentRow,
      currentColumn: 0,
      submitButtonState: SubmitButtonState.disable,
    ));
  }
}

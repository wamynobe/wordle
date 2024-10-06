part of 'game_cubit.dart';

enum GameEndingState {
  win,
  lose,
  idle,
}

class GameState extends Equatable {
  final List<List<LetterModel?>> letters;
  final String answer;
  final int totalRows;
  final int totalColumns;
  final int currentRow;
  final int currentColumn;
  final SubmitButtonState submitButtonState;
  final GameEndingState gameEndingState;

  const GameState({
    this.letters = const [[]],
    this.answer = '',
    this.totalRows = 6,
    this.totalColumns = 5,
    this.currentColumn = 0,
    this.currentRow = 0,
    this.submitButtonState = SubmitButtonState.disable,
    this.gameEndingState = GameEndingState.idle,
  });

  @override
  List<Object?> get props => [
        letters,
        answer,
        totalRows,
        totalColumns,
        currentColumn,
        currentRow,
        submitButtonState,
        gameEndingState,
      ];

  GameState copyWith({
    List<List<LetterModel?>>? letters,
    String? answer,
    int? totalRows,
    int? totalColumns,
    int? currentRow,
    int? currentColumn,
    SubmitButtonState? submitButtonState,
    GameEndingState? gameEndingState,
  }) {
    return GameState(
      letters: letters ?? this.letters,
      answer: answer ?? this.answer,
      totalRows: totalRows ?? this.totalRows,
      totalColumns: totalColumns ?? this.totalColumns,
      currentRow: currentRow ?? this.currentRow,
      currentColumn: currentColumn ?? this.currentColumn,
      submitButtonState: submitButtonState ?? this.submitButtonState,
      gameEndingState: gameEndingState ?? this.gameEndingState,
    );
  }
}

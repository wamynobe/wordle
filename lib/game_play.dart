import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:wordle/bloc/game_cubit.dart';
import 'package:wordle/shared/utils.dart';

class GamePlay extends StatelessWidget {
  const GamePlay({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Center(
        child: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                state.totalRows,
                (row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      state.totalColumns,
                      (column) => Container(
                        width: 60,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: Colors.white,
                          ),
                          color: state.letters[row][column]?.letterState.color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          (state.letters[row][column]?.text ?? '')
                              .toUpperCase(),
                          style: theme.displayMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ).divide(const Gap(8)),
                  );
                },
              ).divide(const Gap(10)),
            );
          },
        ),
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:wordle/bloc/game_cubit.dart';
import 'package:wordle/game_play.dart';
import 'package:wordle/model/submit_button_state.dart';
import 'package:wordle/shared/game_button.dart';
import 'package:wordle/shared/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Worldle',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => GameCubit()..onInitialize(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _autoSizeGroup = AutoSizeGroup();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(172, 250, 250, 250),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(30),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'SCORE',
                        style: theme.titleMedium,
                      ),
                      Text(
                        '0',
                        style: theme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
            const GamePlay(),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...firstKeyboardLine.map(
                        (key) {
                          return Flexible(
                            child: KeyboardItem(
                              text: key,
                              autoSizeGroup: _autoSizeGroup,
                              onTap: () {
                                context.read<GameCubit>().onAddNewLetter(key);
                              },
                            ),
                          );
                        },
                      ).divide(const Gap(5)),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Gap(15),
                      ...secondKeyboardLine.map(
                        (key) {
                          return Flexible(
                            child: KeyboardItem(
                              text: key,
                              onTap: () {
                                context.read<GameCubit>().onAddNewLetter(key);
                              },
                            ),
                          );
                        },
                      ).divide(const Gap(5)),
                      const Gap(15),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Gap(30),
                      ...thirdKeyboardLine.map(
                        (key) {
                          return Flexible(
                            child: KeyboardItem(
                              text: key,
                              onTap: () {
                                final letter =
                                    key == kBackSpaceKey ? null : key;
                                context
                                    .read<GameCubit>()
                                    .onAddNewLetter(letter);
                              },
                            ),
                          );
                        },
                      ).divide(const Gap(5)),
                    ],
                  ),
                ],
              ),
            ),
            BlocBuilder<GameCubit, GameState>(
              builder: (context, state) {
                return GameButton(
                  onTap: state.submitButtonState == SubmitButtonState.enable
                      ? () {
                          context.read<GameCubit>().onSumbitWord();
                        }
                      : null,
                  height: 56,
                  constraints: const BoxConstraints(maxWidth: 150),
                  borderRadius: BorderRadius.circular(24),
                  topColor: state.submitButtonState.buttonColor.top,
                  bottomColor: state.submitButtonState.buttonColor.bottom,
                  child: Center(
                    child: Text(
                      state.submitButtonState.title.toUpperCase(),
                      style: theme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: state.submitButtonState.titleColor,
                      ),
                    ),
                  ),
                );
              },
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}

class KeyboardItem extends StatelessWidget {
  const KeyboardItem({
    super.key,
    required this.text,
    this.autoSizeGroup,
    this.onTap,
  });
  final String text;
  final AutoSizeGroup? autoSizeGroup;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    final Widget child = text == kBackSpaceKey
        ? const Icon(Icons.backspace)
        : AutoSizeText(
            text,
            group: autoSizeGroup,
            style: theme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          );

    return GameButton(
      topColor: Colors.white,
      bottomColor: Colors.grey[300] ?? Colors.grey,
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: child,
      ),
    );
  }
}

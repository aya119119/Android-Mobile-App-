import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121213), // real Wordle dark
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121213),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BIRDLE'),
          centerTitle: true,
        ),
        body: const Center(child: GamePage()),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Game _game = Game();
  String? _errorMessage;

  void _handleGuess(String guess) {
    if (_game.didWin || _game.didLose) return;

    setState(() {
      _errorMessage = null;

      if (!_game.isLegalGuess(guess)) {
        _errorMessage = 'Not in word list';
        return;
      }

      _game.guess(guess);
    });
  }

  void _newGame() {
    setState(() {
      _game.resetGame();
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          // Remaining guesses
          Text(
            'Guesses left: ${_game.guessesRemaining}',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade400,
            ),
          ),

          const SizedBox(height: 16),

          // 5×5 Grid
          for (final guess in _game.guesses)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final letter in guess)
                  Padding(
                    padding: const EdgeInsets.all(3.5),
                    child: Tile(letter.char, letter.type),
                  ),
              ],
            ),

          const SizedBox(height: 28),

          // Win / Lose
          if (_game.didWin)
            const Text(
              '🎉 You won!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6AAA64),
              ),
            )
          else if (_game.didLose)
            Text(
              'Game Over\nThe word was: ${_game.hiddenWord.toString().toUpperCase()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),

          const SizedBox(height: 12),

          // Error message
          if (_errorMessage != null)
            Text(
              _errorMessage!,
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

          const SizedBox(height: 16),

          // Input or New Game
          if (!_game.didWin && !_game.didLose)
            GuessInput(onSubmitGuess: _handleGuess)
          else
            ElevatedButton.icon(
              onPressed: _newGame,
              icon: const Icon(Icons.refresh),
              label: const Text('New Game'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6AAA64),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}

class GuessInput extends StatefulWidget {
  const GuessInput({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;

  @override
  State<GuessInput> createState() => _GuessInputState();
}

class _GuessInputState extends State<GuessInput> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSubmit() {
    widget.onSubmitGuess(_textEditingController.text.trim());
    _textEditingController.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            maxLength: 5,
            focusNode: _focusNode,
            autofocus: true,
            style: const TextStyle(fontSize: 20, letterSpacing: 4),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: Colors.grey.shade900,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF6AAA64), width: 2),
              ),
            ),
            controller: _textEditingController,
            onSubmitted: (_) => _onSubmit(),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: _onSubmit,
          icon: const Icon(Icons.arrow_circle_up, size: 42),
          color: const Color(0xFF6AAA64),
        ),
      ],
    );
  }
}

class Tile extends StatelessWidget {
  const Tile(this.letter, this.hitType, {super.key});

  final String letter;
  final HitType hitType;

  @override
  Widget build(BuildContext context) {
    final bool hasColor = hitType != HitType.none;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 62,
      width: 62,
      decoration: BoxDecoration(
        color: switch (hitType) {
          HitType.hit => const Color(0xFF6AAA64),
          HitType.partial => const Color(0xFFC9B458),
          HitType.miss => const Color(0xFF787C7E),
          _ => const Color(0xFF121213),
        },
        border: Border.all(
          color: hasColor ? Colors.transparent : Colors.grey.shade700,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          letter.toUpperCase(),
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: hasColor ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }
}
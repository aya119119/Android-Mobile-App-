import 'package:flutter/material.dart';
import 'about_screen.dart';
import 'theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  String? _banner;
  bool _bannerOk = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _controller.text.trim();
    setState(() {
      if (name.isEmpty) {
        _banner = "Type a name to begin! 💡";
        _bannerOk = false;
      } else {
        _banner = "Nice to meet you, $name! 🎉";
        _bannerOk = true;
      }
    });
    FocusScope.of(context).unfocus();
  }

  // Passes the name typed in the TextField to the About screen.
  void _goToAbout() {
    final name = _controller.text.trim();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AboutScreen(name: name.isEmpty ? 'friend' : name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 16,
        title: Row(
          children: [
            const Icon(Icons.lightbulb, color: AppColors.yellow, size: 30),
            const SizedBox(width: 8),
            Text('Aha!', style: heading(22, color: AppColors.primary)),
            const SizedBox(width: 6),
            Text('• Home', style: heading(18, color: AppColors.textSoft)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.person, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMascot(),
                  const SizedBox(height: 24),
                  Text('Hi there, young thinker!',
                      textAlign: TextAlign.center, style: heading(28)),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Let's figure things out together. I'll give you hints, and you'll find the answer yourself!",
                      textAlign: TextAlign.center,
                      style: body(16, weight: FontWeight.w400)
                          .copyWith(height: 1.5),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildNameField(),
                  const SizedBox(height: 16),
                  _buildSubmitButton(),
                  if (_banner != null) ...[
                    const SizedBox(height: 16),
                    _buildBanner(),
                  ],
                  const SizedBox(height: 16),
                  _buildMeetButton(),
                  const SizedBox(height: 20),
                  _buildFooterChips(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primaryFixed,
        onDestinationSelected: (i) {
          if (i != 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Coming soon! 🚀')),
            );
          }
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: AppColors.primary),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.school_outlined), label: 'Quests'),
          NavigationDestination(
              icon: Icon(Icons.star_outline), label: 'Stars'),
        ],
      ),
    );
  }

  Widget _buildMascot() {
    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              color: AppColors.yellow,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.yellow.withValues(alpha: 0.35),
                  blurRadius: 28,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: const Icon(Icons.lightbulb,
                size: 72, color: AppColors.onYellow),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: const Icon(Icons.star, color: AppColors.yellow, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text("What's your name? ✨",
              style: body(18,
                  color: AppColors.text, weight: FontWeight.w700)),
        ),
        TextField(
          controller: _controller,
          maxLength: 20,
          textInputAction: TextInputAction.done,
          onChanged: (_) => setState(() {}),
          onSubmitted: (_) => _submit(),
          cursorColor: AppColors.primary,
          style: body(18, color: AppColors.text, weight: FontWeight.w600),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: AppColors.card,
            hintText: 'Type your name here',
            hintStyle: body(18, color: AppColors.outlineLight),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            prefixIcon: const Icon(Icons.face, color: AppColors.purple),
            suffixIcon: _controller.text.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.cancel,
                        size: 20, color: AppColors.outline),
                    onPressed: () {
                      _controller.clear();
                      setState(() {});
                    },
                  ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide:
                  const BorderSide(color: AppColors.purple, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _submit,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.purple,
          foregroundColor: Colors.white,
          elevation: 6,
          shadowColor: AppColors.purple.withValues(alpha: 0.5),
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Let's go",
                style: body(18, color: Colors.white, weight: FontWeight.w700)),
            const SizedBox(width: 8),
            const Icon(Icons.rocket_launch, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    final ok = _bannerOk;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: ok
            ? AppColors.mint.withValues(alpha: 0.3)
            : AppColors.cardHigh,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (ok) ...[
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                  color: AppColors.mint, shape: BoxShape.circle),
              child: const Icon(Icons.check,
                  size: 18, color: Color(0xFF00210C)),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              _banner!,
              textAlign: TextAlign.center,
              style: body(18,
                  color: ok ? AppColors.green : AppColors.textSoft,
                  weight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeetButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _goToAbout,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cardHigh,
          foregroundColor: AppColors.primary,
          elevation: 1,
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Meet Aha!',
                style: body(18,
                    color: AppColors.primary, weight: FontWeight.w700)),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterChips() {
    Widget chip(IconData icon, Color color, String label) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 4),
            Text(label,
                style: body(12,
                    color: AppColors.textSoft, weight: FontWeight.w700)),
          ],
        );
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 8,
      children: [
        chip(Icons.timer_off, AppColors.yellow, 'No timers'),
        chip(Icons.spa, AppColors.green, 'Safe & calm'),
      ],
    );
  }
}

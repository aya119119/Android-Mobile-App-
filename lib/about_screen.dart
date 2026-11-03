import 'package:flutter/material.dart';
import 'theme.dart';

class AboutScreen extends StatefulWidget {
  /// The name typed on the Home screen.
  final String name;

  const AboutScreen({super.key, required this.name});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  bool _sparkle = false;

  void _triggerSparkle() {
    setState(() => _sparkle = true);
    Future.delayed(const Duration(milliseconds: 750), () {
      if (mounted) setState(() => _sparkle = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purple,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 4,
        shadowColor: AppColors.purple.withValues(alpha: 0.4),
        title: Row(
          children: [
            const Icon(Icons.lightbulb, color: AppColors.yellow, size: 28),
            const SizedBox(width: 8),
            Text('About Aha!', style: heading(22, color: Colors.white)),
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
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGreeting(),
                  const SizedBox(height: 12),
                  Text(
                    'Aha! is your homework buddy. It never just tells you the answer. It guides you with small hints so you really understand.',
                    style:
                        body(16, weight: FontWeight.w400).copyWith(height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  _buildGallery(),
                  const SizedBox(height: 20),
                  _buildLadderHeader(),
                  const SizedBox(height: 16),
                  const _StepCard(
                      number: '1',
                      title: 'What is the question really asking?',
                      subtitle: 'Find the secret goal'),
                  const SizedBox(height: 12),
                  const _StepCard(
                      number: '2',
                      title: 'What do you already know?',
                      subtitle: 'Gather your tools and facts'),
                  const SizedBox(height: 12),
                  const _StepCard(
                      number: '3',
                      title: 'Try the first step!',
                      subtitle: 'Small moves make big leaps'),
                  const SizedBox(height: 20),
                  _buildHighlightCard(),
                  const SizedBox(height: 20),
                  _buildKidRule(),
                  const SizedBox(height: 32),
                  _buildBackButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('MISSION & GUIDE',
                  style: body(12,
                      color: AppColors.textSoft, weight: FontWeight.w700)
                      .copyWith(letterSpacing: 1.2)),
              const SizedBox(height: 4),
              Text('Welcome, ${widget.name}! 👋', style: heading(28)),
            ],
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: _triggerSparkle,
          child: SizedBox(
            width: 64,
            height: 64,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.yellow,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.yellow.withValues(alpha: 0.35),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.lightbulb,
                      size: 32, color: AppColors.onYellow),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    opacity: _sparkle ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.auto_awesome,
                        size: 20, color: AppColors.purple),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGallery() {
    return Row(
      children: [
        Expanded(
          child: _GalleryTile(
            icon: Icons.smart_toy,
            label: 'No Spoilers',
            labelIcon: Icons.psychology,
            labelIconColor: AppColors.purple,
            colors: const [Color(0xFFE6DEFF), Color(0xFFC9BEFF)],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _GalleryTile(
            icon: Icons.extension,
            label: 'Step by Step',
            labelIcon: Icons.explore,
            labelIconColor: Color(0xFF775A00),
            colors: const [Color(0xFFFFF1C7), Color(0xFFFDC73A)],
          ),
        ),
      ],
    );
  }

  Widget _buildLadderHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: Text('How Aha! helps you', style: heading(22))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.cardHigh,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text('3 Steps',
              style: body(12,
                  color: AppColors.primary, weight: FontWeight.w700)),
        ),
      ],
    );
  }

  Widget _buildHighlightCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.yellow.withValues(alpha: 0.28),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.emoji_objects,
                size: 24, color: AppColors.onYellow),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You've got this! Every ‘aha!’ makes your brain stronger.",
                  style: body(18,
                      color: AppColors.onYellow, weight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text('Practice makes progress',
                    style: body(12,
                        color: AppColors.onYellow.withValues(alpha: 0.8),
                        weight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKidRule() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
                color: AppColors.primaryFixed, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: const Text('⚡', style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kid Rule',
                    style: body(12,
                        color: AppColors.primary, weight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(
                  'No scary countdowns, no red marks. Just playful curiosity at your own tempo.',
                  style: body(14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 6,
          shadowColor: AppColors.primary.withValues(alpha: 0.4),
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home, size: 22),
            const SizedBox(width: 8),
            Text('Back to Home',
                style: body(18, color: Colors.white, weight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;

  const _StepCard({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.yellow,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: AppColors.yellowShadow, offset: Offset(0, 3)),
              ],
            ),
            child: Text(number,
                style: body(18,
                    color: AppColors.onYellow, weight: FontWeight.w800)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: body(18,
                        color: AppColors.text, weight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: body(12,
                        color: AppColors.textSoft, weight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GalleryTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final IconData labelIcon;
  final Color labelIconColor;
  final List<Color> colors;

  const _GalleryTile({
    required this.icon,
    required this.label,
    required this.labelIcon,
    required this.labelIconColor,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(icon,
                size: 56, color: Colors.white.withValues(alpha: 0.9)),
          ),
          Positioned(
            left: 8,
            bottom: 8,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(labelIcon, size: 14, color: labelIconColor),
                  const SizedBox(width: 4),
                  Text(label,
                      style: body(12,
                          color: AppColors.text, weight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

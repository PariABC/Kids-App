import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/app_state.dart';
import 'home_screen.dart';

class ClassSelectionScreen extends StatelessWidget {
  const ClassSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final classes = [
      {'name': 'Nursery', 'color': const Color(0xFFFF6B6B), 'emoji': '🌱'},
      {'name': 'LKG', 'color': const Color(0xFF4ECDC4), 'emoji': '📘'},
      {'name': 'UKG', 'color': const Color(0xFF45B7D1), 'emoji': '🎓'},
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                'ICSE Kids',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ).animate().fadeIn().slideY(begin: -0.2),
              const SizedBox(height: 8),
              Text(
                'Choose your class',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white70,
                    ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: classes.length,
                  itemBuilder: (context, index) {
                    final item = classes[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _ClassCard(
                        title: item['name'] as String,
                        color: item['color'] as Color,
                        emoji: item['emoji'] as String,
                        onTap: () {
                          context.read<AppState>().setClass(item['name'] as String);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        },
                      ).animate().fadeIn(delay: (100 * index).ms).slideX(begin: 0.2),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClassCard extends StatelessWidget {
  final String title;
  final Color color;
  final String emoji;
  final VoidCallback onTap;

  const _ClassCard({
    required this.title,
    required this.color,
    required this.emoji,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 42)),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: color),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}

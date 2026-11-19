import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'lesson_screen.dart';

class SubjectScreen extends StatelessWidget {
  final String subjectName;

  const SubjectScreen({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    // Sample lessons - you can later load from JSON
    final lessons = List.generate(10, (index) {
      return {
        'id': '\( {subjectName.toLowerCase()}_ \){index + 1}',
        'title': '$subjectName ${index + 1}',
        'subtitle': 'Lesson ${index + 1}',
      };
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(subjectName),
        backgroundColor: const Color(0xFF667eea),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xFFF8F9FF),
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: lessons.length,
          itemBuilder: (context, index) {
            final lesson = lessons[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _LessonTile(
                title: lesson['title'] as String,
                subtitle: lesson['subtitle'] as String,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LessonScreen(
                        lessonId: lesson['id'] as String,
                        lessonTitle: lesson['title'] as String,
                        subject: subjectName,
                      ),
                    ),
                  );
                },
              ).animate().fadeIn(delay: (60 * index).ms).slideX(begin: 0.1),
            );
          },
        ),
      ),
    );
  }
}

class _LessonTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _LessonTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 2,
      shadowColor: Colors.black12,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF667eea).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.play_arrow_rounded,
                    color: Color(0xFF667eea), size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}

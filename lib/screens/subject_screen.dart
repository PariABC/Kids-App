import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/tts_service.dart';
import '../services/speech_service.dart';
import '../widgets/voice_button.dart';

class LessonScreen extends StatefulWidget {
  final String subjectName;
  final String? className;

  const LessonScreen({
    super.key,
    this.subjectName = 'Lesson',
    this.className,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final TtsService _ttsService = TtsService();
  final SpeechService _speechService = SpeechService();

  @override
  void initState() {
    super.initState();
    _ttsService.init();
  }

  @override
  void dispose() {
    _ttsService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subjectName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.subjectName,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ).animate().fadeIn(duration: 400.ms).scale(),
            const SizedBox(height: 24),
            VoiceButton(
              onPressed: () => _ttsService.speak(widget.subjectName),
            ),
          ],
        ),
      ),
    );
  }
}

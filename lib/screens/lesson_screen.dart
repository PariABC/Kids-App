import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/tts_service.dart';
import '../services/speech_service.dart';
import '../widgets/voice_button.dart';

class LessonScreen extends StatefulWidget {
  final String lessonId;
  final String lessonTitle;
  final String subject;

  const LessonScreen({
    super.key,
    required this.lessonId,
    required this.lessonTitle,
    required this.subject,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final TtsService _tts = TtsService();
  final SpeechService _speech = SpeechService();

  String recognizedText = '';
  bool isListening = false;
  int currentStep = 0;

  // Example content (replace later with real ICSE content)
  final List<Map<String, String>> content = [
    {
      'text': 'A for Apple',
      'speak': 'A for Apple',
    },
    {
      'text': 'B for Ball',
      'speak': 'B for Ball',
    },
    {
      'text': 'C for Cat',
      'speak': 'C for Cat',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tts.init();
    _speech.init();
  }

  @override
  void dispose() {
    _tts.stop();
    _speech.stop();
    super.dispose();
  }

  void _speakCurrent() {
    _tts.speak(content[currentStep]['speak']!);
  }

  void _next() {
    if (currentStep < content.length - 1) {
      setState(() {
        currentStep++;
        recognizedText = '';
      });
      _speakCurrent();
    }
  }

  void _previous() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
        recognizedText = '';
      });
      _speakCurrent();
    }
  }

  Future<void> _startListening() async {
    setState(() => isListening = true);
    await _speech.startListening((text) {
      setState(() {
        recognizedText = text;
        isListening = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final current = content[currentStep];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lessonTitle),
        backgroundColor: const Color(0xFF667eea),
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFFF8F9FF),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Big animated letter / content
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF667eea).withOpacity(0.2),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  current['text']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF667eea),
                  ),
                ),
              ),
            ).animate().scale(duration: 400.ms).fadeIn(),

            const SizedBox(height: 30),

            // Speak button
            ElevatedButton.icon(
              onPressed: _speakCurrent,
              icon: const Icon(Icons.volume_up_rounded),
              label: const Text('Speak'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF667eea),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Voice recognition result
            if (recognizedText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'You said: $recognizedText',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),

            const Spacer(),

            // Voice Button
            VoiceButton(
              isListening: isListening,
              onPressed: _startListening,
            ),

            const SizedBox(height: 20),

            // Navigation buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: currentStep > 0 ? _previous : null,
                    child: const Text('Previous'),
                  ),
                  Text('${currentStep + 1} / ${content.length}'),
                  ElevatedButton(
                    onPressed: currentStep < content.length - 1 ? _next : null,
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class VoiceButton extends StatelessWidget {
  final bool isListening;
  final VoidCallback onPressed;

  const VoiceButton({
    super.key,
    required this.isListening,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isListening ? Colors.redAccent : const Color(0xFF667eea),
          boxShadow: [
            BoxShadow(
              color: (isListening ? Colors.redAccent : const Color(0xFF667eea))
                  .withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          isListening ? Icons.mic : Icons.mic_none_rounded,
          color: Colors.white,
          size: 36,
        ),
      )
          .animate(target: isListening ? 1 : 0)
          .scale(begin: const Offset(1, 1), end: const Offset(1.15, 1.15))
          .then()
          .scale(begin: const Offset(1.15, 1.15), end: const Offset(1, 1)),
    );
  }
}

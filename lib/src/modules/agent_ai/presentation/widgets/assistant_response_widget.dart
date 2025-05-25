import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class AssistantResponseWidget extends StatefulWidget {
  final String message;
  final bool isTypingEffect;
  final bool isUser;
  const AssistantResponseWidget({
    super.key,
    required this.message,
    required this.isTypingEffect,
    required this.isUser,
  });

  @override
  State<AssistantResponseWidget> createState() =>
      _AssistantResponseWidgetState();
}

class _AssistantResponseWidgetState extends State<AssistantResponseWidget>
    with SingleTickerProviderStateMixin {
  // final aiController = injector.get<AgentAiController>();
  String displayedText = "";
  int currentIndex = 0;
  Ticker? _ticker;

  @override
  void initState() {
    super.initState();
    if (widget.isTypingEffect) {
      _startTypingEffect();
    } else {
      displayedText = widget.message;
    }
  }

  @override
  void didUpdateWidget(covariant AssistantResponseWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.message != widget.message ||
        oldWidget.isTypingEffect != widget.isTypingEffect) {
      _ticker?.stop();
      displayedText = "";
      currentIndex = 0;

      if (widget.isTypingEffect) {
        _startTypingEffect();
      } else {
        setState(() {
          displayedText = widget.message;
        });
      }
    }
  }

  void _startTypingEffect() {
    final characters = widget.message.runes.toList();

    _ticker = createTicker((_) {
      if (currentIndex < characters.length) {
        setState(() {
          displayedText += String.fromCharCode(characters[currentIndex]);
          currentIndex++;
          // aiController.scrollToBottom();
        });
      } else {
        _ticker?.stop();
      }
    });

    _ticker?.start();
  }

  @override
  void dispose() {
    _ticker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(12),
          topRight: const Radius.circular(12),
          bottomLeft:
              widget.isUser
                  ? const Radius.circular(12)
                  : const Radius.circular(0),
          bottomRight:
              widget.isUser
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
        ),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child:
          widget.isTypingEffect
              ? Text(
                displayedText,
                style: Theme.of(context).textTheme.bodyMedium,
              )
              : Text(
                widget.message,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
    );
  }
}

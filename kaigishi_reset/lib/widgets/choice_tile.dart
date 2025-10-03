import "package:flutter/material.dart";

class ChoiceTile extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool locked;
  final VoidCallback? onTap;

  const ChoiceTile({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.locked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Color? bg;
    Color? border;
    IconData? icon;
    Color? iconColor;

    if (locked) {
      if (isSelected && isCorrect) {
        bg = cs.primaryContainer;
        border = cs.primary;
        icon = Icons.check_circle;
        iconColor = cs.primary;
      } else if (isSelected && !isCorrect) {
        bg = Colors.red.withOpacity(.08);
        border = Colors.red.withOpacity(.40);
        icon = Icons.cancel;
        iconColor = Colors.red;
      } else if (isCorrect) {
        bg = cs.primaryContainer.withOpacity(.55);
        border = cs.primary.withOpacity(.55);
        icon = Icons.check_circle_outline;
        iconColor = cs.primary;
      }
    } else {
      if (isSelected) {
        bg = cs.primaryContainer.withOpacity(.5);
        border = cs.primary.withOpacity(.6);
      }
    }

    return InkWell(
      onTap: locked ? null : onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: bg ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border ?? Colors.black12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 22, color: iconColor),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16, height: 1.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

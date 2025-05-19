import 'package:flutter/material.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  List<Widget>? actions,
  required VoidCallback? onPressedConfirm,
  double? width,
  double height = 100,
}) {
  return showAdaptiveDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog.adaptive(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(title),
        titleTextStyle: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        content: SizedBox(
          width: width ?? MediaQuery.sizeOf(context).width,
          height: height,
          child: content,
        ),
        actions:
            actions ??
            [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  if (onPressedConfirm != null) onPressedConfirm();
                  Navigator.of(context).pop();
                },
                child: const Text('Confirmar'),
              ),
            ],
      );
    },
  );
}

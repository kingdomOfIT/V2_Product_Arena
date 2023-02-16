import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final Color borderColor;
  final VoidCallback onPressed;
  final double buttonWidth;
  final double buttonHeight;
  const FormButton({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
    required this.borderColor,
    required this.onPressed,
    required this.buttonWidth,
    required this.buttonHeight,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: borderColor, width: 2.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (text == 'Back') ...[
              const Icon(Icons.arrow_back_ios_new_outlined),
            ],
            Text(
              text,
              style: TextStyle(color: textColor),
            )
          ],
        ),
      ),
    );
  }
}

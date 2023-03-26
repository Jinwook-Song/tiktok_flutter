import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:tiktok_flutter/utils.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    Key? key,
    required this.isValid,
    this.text = 'Next',
  }) : super(key: key);

  final bool isValid;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
        decoration: BoxDecoration(
            color: isValid
                ? Theme.of(context).primaryColor
                : isDarkMode(context)
                    ? Colors.grey.shade800
                    : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(Sizes.size5)),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
              color: isValid ? Colors.white : Colors.black38,
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

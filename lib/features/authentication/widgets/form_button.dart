import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    Key? key,
    required this.isValid,
  }) : super(key: key);

  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
        decoration: BoxDecoration(
            color:
                isValid ? Theme.of(context).primaryColor : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(Sizes.size5)),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
              color: isValid ? Colors.white : Colors.black38,
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16),
          child: const Text(
            'Next',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

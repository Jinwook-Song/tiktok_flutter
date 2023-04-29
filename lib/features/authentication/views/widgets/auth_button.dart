import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:tiktok_flutter/features/authentication/view_models/social_auth_vm.dart';
import 'package:tiktok_flutter/features/authentication/views/login_form_screen.dart';
import 'package:tiktok_flutter/features/authentication/views/username_screen.dart';

enum Destination { emailLogin, githubLogin, emailSignup, githubSignup }

class AuthButton extends ConsumerWidget {
  final String text;
  final FaIcon icon;
  final Destination destination;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.destination,
  });

  void handleTap(BuildContext context, WidgetRef ref) {
    switch (destination) {
      case Destination.emailSignup:
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const UserNameScreen(),
            ),
          );
        }
        break;
      case Destination.emailLogin:
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginFormScreen(),
            ),
          );
        }
        break;
      case Destination.githubSignup:
      case Destination.githubLogin:
        {
          ref.read(socialAuthProvider.notifier).githubSignIn(context);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => handleTap(context, ref),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          padding: const EdgeInsets.all(
            Sizes.size14,
          ),
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.grey.shade300,
            width: Sizes.size1,
          )),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: icon,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

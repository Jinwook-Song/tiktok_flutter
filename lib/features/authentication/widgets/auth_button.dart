import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:tiktok_flutter/features/authentication/login_form_screen.dart';
import 'package:go_router/go_router.dart';

enum Destination { emailLogin, appleLogin, emailSignup, appleSignup }

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;
  final Destination destination;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.destination,
  });

  void handleTap(BuildContext context) {
    switch (destination) {
      case Destination.emailSignup:
        {
          // Navigator.of(context).push(
          //   PageRouteBuilder(
          //     transitionDuration: const Duration(milliseconds: 300),
          //     reverseTransitionDuration: const Duration(milliseconds: 300),
          //     pageBuilder: (context, animation, secondaryAnimation) =>
          //         const UserNameScreen(),
          //     transitionsBuilder:
          //         (context, animation, secondaryAnimation, child) {
          //       final offsetAnimation = Tween(
          //         begin: const Offset(1, -1),
          //         end: Offset.zero,
          //       ).animate(animation);
          //       final opacityAnimation = Tween(
          //         begin: 0.2,
          //         end: 1.0,
          //       ).animate(animation);
          //       return SlideTransition(
          //         position: offsetAnimation,
          //         child: FadeTransition(
          //           opacity: opacityAnimation,
          //           child: child,
          //         ),
          //       );
          //     },
          //   ),
          // );
          context.push('/users/jw');
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
      case Destination.appleSignup:
        {}
        break;
      case Destination.appleLogin:
        {}
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handleTap(context),
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

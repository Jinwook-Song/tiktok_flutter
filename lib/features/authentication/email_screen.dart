import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = '';
  bool isValid = false;

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
      isValid = _username.length >= 2 ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign up',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              'Create username',
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v10,
            const Text(
              'You can always change this later.',
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v40,
            TextField(
              controller: _usernameController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: const InputDecoration(
                hintText: 'Username',
                hintStyle: TextStyle(
                  color: Colors.black26,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black12,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black12,
                  ),
                ),
              ),
            ),
            Gaps.v32,
            FractionallySizedBox(
              widthFactor: 1,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
                decoration: BoxDecoration(
                    color: isValid
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(Sizes.size5)),
                child: Text(
                  'Next',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: isValid ? Colors.white : Colors.black38,
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.size16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

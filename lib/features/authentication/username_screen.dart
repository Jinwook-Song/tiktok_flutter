import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:tiktok_flutter/features/authentication/email_screen.dart';
import 'package:tiktok_flutter/features/authentication/widgets/form_button.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({super.key});

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = '';
  bool isValid = false;

  @override
  void initState() {
    // begin(init)
    super.initState();

    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
      isValid = _username.length >= 2 ? true : false;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    // end(clean up)
    super.dispose();
  }

  // stateful이기 때문에 context를 어디서든 사용할 수 있다
  void _onNextTap() {
    if (!isValid) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EmailScreen(
          username: _username,
        ),
      ),
    );
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
              ),
            ),
            Gaps.v40,
            TextField(
              controller: _usernameController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                hintText: 'Username',
                hintStyle: const TextStyle(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
            Gaps.v32,
            GestureDetector(
              onTap: _onNextTap,
              child: FormButton(
                isValid: isValid,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:tiktok_flutter/features/authentication/widgets/form_button.dart';
import 'package:tiktok_flutter/features/onboarding/interests_screen.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  DateTime today = DateTime.now();

  @override
  void initState() {
    // begin(init)
    super.initState();

    _setTextFeildDate(today);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    // end(clean up)
    super.dispose();
  }

  // stateful이기 때문에 context를 어디서든 사용할 수 있다
  void _onNextTap() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const InterestsScreen(),
      ),
      (route) => false,
    );
  }

  void _setTextFeildDate(DateTime date) {
    final textDate = date.toString().split(' ').first;
    _birthdayController.value = TextEditingValue(text: textDate);
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
              'When is your birthday?',
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v10,
            const Text(
              'Your birthday won\'t be shown publicly.',
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v40,
            TextField(
              controller: _birthdayController,
              cursorColor: Theme.of(context).primaryColor,
              enabled: false,
              decoration: const InputDecoration(
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
            GestureDetector(
              onTap: _onNextTap,
              child: const FormButton(
                isValid: true,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: SizedBox(
        height: 300,
        child: CupertinoDatePicker(
          maximumDate: today,
          initialDateTime: today,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: _setTextFeildDate,
        ),
      )),
    );
  }
}

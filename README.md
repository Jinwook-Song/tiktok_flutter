# Tiktok with Flutter

| 프로젝트 기간 | 23.01.14 ~                                     |
| ------------- | ---------------------------------------------- |
| 프로젝트 목적 | tiktock clone with flutter                     |
| Github        | https://github.com/Jinwook-Song/tiktok_flutter |
| homepage      |                                                |
| version       | 3.3.10                                         |

---

### SafeArea

status bar 아래부터 ui가 나오도록

### BottomAppBar

### FractionallySizedBox

_widthFactor_

부모 사이즈에 반응

---

### Auth button

```dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
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
    );
  }
}
```

### TextField

```dart
TextField(
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
```

### TextEditingController

변화를 감지할 수 있음

```dart
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
```

### AnimatedContainer

```dart
AnimatedContainer(
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
```

### AnimatedDefaultTextStyle

```dart
AnimatedDefaultTextStyle(
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
```

### Dispose

```dart
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
```

### Email screen

- email validation (RegExp)
- keyboard type
- error text
- onEditingComplete

```dart
import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:tiktok_flutter/features/authentication/password_screen.dart';
import 'package:tiktok_flutter/features/authentication/widgets/form_button.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();

  String _email = '';
  bool isValid = false;

  @override
  void initState() {
    // begin(init)
    super.initState();

    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
      isValid = (_email.length >= 2 && _isEmailValid() == null) ? true : false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    // end(clean up)
    super.dispose();
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;

    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!regExp.hasMatch(_email)) {
      return 'Email not valid.';
    }

    return null;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_email.isEmpty || _isEmailValid() != null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
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
                'What is your email?',
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v40,
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                onEditingComplete: _onSubmit,
                autocorrect: false,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  hintText: 'Email',
                  errorText: _isEmailValid(),
                  hintStyle: const TextStyle(
                    color: Colors.black26,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
              Gaps.v32,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                  isValid: isValid,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
```

### Form

key를 통해 form을 제어할 수 있다

\_formKey.currentState?.validate() → validator 실행

\_formKey.currentState!.save() → onSaved 실행

```dart
import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:tiktok_flutter/features/authentication/widgets/form_button.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  void _onSubmitTap() {
    // trigger validation
    bool? validated = _formKey.currentState?.validate();
    if (validated == true) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gaps.v28,
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (value) {
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['email'] = newValue;
                    }
                  },
                ),
                Gaps.v16,
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Password'),
                  validator: (value) {
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['password'] = newValue;
                    }
                  },
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onSubmitTap,
                  child: const FormButton(
                    isValid: true,
                    text: 'Log in',
                  ),
                )
              ],
            )),
      ),
    );
  }
}
```

### ScrollController

```dart
final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
```

### Swipe

DefaultTabController

TabBarView → controller를 필요로함

TabPageSelector → indicator(tap의 현 위치를 보여줌)

```dart
import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Gaps.v52,
                    Text(
                      'Watch cool videos!',
                      style: TextStyle(
                        fontSize: Sizes.size36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v16,
                    Text(
                      'Videos are personalized for you based on what you watch, like, and share.',
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Gaps.v52,
                    Text(
                      'Follow the rules!',
                      style: TextStyle(
                        fontSize: Sizes.size36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v16,
                    Text(
                      'Videos are personalized for you based on what you watch, like, and share.',
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Gaps.v52,
                    Text(
                      'Enjoy the ride!',
                      style: TextStyle(
                        fontSize: Sizes.size36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v16,
                    Text(
                      'Videos are personalized for you based on what you watch, like, and share.',
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size48,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TabPageSelector(
                selectedColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
```

### Swipe2

AnimatedCrossFade

onPanUpdate
onPanEnd

```dart
import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.left;
  Page _page = Page.first;

  void _onPanUpdate(DragUpdateDetails dragDetails) {
    if (dragDetails.delta.dx > 0) {
      // swipe right
      if (_direction == Direction.right) return;
      _direction = Direction.right;
    } else {
      if (_direction == Direction.left) return;
      // swipe left
      _direction = Direction.left;
    }
  }

  void _onPanEnd(DragEndDetails dragDetails) {
    if (_direction == Direction.left) {
      setState(() {
        _page = Page.second;
      });
    } else {
      setState(() {
        _page = Page.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: SafeArea(
            child: AnimatedCrossFade(
              firstChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Gaps.v80,
                    Text(
                      'Watch cool videos!',
                      style: TextStyle(
                        fontSize: Sizes.size36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v16,
                    Text(
                      'Videos are personalized for you based on what you watch, like, and share.',
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ]),
              secondChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Gaps.v80,
                    Text(
                      'Follow the rules',
                      style: TextStyle(
                        fontSize: Sizes.size36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v16,
                    Text(
                      'Take care of one another',
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ]),
              crossFadeState: _page == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
            ),
          ),
        ),
      ),
    );
  }
}
```

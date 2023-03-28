# Tiktok with flutter

| 프로젝트 기간 | 23.01.14 ~                                     |
| ------------- | ---------------------------------------------- |
| 프로젝트 목적 | tiktock clone with flutter                     |
| Github        | https://github.com/Jinwook-Song/tiktok_flutter |
| version       | 3.3.10                                         |
| docs(design)  | https://m3.material.io/                        |

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

### CupertinoButton

```dart
AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _page == Page.first ? 0 : 1,
                child: CupertinoButton(
                  onPressed: () {},
                  color: Theme.of(context).primaryColor,
                  child: const Text('Enter the app!'),
                ),
              )),
```

### pushAndRemoveUntil

push는 이전 widget이 stack 되고있다. 따라서 유저는 뒤로가기가 가능하며 이를 방지하기 위해

stack된 route를 제거할 수 있다.

false → remove

true → doesn’t remove

```dart
Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const InterestsScreen(),
        ),
        (route) => false,
      );
```

## Navigation Bar

- Builtin

  - material 2

    ### BottomNavigationBar

    item은 필수이며 2개이상을 필요로 한다
    currentIndex와 onTap method를 통해 변환할 수 있다.

    ```dart
    import 'package:flutter/material.dart';
    import 'package:font_awesome_flutter/font_awesome_flutter.dart';

    class MainNavigationScreen extends StatefulWidget {
      const MainNavigationScreen({super.key});

      @override
      State<MainNavigationScreen> createState() => _MainNavigationScreenState();
    }

    class _MainNavigationScreenState extends State<MainNavigationScreen> {
      int _selectedIndex = 0;

      void _onTap(int index) {
        setState(() {
          _selectedIndex = index;
        });
      }

      final screens = [
        const Center(
          child: Text('Home'),
        ),
        const Center(
          child: Text('Search'),
        )
      ];

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: screens[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              onTap: _onTap,
              currentIndex: _selectedIndex,
              selectedItemColor: Theme.of(context).primaryColor,
              items: const [
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.house),
                    label: 'Home',
                    tooltip: 'Hint',
                    backgroundColor: Colors.orange),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
                    label: 'Search',
                    backgroundColor: Colors.amber),
              ]),
        );
      }
    }
    ```

  - material 3
    ### NavigationBar(material design 3)
    ```dart
    bottomNavigationBar: NavigationBar(
                backgroundColor: Theme.of(context).primaryColor,
                labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
                selectedIndex: _selectedIndex,
                onDestinationSelected: _onTap,
                destinations: const [
                  NavigationDestination(
                      icon: FaIcon(
                        FontAwesomeIcons.house,
                        color: Colors.white,
                      ),
                      selectedIcon: FaIcon(
                        FontAwesomeIcons.house,
                        color: Colors.black,
                      ),
                      label: 'Home'),
                  NavigationDestination(
                      icon: FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.white,
                      ),
                      selectedIcon: FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.black,
                      ),
                      label: 'Search'),
                ]));
    ```
  - cupertino
    ### CupertinoTabScaffold
    ```dart
    return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.house,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.search,
                ),
                label: 'Search'),
          ]),
          tabBuilder: (context, index) => screens[index],
        );
    ```

- Custom
  Nav tab widget

  ```dart
  import 'package:flutter/material.dart';
  import 'package:font_awesome_flutter/font_awesome_flutter.dart';
  import 'package:tiktok_flutter/constants/gaps.dart';

  class NavTab extends StatelessWidget {
    const NavTab({
      Key? key,
      required this.text,
      required this.isSelected,
      required this.icon,
      required this.onTab,
    }) : super(key: key);

    final String text;
    final bool isSelected;
    final IconData icon;
    final Function onTab;

    @override
    Widget build(BuildContext context) {
      return Expanded(
        child: GestureDetector(
          onTap: () => onTab(),
          child: Container(
            color: Colors.black,
            child: AnimatedOpacity(
              opacity: isSelected ? 1 : 0.6,
              duration: const Duration(milliseconds: 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    icon,
                    color: Colors.white,
                  ),
                  Gaps.v5,
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
  ```

### Offstage (Creates a widget that visually hides its child.)

default: build되지만 보이지는 않음

유저가 다른 화면을 보고 오더라도 이전의 상태를 그대로 보존할 수있음

```dart
body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: screens[_selectedIndex],
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: screens[_selectedIndex],
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: screens[_selectedIndex],
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: screens[_selectedIndex],
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: screens[_selectedIndex],
          ),
        ],
      ),
```

### Infinite Scroll

PageView를 통해 infinite scroll 구현

```dart
import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;

  List<Color> colors = [
    Colors.amber,
    Colors.teal,
    Colors.purple,
    Colors.pink,
  ];

  void _onPageChanged(int page) {
    if (page == _itemCount - 1) {
      _itemCount += 4;
      colors = [...colors, ...colors];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged,
      itemCount: _itemCount,
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text(
            'Screen $index',
            style: const TextStyle(
              fontSize: Sizes.size60,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
```

### PageController

page 이동시에 anmation 효과 설정

```dart
final PageController _pageController = PageController();

  int _itemCount = 4;

  List<Color> colors = [
    Colors.amber,
    Colors.teal,
    Colors.purple,
    Colors.pink,
  ];

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 30),
      curve: Curves.fastOutSlowIn,
    );
    if (page == _itemCount - 1) {
      _itemCount += 4;
      colors = [...colors, ...colors];
      setState(() {});
    }
  }
```

### Assets

pubspec.yaml

```yaml
# To add assets to your application, add an assets section, like this:
assets:
  - assets/videos/
```

### Video Player

`flutter pub add video_player` version (^2.5.1)

### Video Post Widget

```dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final videoIndex;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.videoIndex,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  late VideoPlayerController _videoPlayerController;

  void _onVideoChanged() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.asset(
        'assets/videos/yeonjae_0${widget.videoIndex % 6 + 1}.MP4');
    await _videoPlayerController.initialize();
    _videoPlayerController.play();
    setState(() {});

    _videoPlayerController.addListener(_onVideoChanged);
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _videoPlayerController.value.isInitialized
              ? VideoPlayer(_videoPlayerController)
              : Container(
                  color: Colors.black,
                ),
        ),
      ],
    );
  }
}
```

### Visibility detector & IgnorePointer

`flutter pub add visibility_detector`

화면이 완전히 넘어간 후 비디오를 재생하기 위해

visibleFraction: 0~1의 값을 가지며 전체 화면이 보이는 경우가 1

IgnorePointer는 Icon의 tap이벤트를 무시

```dart
void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  void _onTogglePlay() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('${widget.videoIndex}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
              child: GestureDetector(
            onTap: _onTogglePlay,
          )),
          const Positioned.fill(
              child: IgnorePointer(
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.circlePlay,
                size: Sizes.size52,
                color: Colors.white,
              ),
            ),
          )),
        ],
      ),
    );
  }
}
```

### Animation controller

```dart
class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin

@override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
      lowerBound: 1,
      upperBound: 1.5,
      value: 1.5, // start point
    );
    _animationController.addListener(
      () => {setState(() {})}, // call build method
    );
  }

void _onTogglePlay() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse(); // upper to lower
      isPaused = true;
    } else {
      _videoPlayerController.play();
      _animationController.forward(); // lower to upper
      isPaused = false;
    }
  }

child: Transform.scale(
              scale: _animationController.value,
              child: AnimatedOpacity(
                opacity: isPaused ? 1 : 0,
                duration: _animationDuration,
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.play,
                    size: Sizes.size52,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
```

### AnimatedBuilder

animation value의 변화를 감지하여 builder 실행

```dart
child: AnimatedBuilder(
              // animation value를 감지하여 build 실행
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animationController.value,
                  child: child, // AnimatedOpacity
                );
              },
              child: AnimatedOpacity(
                opacity: isPaused ? 1 : 0,
                duration: _animationDuration,
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.play,
                    size: Sizes.size52,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
```

### SingleTickerProviderStateMixin

Provides a single [Ticker](https://api.flutter.dev/flutter/scheduler/Ticker-class.html) that is configured to only tick while the current tree is enabled, as defined by [TickerMode](https://api.flutter.dev/flutter/widgets/TickerMode-class.html).

Ticker: Calls its callback once per animation frame

### RefreshIndicator

새로고침

```dart
Future<void> _onRefresh() {
    // Api call
    return Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );
  }

return RefreshIndicator(
      onRefresh: _onRefresh,
      displacement: Sizes.size52,
      edgeOffset: Sizes.size20,
      color: Theme.of(context).primaryColor,
      child: child
    );
```

### showModalBottomSheet

flutter 내장 함수

```dart
void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePlay();
    }
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const VideoComments(),
    );
    // when modal closed.
    _onTogglePlay();
  }
```

### ListView.separated

ListView Builder의 item들의 간격을 설정할 수 있다.

### TextField

textfield는 크기를 지정하거나, expanded 위젯을 사용하여야 한다.

키보드가 나올경우, flutter는 body의 크기를 조정하기 때문에 화면이 찌그러지는 현상이 발생할 수 있다.

이를 방지 하기위해 _`resizeToAvoidBottomInset`_ 설정을 false로 변경

추가로 bottom navigation bar는 keyboard가 활성화되면 기본적으로 사라지기 때문에 input text를 navigation bar에서 사용하는것은 적합하지 않다.

→ Stack과 Positioned 위젯의 조합을 통해 원하는 결과를 얻을 수 있다.

또한 모달의 사이즈를 조절하기 위해

showModalBottomSheet의 _isScrollControlled 옵션을 true로 설정하고, Container 크기를 조정한다._

```dart
@override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.7,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size14,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text('22796 comments'),
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: Stack(
          children: [
            ListView.separated(
              separatorBuilder: (context, index) => Gaps.v10,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
                vertical: Sizes.size10,
              ),
              itemCount: 10,
              itemBuilder: (context, index) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: Sizes.size16,
                    child: Text("JW"),
                  ),
                  Gaps.h10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'nico',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Sizes.size14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Gaps.v4,
                        const Text("That's not it I've seen the same thing")
                      ],
                    ),
                  ),
                  Gaps.h10,
                  Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.heart,
                        size: Sizes.size20,
                        color: Colors.grey.shade500,
                      ),
                      Gaps.v2,
                      Text(
                        '52.2K',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              width: screenSize.width,
              child: BottomAppBar(
                color: Colors.white,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: Sizes.size16,
                      backgroundColor: Colors.grey.shade500,
                      foregroundColor: Colors.white,
                      child: const Text('JW'),
                    ),
                    Gaps.h10,
                    const Expanded(
                      child: TextField(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### MediaQuery

screen size 및 다양한 정보를 얻을 수 있다.

### ScrollBar

ScrollbarController

### Tabbar

```dart
import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Discover'),
            elevation: 1,
            bottom: TabBar(
              splashFactory: NoSplash.splashFactory,
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
              isScrollable: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade500,
              tabs: [
                for (var tab in tabs)
                  Tab(
                    child: Text(tab),
                  ),
              ],
            )),
        body: TabBarView(children: [
          for (var tab in tabs)
            Center(
              child: Text(
                tab,
                style: const TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            )
        ]),
      ),
    );
  }
}
```

### GridView

```dart
GridView.builder(
            padding: const EdgeInsets.all(Sizes.size8),
            itemCount: 20,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 9 / 16,
              crossAxisSpacing: Sizes.size8,
              mainAxisSpacing: Sizes.size8,
            ),
            itemBuilder: (context, index) => Container(
              color: Colors.teal,
              child: Center(
                child: Text('${index + 1}'),
              ),
            ),
          ),
```

### Image + AspectRatio

```dart
itemBuilder: (context, index) => AspectRatio(
              aspectRatio: 9 / 16,
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholderFit: BoxFit.cover,
                placeholder: 'assets/images/placeholder.jpeg',
                image: 'https://source.unsplash.com/random/200x${355 + index}',
              ),
            ),
```

### DefaultTextStyle

children의 style을 한번에 지정

override 가능

### ListTile

leading, title, subtitle, trailing

```dart
ListTile(
            leading: Container(
              width: Sizes.size52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.users,
                  size: Sizes.size20,
                  color: Colors.white,
                ),
              ),
            ),
            title: const Text(
              'New followers',
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: const Text(
              'Messages from followers will appear here',
              style: TextStyle(
                fontSize: Sizes.size12,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
```

### RichText

text에 각각 다른 style을 사용해야하는 경우

```dart
title: RichText(
              text: TextSpan(
                text: 'Account updates:',
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: Sizes.size16),
                children: [
                  const TextSpan(
                    text: ' Upload longer videos',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: ' 1h',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
```

### Dismissible

swipe 하여 없앨 수 있다.

onDismissed를 통해 어느 방향에서 제거됐는지 감지할 수 있고, 각각에 따른 기능을 구현할 수 있다

실제로 위젯 트리에서 제거되지 않았기 때문에 위젯을 업데이트 해야함

### RotationTransition

Animation<double>을 인자로 받는다.

한바퀴 값이 1

```dart
late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 150,
    ),
  );

  late final Animation<double> _animation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_animationController);

  void _onTitleTap() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

RotationTransition(
                turns: _animation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              ),
```

### SlideTransition

Animation<Offset>을 인자로 받는다

```dart
late final Animation<Offset> _pannelAnimation = Tween(
    begin: const Offset(0, -1), // dx, dy
    end: Offset.zero,
  ).animate(_animationController);
```

### AnimatedModalBarrier

```dart
late final Animation<Color?> _colorAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black26,
  ).animate(_animationController);

if (_showBarrier)
            AnimatedModalBarrier(
              color: _colorAnimation,
              dismissible: true,
              onDismiss: _toggleAnimations,
            ),
```

### AnimatedList

_itemBuilder_: (_context_, _index_, _animation_) {}

Animation<double> animation

```dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _items = [];

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(
        _items.length,
        duration: const Duration(
          milliseconds: 300,
        ),
      );
      _items.add(_items.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Direct messages'),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const FaIcon(
              FontAwesomeIcons.plus,
              size: Sizes.size20,
            ),
          ),
        ],
      ),
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: ListTile(
                key: UniqueKey(),
                leading: const CircleAvatar(
                  radius: Sizes.size32,
                  foregroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/78011042?v=4',
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'AntonioBM $index',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '2:16 PM',
                      style: TextStyle(
                        fontSize: Sizes.size12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                subtitle: const Text(
                  'Say hi to AntonioBM',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
```

### Delete AnimatedList

삭제할 때, 동일한 위젯을 return 하여 해당 위젯이 삭제되는 것처럼 보이도록 한다.

(makeTile 함수로 동일한 위젯을 사용)

```dart
void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
          index,
          (context, animation) => SizeTransition(
                sizeFactor: animation,
                child: Container(
                  color: Colors.grey.shade400,
                  child: _makeTile(index),
                ),
              ),
          duration: _duration);
      _items.removeAt(index);
    }
  }

  Widget _makeTile(int index) {
    return ListTile(
      key: UniqueKey(),
      onLongPress: () => _deleteItem(index),
      onTap: _onChatTap,
      leading: const CircleAvatar(
        radius: Sizes.size32,
        foregroundImage: NetworkImage(
          'https://avatars.githubusercontent.com/u/78011042?v=4',
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'AntonioBM $index',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '2:16 PM',
            style: TextStyle(
              fontSize: Sizes.size12,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
      subtitle: const Text(
        'Say hi to AntonioBM',
      ),
    );
  }
```

### CustomScrollView & SliverFixedExtentList

scroll이 가능한 위젯을 만들 수 있다

slivers는 List<Widget> 이지만, 모든 위젯이 가능한것은 아니다

```dart
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true, // 스크롤을 올리면 최상단이 아니더라도 appbar가 나타남
          snap: true, // 스크롤을 올리면 expandedHeight 영역이까지 모두 나타남
          stretch: true, // 최상단에서 스크롤을 올리면 appbar를 늘릴 수 있음
          pinned: true, // 스크롤을 내리더라도 collapseHeight는 유지함
          backgroundColor: Colors.orange,
          collapsedHeight: 80,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
              StretchMode.zoomBackground,
            ],
            title: const Text(
              'Hello',
              style: TextStyle(
                color: Colors.yellow,
              ),
            ),
            background: Image.asset(
              'assets/images/placeholder.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              alignment: Alignment.center,
              color: Colors.amber[100 * (index % 9)],
              child: Text(
                'Item $index',
              ),
            ),
          ),
          itemExtent: 100,
        ),
      ],
    );
  }
}
```

### SliverGrid

```dart
SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              alignment: Alignment.center,
              color: Colors.cyan[100 * (index % 9)],
              child: Text(
                'Item $index',
              ),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              mainAxisSpacing: Sizes.size20,
              crossAxisSpacing: Sizes.size20,
              childAspectRatio: 1),
        ),
```

### SliverPersistentHeader

```dart
SliverPersistentHeader(
          delegate: CustomDelegate(),
          pinned: true,
        ),

class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.pink,
      child: const FractionallySizedBox(
        heightFactor: 1,
        child: Center(
          child: Text(
            'subtitle',
            style: TextStyle(
              color: Colors.white,
              fontSize: Sizes.size16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 50;

  // maxExtent, minExtent 값을 변경하고 싶을 떄, true
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
```

### SliverToBoxAdapter

sliver안에서 random한 widget을 사용하고 싶은 경우

```dart
SliverToBoxAdapter(
          child: Column(
            children: const [
              CircleAvatar(
                backgroundColor: Colors.teal,
                radius: Sizes.size20,
              ),
            ],
          ),
        ),
```

### VerticalDivider (with SizedBox)

divider이며 height는 father widget의 높이이다

```dart
VerticalDivider(
                      width: Sizes.size32,
                      thickness: Sizes.size1,
                      indent: Sizes.size8,
                      endIndent: Sizes.size8,
                      color: Colors.grey.shade200,
                    ),
```

### Nested Scroll View

두개의 스크롤이 사용되는 경우

headerSliverBuilder

body

### ListWheelScrollView

```dart
body: ListWheelScrollView(
        diameterRatio: 1.5,
        offAxisFraction: -0.5,
        useMagnifier: true,
        magnification: 1.5,
        itemExtent: 200,
        children: [
          for (var _ in [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
            FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                color: Colors.cyan,
                alignment: Alignment.center,
                child: const Text(
                  'Options',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size20,
                  ),
                ),
              ),
            ),
        ],
      ),
```

### CircularProgressIndicator.adaptive()

사용자가 사용중이 플랫폼에 따라 ios, android 디자인

### showAboutDialog(), AboutListTile

```dart
body: ListView(
        children: [
          ListTile(
            onTap: () => showAboutDialog(
              context: context,
              applicationVersion: '0.1.0',
              applicationLegalese: 'All rights reserved',
            ),
            title: const Text(
              'About',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text('About this app...'),
          ),
          const AboutListTile()
        ],
      ),
```

### Date functions

- showDatePicker
- showTimePicker
- showDateRangePicker

```dart
onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1970),
                lastDate: DateTime(2030),
              );
              print(date);

              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              print(time);
              final booking = await showDateRangePicker(
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                      appBarTheme: const AppBarTheme(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black),
                    ),
                    child: child!,
                  );
                },
                context: context,
                firstDate: DateTime(1970),
                lastDate: DateTime(2030),
              );
              print(booking);
            },
```

### CheckboxListTile

```dart
bool _notifications = false;

  void _onNotificationsChanged(bool? value) {
    if (value == null) return;
    setState(() {
      _notifications = value;
    });
  }

CheckboxListTile(
            value: _notifications,
            onChanged: _onNotificationsChanged,
            activeColor: Colors.black,
            title: const Text('Enable notifications'),
          ),
```

### Switch, CupertinoSwitch, Switch.adaptive

```dart
Switch.adaptive(
            value: _notifications,
            onChanged: _onNotificationsChanged,
            activeColor: Colors.black,
          ),
          CupertinoSwitch(
            value: _notifications,
            onChanged: _onNotificationsChanged,
            activeColor: Colors.black,
          ),
          Switch(
            value: _notifications,
            onChanged: _onNotificationsChanged,
            activeColor: Colors.black,
          ),
```

### Dialog

ios design: CupertinoAlertDialog

android design: AlertDialog

```dart
ListTile(
            onTap: () => showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text(
                  'Are you sure to logout?',
                ),
                content: const Text('This action cannot be undone'),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'No',
                    ),
                  ),
                  CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(),
                    isDestructiveAction: true,
                    child: const Text(
                      'Yes',
                    ),
                  ),
                ],
              ),
            ),
            title: const Text(
              'Log out(iOS)',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          ListTile(
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text(
                  'Are you sure to logout?',
                ),
                content: const Text('This action cannot be undone'),
                actions: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const FaIcon(FontAwesomeIcons.xmark),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Yes',
                    ),
                  ),
                ],
              ),
            ),
            title: const Text(
              'Log out(Android)',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
```

### showCupertinoModalPopup

```dart
ListTile(
            onTap: () => showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                title: const Text(
                  'Are you sure to logout?',
                ),
                actions: [
                  CupertinoActionSheetAction(
                    isDefaultAction: true,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'No',
                    ),
                  ),
                  CupertinoActionSheetAction(
                    isDestructiveAction: true,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Yes',
                    ),
                  ),
                ],
              ),
            ),
            title: const Text(
              'Log out(iOS / Bottom)',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
```

## Responsive Design

가로모드, 세로모드, 화면 크기, Dark mode 등에 대해서는 처음부터 고려해야한다.

```dart
class BreakPoints {
  static const sm = 640;
  static const md = 768;
  static const lg = 1024;
  static const xl = 1280;
  static const xxl = 1536;
}
```

Collection if(for)는 하나의 대상에만 동작하기 때문에 여러 대상에 적용하기 위해서는
List + destruction을 이용한다. `…[itemA, itemB, itemC]`

### OrientationBuilder

_if_ (_orientation_ == Orientation.portrait) → 세로 모드

_if_ (_orientation_ == Orientation.landscape) → 가로 모드

앱 시작전에 state를 바꾸고 싶다면

engine 그리고 engine과 widget 의 연결을 초기화 해야한다

```dart
void main() async {
  // App 실행전에 초기화하고 binding 해야한다
  WidgetsFlutterBinding.ensureInitialized();

  // 세로 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

// 앱의 최상단에서 할 필요는 없고, 각 Screen마다 따로 설정할 수 있다
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );

  runApp(const TikTokApp());
}
```

### kIsWeb

web인경우, 초기설정을 mute

대부분의 브라우저에서는 음성이 있는 영상을 자동재생 할 수 없다. (광고나 큰 소리로 악용될 여지가 있기 때문에)

### MediaQuery

처음 한번 값을 가져오는 것이 아닌 창 크기가 변하는것을 감지할 수 있다

```dart
*final* width = MediaQuery.of(*context*).size.width;

crossAxisCount: width < BreakPoints.sm
                  ? 2
                  : width < BreakPoints.md
                      ? 3
                      : width < BreakPoints.lg
                          ? 4
                          : 5,
```

### LayoutBuilder

context, constraints

constraints.maxWidth: Container가 가질 수 있는 최대 너비 ↔ 화면 크기와는 구분된다

```dart
class LayoutBuilderCodeLab extends StatelessWidget {
  const LayoutBuilderCodeLab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width / 2,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              color: Colors.teal,
              child: Center(
                child: Text(
                  '${size.width} ${constraints.maxWidth}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

### ConstrainedBox

constraints: maxWidth, maxHeight, minWidth, minHeight 등을 지정할 수 있다.

Container에도 constraints 속성이 있다

```dart
ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: BreakPoints.sm,
              ),
```

### Dark Mode

light, dark에 따라 각각 color를 설정할 수 있다.

이상적으로는 모든 컬러 정보를 theme에 setting 해두는것이 좋다

```dart
themeMode: ThemeMode.system,
theme: ThemeData()
darkTheme: ThemeData()
```

하지만 특정 화면이나 위젯에 대해서 컬러를 설정하게 되는 경우(hard coding) 사용중인 mode에 따라 컬러를 설정해 줄 수 있다.

```dart

bool isDarkMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}
```

### TextTheme

`flutter pub add google_fonts` version 4.0.1

docs

- [m2](https://m2.material.io/design/typography/the-type-system.html#type-scale)
- [m3](https://m3.material.io/styles/typography/overview)

copyWith를 통해 특정 theme 속성에 추가할 수 있다. (color, fontWeigth 등)

```dart
textTheme: TextTheme(
          headline1: GoogleFonts.openSans(
              fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          headline2: GoogleFonts.openSans(
              fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          headline3:
              GoogleFonts.openSans(fontSize: 48, fontWeight: FontWeight.w400),
          headline4: GoogleFonts.openSans(
              fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          headline5:
              GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w400),
          headline6: GoogleFonts.openSans(
              fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          subtitle1: GoogleFonts.openSans(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
          subtitle2: GoogleFonts.openSans(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyText1: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          bodyText2: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          button: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
          caption: GoogleFonts.roboto(
              fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          overline: GoogleFonts.roboto(
              fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        ),

style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
```

### Google Fonts

[https://fonts.google.com/](https://fonts.google.com/)

대부분의 유명한 font들은 GoogleFonts에서 지원한다

```dart
textTheme: GoogleFonts.itimTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
```

### Typography

size, color, fontWeight 는 그대로 하고 오직 폰트값만 지정한다

```dart
textTheme: Typography.blackMountainView,
```

### Flex Color Scheme

`flutter pub add flex_color_scheme`

[docs](https://docs.flexcolorscheme.com/)

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // The Mandy red, light theme.
      theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
      // The Mandy red, dark theme.
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```

## i18n, l10n (internationalization, localization)

pubspec.yaml

```dart
flutter_localizations:
    sdk: flutter
  intl: any
```

main.dart

이미 텍스트가 포함된 위젯이 존재하기 때문에

```dart
localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
      ],
```

Current Locale

`Localizations.localeOf(*context*);`

### Localization.overide

```dart
Localizations.override(
      context: context,
      locale: const Locale('ko'),
)
```

### l10n.yaml

```dart
arb-dir: lib/intl # localizations 파일의 위치
template-arb-file: intl_en.arb # 마스터 파일
output-localization-file: intl_generated.dart # 생성될 파일
```

intl\_{ln}.arb 파일들은 같은 key를 사용해야 한다

`flutter gen-l10n` localization file 생성

.dart_tool > gen_l10n 폴더 하위에 파일 생성됨

```dart
localizationsDelegates: const [
        // Default Widget
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // Custom
        AppLocalizations.delegate
      ],
```

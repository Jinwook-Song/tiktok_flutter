import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:tiktok_flutter/utils.dart';

class ChatDetailScreen extends StatefulWidget {
  final String chatId;
  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _chatController = TextEditingController();
  String _message = '';
  bool _isWriting = false;

  @override
  void initState() {
    super.initState();

    _chatController.addListener(() {
      setState(() {
        _message = _chatController.text;
      });
    });
  }

  void _onStopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
          title: ListTile(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: Sizes.size10,
        leading: Stack(
          children: [
            const CircleAvatar(
              radius: Sizes.size20,
              foregroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/78011042?v=4',
              ),
            ),
            Positioned(
              bottom: -Sizes.size2,
              right: -Sizes.size2,
              child: Container(
                width: Sizes.size18,
                height: Sizes.size18,
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(
                    color: Colors.white,
                    width: Sizes.size3,
                  ),
                  borderRadius: BorderRadius.circular(Sizes.size24),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          "JW ${widget.chatId}",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: const Text('Active now'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            FaIcon(
              FontAwesomeIcons.flag,
              size: Sizes.size20,
            ),
            Gaps.h24,
            FaIcon(
              FontAwesomeIcons.ellipsis,
              size: Sizes.size20,
            ),
          ],
        ),
      )),
      body: GestureDetector(
        onTap: _onStopWriting,
        child: Stack(
          children: [
            ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size14,
                vertical: Sizes.size20,
              ),
              itemBuilder: (context, index) {
                final isMine = index % 2 == 0;
                return Row(
                  mainAxisAlignment:
                      isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(Sizes.size14),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(Sizes.size20),
                            topRight: const Radius.circular(Sizes.size20),
                            bottomLeft: isMine
                                ? const Radius.circular(Sizes.size20)
                                : const Radius.circular(Sizes.size3),
                            bottomRight: isMine
                                ? const Radius.circular(Sizes.size3)
                                : const Radius.circular(Sizes.size20),
                          ),
                          color: isMine
                              ? Colors.blue
                              : Theme.of(context).primaryColor),
                      child: Text(
                        'a message $index',
                        style: const TextStyle(
                          fontSize: Sizes.size18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: 10,
            ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: BottomAppBar(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size8,
                    vertical: Sizes.size8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: Sizes.size44,
                          child: TextField(
                            controller: _chatController,
                            onTap: _onStartWriting,
                            textInputAction: TextInputAction.newline,
                            expands: true,
                            minLines: null,
                            maxLines: null,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              hintText: 'Send a message...',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size12,
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(Sizes.size20),
                                  topRight: Radius.circular(Sizes.size20),
                                  bottomLeft: Radius.circular(Sizes.size20),
                                  bottomRight: Radius.circular(Sizes.size2),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: isDark
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade200,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  right: Sizes.size14,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.faceSmile,
                                      color: isDark
                                          ? Colors.grey.shade200
                                          : Colors.grey.shade900,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gaps.h10,
                      GestureDetector(
                        onTap: _onStopWriting,
                        child: Container(
                          width: Sizes.size44,
                          height: Sizes.size44,
                          decoration: BoxDecoration(
                            color: _message.isNotEmpty
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(Sizes.size20),
                          ),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.paperPlane,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

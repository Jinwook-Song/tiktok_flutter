import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:tiktok_flutter/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_flutter/features/inbox/view_models/message_vm.dart';
import 'package:tiktok_flutter/utils.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  final String chatId;
  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  ConsumerState<ChatDetailScreen> createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _chatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _chatController.addListener(() {
      setState(() {});
    });
  }

  void _onSendMeesage() {
    final text = _chatController.text;
    ref.read(messageProvider.notifier).sendMessage(text);
    _chatController.text = '';
    setState(() {});
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(messageProvider).isLoading;
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
      body: Stack(
        children: [
          ref.watch(chatProvider).when(
                data: (data) {
                  return ListView.separated(
                    itemCount: data.length,
                    reverse: true,
                    padding: EdgeInsets.only(
                      top: Sizes.size20,
                      bottom:
                          MediaQuery.of(context).padding.bottom + Sizes.size80,
                      left: Sizes.size14,
                      right: Sizes.size14,
                    ),
                    itemBuilder: (context, index) {
                      final uid = ref.read(authenticationRepository).user!.uid;
                      final isMine = data[index].uid == uid;
                      return Row(
                        mainAxisAlignment: isMine
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
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
                              data[index].text,
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
                  );
                },
                error: (error, stackTrace) => Center(
                  child: Text(error.toString()),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
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
                      onTap: isLoading ? null : _onSendMeesage,
                      child: Container(
                        width: Sizes.size44,
                        height: Sizes.size44,
                        decoration: BoxDecoration(
                          color: _chatController.text.isNotEmpty
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(Sizes.size20),
                        ),
                        child: Center(
                          child: FaIcon(
                            isLoading
                                ? FontAwesomeIcons.hourglass
                                : FontAwesomeIcons.paperPlane,
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
    );
  }
}

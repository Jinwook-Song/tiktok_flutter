import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:tiktok_flutter/features/inbox/chat_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final Duration _duration = const Duration(milliseconds: 300);

  final List<int> _items = [];

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(_items.length, duration: _duration);
      _items.add(_items.length);
    }
  }

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

  void _onChatTap() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ChatDetailScreen(),
    ));
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
              child: _makeTile(index),
            ),
          );
        },
      ),
    );
  }
}

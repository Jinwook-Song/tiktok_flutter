import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class Avatar extends ConsumerWidget {
  final String name;
  const Avatar({
    super.key,
    required this.name,
  });

  Future<void> _onAvatarTap() async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxWidth: 150,
      maxHeight: 150,
    );

    if (xfile != null) {
      final file = File(xfile.path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: _onAvatarTap,
      child: CircleAvatar(
        radius: Sizes.size52,
        foregroundColor: Colors.teal,
        foregroundImage: const NetworkImage(
          'https://avatars.githubusercontent.com/u/78011042?v=4',
        ),
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

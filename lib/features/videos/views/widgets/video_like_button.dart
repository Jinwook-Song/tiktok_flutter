import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/features/videos/view_models/video_post_vm.dart';
import 'package:tiktok_flutter/features/videos/views/widgets/video_button.dart';

class VideoLikedButton extends ConsumerWidget {
  final int likes;
  final String videoId;

  const VideoLikedButton({
    super.key,
    required this.likes,
    required this.videoId,
  });

  void _toggleVideoLike(WidgetRef ref) {
    ref.read(videoPostProvider(videoId).notifier).toggleVideoLike();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(videoPostProvider(videoId)).when(
          loading: () => VideoButton(
            icon: Icons.favorite,
            text: "$likes",
          ),
          error: (error, stackTrace) => const SizedBox(),
          data: (isLiked) {
            return GestureDetector(
              onTap: () => _toggleVideoLike(ref),
              child: VideoButton(
                icon: Icons.favorite,
                text: "$likes",
                accentColor: isLiked ? Theme.of(context).primaryColor : null,
              ),
            );
          },
        );
  }
}

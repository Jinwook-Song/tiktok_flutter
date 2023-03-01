import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  void _onClosePressed() {
    Navigator.of(context).pop();
  }

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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size16,
                    vertical: Sizes.size8,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: Sizes.size16,
                        backgroundColor: Colors.grey.shade500,
                        foregroundColor: Colors.white,
                        child: const Text('JW'),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: SizedBox(
                          height: Sizes.size44,
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                                hintText: 'Add comment...',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size12,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Sizes.size10,
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200),
                          ),
                        ),
                      ),
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

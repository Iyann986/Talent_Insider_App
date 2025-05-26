import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:talent_insider_app/core/assets/resource_path.dart';
import 'package:talent_insider_app/core/constants/color.dart';
import 'package:talent_insider_app/core/themes/style/textstyle.dart';
import 'package:talent_insider_app/view/audio_book/audio_book_screen.dart';

class AudioPlayerScreen extends StatelessWidget {
  final Book book;

  const AudioPlayerScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: SvgPicture.asset(
            ResourcePath.tombolBackDownSvg,
            // ignore: deprecated_member_use
            color: AppColors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          children: [
            Text(
              'PLAYING FROM SEARCH',
              style: TalentTextStyle.smMedium.copyWith(
                color: AppColors.white,
                fontSize: 14,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '"UX"',
                    style: TalentTextStyle.mdSemibold.copyWith(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: ' in ',
                    style: TalentTextStyle.mdSemibold.copyWith(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: 'Search',
                    style: TalentTextStyle.mdSemibold.copyWith(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            // Image Cover
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  book.image,
                  width: double.infinity,
                  height: 370,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 14),
            // Title & Author
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      book.title.length > 24
                          ? book.title.substring(0, 21) + '...'
                          : book.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // const Icon(Icons.headset, color: Colors.yellow, size: 28),
                  SvgPicture.asset(
                    ResourcePath.headsetSvg,
                    color: Colors.yellow,
                    height: 26,
                    width: 26,
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.play_arrow_rounded,
                    size: 28,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${book.author} · UI/UX Designer',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Tag & Date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.school_outlined,
                          color: Colors.white70,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Soft Skill',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Aug 4 · in English',
                    style: const TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Slider + Duration
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Slider(
                  value: 83,
                  min: 0,
                  max: 216,
                  onChanged: (val) {},
                  activeColor: Colors.white,
                  inactiveColor: Colors.white30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('1:23', style: TextStyle(color: Colors.white54)),
                      Text('3:36', style: TextStyle(color: Colors.white54)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Playback controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.share_outlined, color: Colors.white70),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.skip_previous, color: Colors.white),
                  onPressed: () {},
                  iconSize: 36,
                ),
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(
                      Icons.pause,
                      color: Colors.black,
                      size: 32,
                    ),
                    onPressed: () {},
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next, color: Colors.white),
                  onPressed: () {},
                  iconSize: 36,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.bookmark_border,
                    color: Colors.white70,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

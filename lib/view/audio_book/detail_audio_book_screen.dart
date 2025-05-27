import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:talent_insider_app/core/assets/resource_path.dart';
import 'package:talent_insider_app/core/constants/color.dart';
import 'package:talent_insider_app/core/themes/style/textstyle.dart';
import 'package:talent_insider_app/models/audio_model/audio_model.dart';

class DetailAudioScreen extends StatefulWidget {
  final AudioModel book;

  const DetailAudioScreen({super.key, required this.book});

  @override
  State<DetailAudioScreen> createState() => _DetailAudioScreenState();
}

class _DetailAudioScreenState extends State<DetailAudioScreen> {
  final AudioPlayer _player = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      if (widget.book.path.isNotEmpty) {
        final url = widget.book.path.first.url;
        await _player.setUrl(url);

        _player.durationStream.listen((d) {
          if (d != null) {
            setState(() => _duration = d);
          }
        });

        _player.positionStream.listen((p) {
          setState(() => _position = p);
        });

        _player.play();
        setState(() => _isPlaying = true);
      }
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String formatTime(Duration duration) {
    return duration.toString().split('.').first.padLeft(4, "0");
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final String date = DateFormat('MMM d').format(book.createdAt);
    final String language = book.languange;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: SvgPicture.asset(
            ResourcePath.tombolBackDownSvg,
            color: AppColors.white,
          ),
          onPressed: () => Navigator.pop(context),
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
            Text(
              book.title,
              style: TalentTextStyle.mdSemibold.copyWith(
                color: AppColors.white,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    book.thumbnail.isNotEmpty ? book.thumbnail.first.url : '',
                    width: double.infinity,
                    height: 370,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey,
                      height: 370,
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        book.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      ResourcePath.headsetSvg,
                      color: Colors.yellow,
                      height: 26,
                      width: 26,
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.play_arrow_rounded,
                      size: 28,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${book.artist} · ${book.path.first.fileName}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(6),
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
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '$date · in $language',
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              ),
              Slider(
                value: _position.inSeconds.toDouble().clamp(
                  0.0,
                  _duration.inSeconds.toDouble(),
                ),
                max: _duration.inSeconds.toDouble(),
                onChanged: (val) async {
                  await _player.seek(Duration(seconds: val.toInt()));
                },
                activeColor: Colors.white,
                inactiveColor: Colors.white30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatTime(_position),
                      style: const TextStyle(color: Colors.white54),
                    ),
                    Text(
                      formatTime(_duration),
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.share_outlined,
                      color: Colors.white70,
                    ),
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
                      icon: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.black,
                        size: 32,
                      ),
                      onPressed: () async {
                        if (_isPlaying) {
                          await _player.pause();
                        } else {
                          await _player.play();
                        }
                        setState(() => _isPlaying = !_isPlaying);
                      },
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
      ),
    );
  }
}

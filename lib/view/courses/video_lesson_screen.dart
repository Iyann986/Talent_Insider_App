import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:talent_insider_app/core/assets/resource_path.dart';
import 'package:talent_insider_app/core/constants/color.dart';
import 'package:talent_insider_app/models/video_model/video_model.dart';
import 'package:talent_insider_app/view_model/video_lesson_view_model/video_lesson_view_model.dart';
import 'package:video_player/video_player.dart';

class VideoLessonScreen extends StatefulWidget {
  final String lessonId;

  const VideoLessonScreen({super.key, required this.lessonId});

  @override
  State<VideoLessonScreen> createState() => _VideoLessonScreenState();
}

class _VideoLessonScreenState extends State<VideoLessonScreen> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<VideoLessonViewModel>(
        context,
        listen: false,
      ).fetchVideoLessons([widget.lessonId]);
    });
  }

  void _initializePlayer(String videoUrl) {
    _videoPlayerController = VideoPlayerController.network(videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: false,
      looping: false,
      allowFullScreen: true,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.redAccent,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
    );

    _videoPlayerController!.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Consumer<VideoLessonViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.state == VideoLessonViewState.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.state == VideoLessonViewState.error) {
              return Center(
                child: Text(
                  viewModel.errorMessage ?? "Terjadi kesalahan",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (viewModel.videoLessons.isEmpty ||
                viewModel.videoLessons.first.path.isEmpty) {
              return const Center(
                child: Text(
                  "Video tidak tersedia",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final VideoLessonModel lesson = viewModel.videoLessons.first;
            final String videoUrl = lesson.path.first.url;

            if (_videoPlayerController == null ||
                _videoPlayerController!.dataSource != videoUrl) {
              _initializePlayer(videoUrl);
            }

            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 250,
                      color: Colors.black,
                      width: double.infinity,
                      child:
                          _videoPlayerController?.value.isInitialized ?? false
                          ? Chewie(controller: _chewieController!)
                          : const Center(child: CircularProgressIndicator()),
                    ),
                    Positioned(
                      top: 40,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.black45,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            ResourcePath.tombolBackDownSvg,
                            color: AppColors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lesson 2",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Get Started with ChatGPT",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Created by Diego Davila",
                            style: TextStyle(color: Colors.white),
                          ),
                          Row(
                            children: [
                              Text('🌎', style: TextStyle(fontSize: 16)),
                              SizedBox(width: 4),
                              Text(
                                "in English",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        leading: Image.asset(
                          'assets/images/thumbnail.png',
                          width: 60,
                        ),
                        title: Text(
                          "Welcome to 23 Ways of Earning Money with AI",
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          "Lesson 1",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Text(
                          "02:30",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading: Container(
                          width: 60,
                          color: Colors.green,
                          child: Icon(
                            Icons.picture_as_pdf,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          "The ChatGPT Prompts Guide",
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          "PDF",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Text(
                          "15:00",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading: Image.asset(
                          'assets/images/thumbnail.png',
                          width: 60,
                        ),
                        title: Text(
                          "Get Started with ChatGPT",
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          "Lesson 2",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Text(
                          "02:30",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios, color: Colors.white),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Chapter 1 : Introduction to t...",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.red),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

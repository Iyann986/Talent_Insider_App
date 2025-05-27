import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:talent_insider_app/core/assets/resource_path.dart';
import 'package:talent_insider_app/core/constants/app_label.dart';
import 'package:talent_insider_app/core/constants/color.dart';
import 'package:talent_insider_app/core/themes/style/textstyle.dart';
import 'package:talent_insider_app/view/audio_book/detail_audio_book_screen.dart';
import 'package:talent_insider_app/view_model/audio_book_view_model/audio_book_view_model.dart';

class AudioBookScreen extends StatefulWidget {
  const AudioBookScreen({super.key});

  @override
  State<AudioBookScreen> createState() => _AudioBookScreenState();
}

class _AudioBookScreenState extends State<AudioBookScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      Provider.of<AudioBookViewModel>(context, listen: false).fetchAudioBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.black,
        title: Text(
          AppLabel.audioBookAppBar,
          style: TalentTextStyle.msMedium.copyWith(
            color: AppColors.white,
            fontSize: 19,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            ResourcePath.tombolBackSvg,
            height: 18,
            width: 18,
            // ignore: deprecated_member_use
            color: AppColors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu, color: AppColors.white, size: 24),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 14, top: 16),
          child: Column(
            children: [
              TextFormField(
                autofocus: false,
                style: TalentTextStyle.smRegular.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: AppColors.grey),
                  suffixIcon: const Icon(Icons.tune, color: AppColors.grey),
                  contentPadding: const EdgeInsets.fromLTRB(10, 15, 20, 15),
                  hintText: 'Search Keywords',
                  hintStyle: const TextStyle(color: Colors.white60),
                  filled: true,
                  fillColor: AppColors.blackDark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Best-Sellers',
                  style: TalentTextStyle.msMedium.copyWith(
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 260,
                child: Consumer<AudioBookViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.state == AudioBookViewState.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (viewModel.state == AudioBookViewState.error) {
                      return Center(
                        child: Text(
                          viewModel.errorMessage ?? 'Error',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (viewModel.audioBooks.isEmpty) {
                      return const Center(
                        child: Text(
                          'No audio books available',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      final bestSellerBooks = viewModel.audioBooks;

                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: bestSellerBooks.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final book = bestSellerBooks[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailAudioScreen(book: book),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: 140,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      book.thumbnail.first.url,
                                      width: 140,
                                      height: 210,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    book.title,
                                    style: TalentTextStyle.msMedium.copyWith(
                                      color: AppColors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    book.artist,
                                    style: TalentTextStyle.smRegular.copyWith(
                                      color: AppColors.white,
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'More Books',
                  style: TalentTextStyle.msMedium.copyWith(
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: moreBooks.length,
                  separatorBuilder: (context, index) =>
                      const Divider(color: Colors.white24, height: 1),
                  itemBuilder: (context, index) {
                    final book = moreBooks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              book.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title,
                                  style: TalentTextStyle.msMedium.copyWith(
                                    color: AppColors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                Text(
                                  'by ${book.author}',
                                  style: TalentTextStyle.smRegular.copyWith(
                                    color: AppColors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${book.chapters} Chapters',
                                  style: TalentTextStyle.smRegular.copyWith(
                                    color: AppColors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            children: [
                              Icon(
                                Icons.bookmark_border,
                                color: AppColors.white,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ResourcePath.headsetSvg,
                                    height: 16,
                                    width: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${book.duration} min',
                                    style: TalentTextStyle.smRegular.copyWith(
                                      color: AppColors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Book {
  final String image;
  final String title;
  final String author;

  Book({required this.image, required this.title, required this.author});
}

final List<Book> bestSellerBooks = [
  Book(
    image: 'assets/images/audio1.png',
    title: 'The Power of Habit',
    author: 'Kev Freeman',
  ),
  Book(
    image: 'assets/images/audio2.png',
    title: '5 Types of Psychological Manipulation',
    author: 'Meg Mason',
  ),
  Book(
    image: 'assets/images/audio1.png',
    title: 'The Swallow',
    author: 'Lisa Lutz',
  ),
];

class MoreBook {
  final String image;
  final String title;
  final String author;
  final int chapters;
  final int duration;

  MoreBook({
    required this.image,
    required this.title,
    required this.author,
    required this.chapters,
    required this.duration,
  });
}

final List<MoreBook> moreBooks = [
  MoreBook(
    image: 'assets/images/book1.png',
    title: 'Good to Great',
    author: 'Deena Roberts',
    chapters: 16,
    duration: 45,
  ),
  MoreBook(
    image: 'assets/images/book2.png',
    title: 'The Ninth Life',
    author: 'Taylor B. Barton',
    chapters: 16,
    duration: 45,
  ),
  MoreBook(
    image: 'assets/images/book1.png',
    title: 'Nobody Knows But You',
    author: 'Anica Mrose Rissi',
    chapters: 16,
    duration: 45,
  ),
];

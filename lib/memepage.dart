import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MemeScreen extends StatefulWidget {
  final String name;

  const MemeScreen({super.key, required this.name});

  @override
  State<MemeScreen> createState() => _MemeScreenState();
}

class _MemeScreenState extends State<MemeScreen> {
  List<String> memeUrls = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchMeme();
  }

  Future<void> fetchMeme() async {
    const apiUrl = 'https://meme-api.com/gimme/5';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final parsedData = jsonDecode(response.body);
        memeUrls =
            List<String>.from(parsedData['memes'].map((meme) => meme['url']));
        setState(() {});
      } else {
        print('Failed to fetch memes: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching memes: $error');
    }
  }

  void _onSwipeLeft() {
    if (currentIndex < memeUrls.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      fetchMeme();
      setState(() {
        currentIndex = 0;
      });
    }
  }

  void _refreshMemes() {
    fetchMeme();
    setState(() {
      currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meme Carousel'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.indigo],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello, ${widget.name}! \nswipe left for more memes',
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                  } else if (details.primaryVelocity! < 0) {
                    _onSwipeLeft();
                  }
                },
                child: PageView.builder(
                  itemCount: memeUrls.length,
                  controller: PageController(initialPage: currentIndex),
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          memeUrls[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _refreshMemes,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 24),
              ),
              child: const Text('Refresh Memes'),
            ),
          ],
        ),
      ),
    );
  }
}

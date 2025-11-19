// football_news/lib/screens/news_entry_list.dart

import 'package:flutter/material.dart';
import 'package:football_news/models/news_entry.dart';
import 'package:football_news/screens/news_detail.dart';
import 'package:football_news/widgets/left_drawer.dart';
import 'package:football_news/widgets/news_entry_card.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class NewsEntryListPage extends StatefulWidget {
  const NewsEntryListPage({super.key});

  @override
  State<NewsEntryListPage> createState() => _NewsEntryListPageState();
}

class _NewsEntryListPageState extends State<NewsEntryListPage> {
  // Fungsi untuk mengambil data News dari backend Django
  Future<List<NewsEntry>> fetchNews() async {
    final request = context.read<CookieRequest>();
    
    // Ganti URL ini dengan URL Django kamu:
    // Jika menggunakan Android emulator, ganti 127.0.0.1 menjadi 10.0.2.2
    final response = await request.get('http://127.0.0.1:8000/json/');

    // Periksa status respons, jika berhasil (biasanya status 200), proses data
    if (response.isNotEmpty) {
      // Decode data JSON (yang sudah berupa List<Map>) menjadi List<NewsEntry>
      // Kita asumsikan response sudah berupa list, jika tidak, gunakan newsEntryFromJson(jsonEncode(response))
      final List<NewsEntry> listNews = (response as List).map((data) {
        // Karena response dari pbp_django_auth sudah berupa decoded JSON,
        // kita langsung petakan ke model NewsEntry.fromJson
        return NewsEntry.fromJson(data);
      }).toList();
      return listNews;
    } else {
      // Jika respons kosong atau error, kembalikan list kosong
      return <NewsEntry>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football News List'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchNews(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No news entries found.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            );
          } 
          
          // Jika data tersedia, tampilkan dalam ListView
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) {
              NewsEntry news = snapshot.data![index];
              return NewsEntryCard(
                news: news,
                onTap: () {
                  // Navigasi ke halaman detail saat item diklik
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailPage(news: news),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
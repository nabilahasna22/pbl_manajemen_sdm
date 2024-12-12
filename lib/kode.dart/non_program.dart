import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kegiatan Non Program',
      home: KegiatanPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class KegiatanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text(
          "Kegiatan Non Program",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ActivityCard(
              title: "Akreditasi D4 SIB ",
              points: 5,
              status: "Approve",
              details: [
                "Anggota (2 Pts)",
                "Jurusan (2 Pts)",
                "< 7 Hari (2 Pts)"
              ],
              statusColor: Colors.green,
              pointsColor: const Color.fromARGB(255, 122, 147, 40),
              imageUrl: 'assets/kegiatan.png', // Replace with your image URL
              onTap: () {
                // Navigasi ke halaman detail ketika diklik
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailKegiatanPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Set to default selected tab
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.amber),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.grey),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights, color: Colors.grey),
            label: 'Insight',
          ),
        ],
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String title;
  final int points;
  final String status;
  final List<String> details;
  final Color statusColor;
  final Color pointsColor;
  final String imageUrl;
  final VoidCallback onTap;

  ActivityCard({
    required this.title,
    required this.points,
    required this.status,
    required this.details,
    required this.statusColor,
    required this.pointsColor,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Navigasi saat kartu diklik
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.yellow[100],
        child: Row(
          children: [
            // Image on the left
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            // Text content on the right
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        // Row for status and points
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                status,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: pointsColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "$points Poin",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Details as Chips
                    Wrap(
                      spacing: 8,
                      children: details.map((detail) {
                        return Chip(
                          label: Text(detail,
                              style: TextStyle(color: Colors.black)),
                          backgroundColor: Colors.white,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailKegiatanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Kegiatan Non Program"),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'kegiatan.png',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            // Title and status
            Text(
              "Akreditasi D4 SIB",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("17 Juni 2025"),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("AA"),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("Approve", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Description
            Text(
              "Akreditasi D4 SIB adalah proses penilaian menyeluruh terhadap kualitas pendidikan, manajemen, dan fasilitas kampus oleh lembaga akreditasi untuk memastikan standar institusi dalam mendukung pembelajaran dan prestasi mahasiswa.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            // Pelaksana
            Text(
              "Pelaksana",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  label: Text("Mustofa"),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  label: Text("PIC"),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  label: Text("Andiman Budiman"),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  label: Text("Sekretaris Pelaksana"),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  label: Text("Setiana Setiani"),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  label: Text("Bendahara Pelaksana"),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  label: Text("Nabila Hasna"),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  label: Text("Anggota"),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

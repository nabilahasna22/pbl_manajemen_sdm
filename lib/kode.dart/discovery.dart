import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discovery Page',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: DiscoveryPage(),
    );
  }
}

class DiscoveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Discover",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Kegiatan pertama
            ActivityCard(
              title: "JPC",
              pic: "Budiarto (PIC)",
              kategori: "AA",
              durasi: "> 7 Hari",
              status: "Available",
              statusColor: Colors.green,
              imageUrl: 'assets/kegiatan.png',
            ),
            SizedBox(height: 16), // Spacer antar kartu

            // Kegiatan kedua
            ActivityCard(
              title: "JTIFunArtFest",
              pic: "Zahrawa (PIC)",
              kategori: "Jurusan Teknologi Informasi",
              durasi: "< 3 Hari",
              status: "Available",
              statusColor: Colors.green,
              imageUrl: 'assets/kegiatan.png',
            ),
            SizedBox(height: 16),

            // Kegiatan ketiga
            ActivityCard(
              title: "Kuliah Tamu",
              pic: "Wahyudiono (PIC)",
              kategori: "Prodi",
              durasi: "< 3 Hari",
              status: "Available",
              statusColor: Colors.green,
              imageUrl: 'assets/kegiatan.png',
            ),
            SizedBox(height: 16),

            // Kegiatan keempat
            ActivityCard(
              title: "Play IT!",
              pic: "Dika Rizky (PIC)",
              kategori: "Jurusan Teknologi Informasi",
              durasi: "> 7 Hari",
              status: "Unavailable",
              statusColor: Colors.grey,
              imageUrl: 'assets/kegiatan.png',
            ),
            SizedBox(height: 16),

            // Kegiatan kelima
            ActivityCard(
              title: "DDM",
              pic: "Faiz (PIC)",
              kategori: "Jurusan Teknologi Informasi",
              durasi: "< 3 Hari",
              status: "Unavailable",
              statusColor: Colors.grey,
              imageUrl: 'assets/kegiatan.png',
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String title;
  final String pic;
  final String kategori;
  final String durasi;
  final String status;
  final Color statusColor;
  final String imageUrl;

  const ActivityCard({
    Key? key,
    required this.title,
    required this.pic,
    required this.kategori,
    required this.durasi,
    required this.status,
    required this.statusColor,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Chip(label: Text(pic)),
                      SizedBox(width: 8),
                      Chip(label: Text(kategori)),
                      SizedBox(width: 8),
                      Chip(label: Text(durasi)),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

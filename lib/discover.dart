import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:pbl_manajemen_sdm/home_screen.dart';

final dio = Dio();
var all_data = [];

String url_domain = "http://192.168.1.11:8000/";
String url_all_data = url_domain + "api/all_data";

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({super.key});

  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  List<Map<String, dynamic>> allData = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    try {
      final response = await dio.post(url_all_data);

      // Print untuk debugging
      print("Response data: ${response.data}");

      // Asumsi respons API berisi objek JSON dengan kunci 'data' berupa list
      if (response.data is Map<String, dynamic> &&
          response.data['data'] != null) {
        setState(() {
          allData = List<Map<String, dynamic>>.from(response.data['data']);
        });
      } else if (response.data is List) {
        setState(() {
          allData = List<Map<String, dynamic>>.from(response.data);
        });
      } else {
        print("Unexpected response format");
      }
    } catch (e) {
      print("Failed to load data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        backgroundColor: Colors.blue[700],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false, // Menghapus semua route sebelumnya
            );
          },
        ),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search activities...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase();
              });
            },
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              for (var data in allData.where((item) =>
                  (item['kegiatan_nama'] ?? '')
                      .toLowerCase()
                      .contains(searchQuery) ||
                  (item['pic'] ?? '').toLowerCase().contains(searchQuery)))
                ActivityCard(
                  title: data['kegiatan_nama'] ?? 'N/A',
                  status: data['status'] ?? 'N/A',
                  points: data['points'] ?? '7', // Assuming points are provided
                  pic: data['pic'] ??
                      'Nabila', // Replace with actual PIC field if available
                  kategori: data['nama_kategori'] ??
                      'N/A', // Replace with actual kategori field if available
                  waktu:
                      "${data['tanggal_mulai'] ?? ''} - ${data['tanggal_selesai'] ?? ''}",
                ),
            ],
          ),
        ),
      ]),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String title;
  final String status;
  final String points;
  final String pic;
  final String kategori;
  final String waktu;

  const ActivityCard({
    required this.title,
    required this.status,
    required this.points,
    required this.pic,
    required this.kategori,
    required this.waktu,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: Colors.blue[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(label: Text('PIC: $pic (5 Pts)')),
                const SizedBox(height: 8),
                Chip(label: Text('Kategori: $kategori  (2 Pts)')),
                const SizedBox(height: 8),
                Chip(label: Text('Waktu: $waktu')),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    status,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: getStatusColor(status),
                ),
                Text(
                  '$points Pts',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'on progres':
      return Colors.blue;
    case 'terlaksana':
      return Colors.green;
    case 'ditunda':
      return Colors.orange;
    default:
      return Colors.grey;
  }
}

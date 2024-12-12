import 'package:flutter/material.dart';
import 'discover.dart';
import 'insight.dart'; // Import halaman Insight
import 'KegiatanTerprogramPage.dart';
import 'KegiatanNonProgramPage.dart';
import 'KegiatanNonJTIPage.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false, // Hide debug banner
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreenContent(), // Halaman home yang ada saat ini
    DiscoveryPage(), // Halaman Discover
    StatScreen(), // Menggunakan halaman Insight dari insight.dart
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.yellow[700],
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Insight',
          ),
        ],
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipPath(
              clipper: CurveClipper(),
              child: Container(
                color: Colors.yellow[700],
                height: 200,
              ),
            ),
            Positioned(
              left: 16.0,
              top: 60.0,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/profile.jpg'),
                    radius: 40,
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountInfoPage()),
                          );
                        },
                        child: Text(
                          'Nabila Hasna',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration:
                                TextDecoration.none, // Hilangkan garis bawah
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '987654321',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 16.0,
              top: 60.0,
              child: IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'Menu Kegiatan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.yellow[700],
          ),
        ),
        SizedBox(height: 16.0),
        Expanded(
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => KegiatanTerprogramPage()),
                  );
                },
                child: ActivityCard(
                  imageUrl: 'assets/terprogram.png',
                  title: 'Terprogram',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => KegiatanNonProgramPage()),
                  );
                },
                child: ActivityCard(
                  imageUrl: 'assets/terprogram.png',
                  title: 'Non Program',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => KegiatanNonJTIPage()),
                  );
                },
                child: ActivityCard(
                  imageUrl: 'assets/terprogram.png',
                  title: 'Non JTI',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AccountInfoPage extends StatefulWidget {
  @override
  _AccountInfoPageState createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  Map<String, dynamic> userData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      var response = await Dio().get('http://192.168.1.11:8000/api/user');
      if (response.statusCode == 200) {
        setState(() {
          userData = response.data;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: Text('Profil Pengguna'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60, // Ukuran avatar diperbesar dari 40 ke 60
                      backgroundColor: Colors.purple[100],
                      // Jika ada foto dari userData, tambahkan ini:
                      // backgroundImage: NetworkImage(userData['fotoUrl']),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildInfoRow('NIP', userData['NIP'] ?? '987654321'),
                  _buildInfoRow('Username', userData['username'] ?? 'Nabilahh'),
                  _buildInfoRow('Nama', userData['nama'] ?? 'Nabila Hasna'),
                  _buildInfoRow('Password', '*****'),
                  _buildInfoRow(
                      'Email', userData['email'] ?? 'nabila@gmail.com'),
                  _buildInfoRow(
                      'No Telp', userData['no_telp'] ?? '088227023906 	'),
                  _buildInfoRow('Alamat', userData['alamat'] ?? 'Malang'),
                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

/// Activity Detail Page for Skripsi
class ActivityDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Directly navigate to ProgramActivityPage without creating a new MaterialApp
    return Skripsi();
  }
}

class Skripsi extends StatelessWidget {
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
        title: Text('Detail Kegiatan'),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.amber),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  'assets/skripsisdm.png', // Replace with your image asset
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Skripsi',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  _DateButton('18 Mei 2025'),
                  SizedBox(width: 10),
                  _JurusanButton('Jurusan Teknologi Informasi'),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Pelaksanaan sidang skripsi melibatkan koordinasi berbagai '
                'aspek mulai dari penjadwalan hingga penyediaan fasilitas. '
                'Kegiatan ini mencakup penentuan jadwal yang sesuai bagi '
                'mahasiswa, dosen pembimbing, dan penguji, serta pengaturan '
                'kebutuhan teknis seperti ruang sidang, perangkat presentasi, '
                'dan dokumen administrasi. Selain itu, semua pihak yang '
                'terlibat harus mendapatkan informasi dan materi sidang '
                'dengan tepat waktu untuk memastikan proses berjalan lancar '
                'dan efisien.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Pelaksana',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.amber,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ParticipantButton('Nabila Hasna'),
                  SizedBox(width: 25),
                  _ParticipantButton('PIC'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _DateButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _JurusanButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _ParticipantButton(String name) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: Colors.amber),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        name,
        style: TextStyle(color: Colors.amber, fontSize: 16),
      ),
    );
  }
}

class SDMActivityDetailPage extends StatelessWidget {
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
        title: Text('Detail Kegiatan'),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.amber),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/skripsisdm.png', // Image for SDM activity
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "SDM Activity",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow[700]),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                _DateButton('20 Mei 2025'),
                SizedBox(width: 10),
                _JurusanButton('Jurusan Teknologi Informasi'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Kegiatan ini melibatkan pengelolaan sumber daya manusia yang efektif untuk mendukung pelaksanaan sidang skripsi. Hal ini mencakup pemilihan anggota tim, penugasan peran, dan pelatihan untuk memastikan semua pihak siap dan terkoordinasi dengan baik.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Pelaksana',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.amber,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ParticipantButton('Nabila Hasna'),
                SizedBox(width: 25),
                _ParticipantButton('PIC'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _DateButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _JurusanButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _ParticipantButton(String name) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: Colors.amber),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        name,
        style: TextStyle(color: Colors.amber, fontSize: 16),
      ),
    );
  }
}

// Updated ActivityDetailCard class to handle detailed activity information
class ActivityDetailCard extends StatelessWidget {
  final String title;
  final int points;
  final String status;
  final List<String> details;
  final String buttonText;
  final Color statusColor;
  final Color buttonColor;
  final String imageUrl;

  const ActivityDetailCard({
    required this.title,
    required this.points,
    required this.status,
    required this.details,
    required this.buttonText,
    required this.statusColor,
    required this.buttonColor,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.yellow[100],
      child: Row(
        children: [
          // Image on the left
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
            child: Image.asset(
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
                      // Row for status and points button
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
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                            ),
                            child: Text(
                              "$points Pts",
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
                        label:
                            Text(detail, style: TextStyle(color: Colors.black)),
                        backgroundColor: Colors.white,
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  // Edit Button
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                    ),
                    child: Text(buttonText),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const ActivityCard({
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.yellow.withOpacity(0.5),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// Non Program Activity Detail Page
class NonProgramActivityDetailPage extends StatelessWidget {
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
        title: Text('Detail Kegiatan Non Program'),
        backgroundColor: Colors.yellow,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/kegiatan.jpeg', // Replace with your image for Non Program activity
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Akreditasi D4 SIB",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow[700]),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                _DateButton('17 Juni 2025'),
                SizedBox(width: 10),
                _JurusanButton('Jurusan Teknologi Informasi'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Kegiatan akreditasi D4 SIB adalah proses penilaian menyeluruh terhadap kualitas pendidikan. Ini mencakup berbagai aspek untuk memastikan standar institusi dalam mendukung pembelajaran dan prestasi mahasiswa.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Pelaksana',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.amber,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ParticipantButton('Nabila Hasna'),
                SizedBox(width: 25),
                _ParticipantButton('PIC'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _DateButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _JurusanButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _ParticipantButton(String name) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: Colors.amber),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        name,
        style: TextStyle(color: Colors.amber, fontSize: 16),
      ),
    );
  }
}

// Non JTI Activity Detail Page
class NonJTIActivityDetailPage extends StatelessWidget {
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
        title: Text('Detail Kegiatan Non JTI'),
        backgroundColor: Colors.yellow,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/kegiatan.jpeg', // Replace with your image for Non JTI activity
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Akreditasi Institusi",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow[700]),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                _DateButton('20 Mei 2025'),
                SizedBox(width: 10),
                _JurusanButton('Jurusan Teknologi Informasi'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Kegiatan akreditasi institusi mencakup berbagai aspek penilaian untuk memastikan standar institusi dalam mendukung pembelajaran dan prestasi mahasiswa.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Pelaksana',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.amber,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ParticipantButton('Nabila Hasna'),
                SizedBox(width: 25),
                _ParticipantButton('PIC'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _DateButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _JurusanButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _ParticipantButton(String name) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: Colors.amber),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        name,
        style: TextStyle(color: Colors.amber, fontSize: 16),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

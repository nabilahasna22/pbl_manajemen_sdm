import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Widget utama aplikasi
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProgramActivityPage(),
    );
  }
}

class ProgramActivityPage extends StatefulWidget {
  @override
  _ProgramActivityPageState createState() => _ProgramActivityPageState();
}

class _ProgramActivityPageState extends State<ProgramActivityPage> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> _pengajuanAnggota = [
    {
      'dosen': 'Andiman Budiman',
      'posisi': 'Sekretaris Pelaksana',
      'status': 'pending', // 'pending', 'accepted', 'rejected'
    },
    {
      'dosen': 'Setiana Setiani',
      'posisi': 'Bendahara Pelaksana',
      'status': 'pending',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showAccConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text('Konfirmasi ACC'),
          content: Text('Apakah Anda yakin ingin menerima anggota ini?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _pengajuanAnggota[index]['status'] = 'rejected';
                });
                Navigator.of(context).pop();
              },
              child: Text('Tolak', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _pengajuanAnggota[index]['status'] = 'accepted';
                });
                Navigator.of(context).pop();
              },
              child: Text('Terima', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kegiatan Terprogram'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.amber,
        ),
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
                  'assets/skripsi.png',
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
                'Pengajuan Anggota',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.amber,
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: _pengajuanAnggota.map((pengajuan) {
                  int index = _pengajuanAnggota.indexOf(pengajuan);
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text('${pengajuan['dosen']} - ${pengajuan['posisi']}'),
                      trailing: pengajuan['status'] == 'accepted'
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : pengajuan['status'] == 'rejected'
                              ? Icon(Icons.cancel, color: Colors.red)
                              : ElevatedButton(
                                  onPressed: () {
                                    _showAccConfirmationDialog(index); // Tampilkan dialog konfirmasi
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'ACC',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: 'Insight',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        onTap: _onItemTapped,
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
}

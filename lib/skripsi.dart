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
  bool _isRequested = false; // Variabel untuk status pengajuan
  List<Map<String, String>> _anggotaList = []; // List untuk menyimpan data anggota baru

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showAddMemberDialog() {
    String? selectedDosen;
    String? selectedPosisi;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.all(16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Text(
                'Tambah Anggota',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pilih Dosen',
                ),
                items: ['Andiman Budiman', 'Setiana Setiani', 'Mustofa', 'Solikin', 'Solikan']
                    .map((String dosen) {
                  return DropdownMenuItem<String>(
                    value: dosen,
                    child: Text(dosen),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedDosen = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pilih Posisi',
                ),
                items: ['Sekretaris Pelaksana', 'Bendahara Pelaksana', 'Anggota']
                    .map((String posisi) {
                  return DropdownMenuItem<String>(
                    value: posisi,
                    child: Text(posisi),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedPosisi = value!;
                  });
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (selectedDosen != null && selectedPosisi != null) {
                    setState(() {
                      _anggotaList.add({
                        'dosen': selectedDosen!,
                        'posisi': selectedPosisi!,
                      });
                    });
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 231, 19),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(
                  'Tambahkan',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
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
                  SizedBox(width: 10),
                  _RequestActivityButton(),
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
              SizedBox(height: 20),
              Column(
                children: _anggotaList.map((member) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: _ParticipantButton('${member['dosen']} - ${member['posisi']}'),
                )).toList(),
              ),
              SizedBox(height: 20),
              _AddMemberButton(),
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

  Widget _RequestActivityButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: EdgeInsets.all(16),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Ajukan Kegiatan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Batal',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isRequested = true;
                          });
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Ajukan',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _isRequested ? Colors.grey : Colors.amber,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          _isRequested ? 'Request' : 'Ajukan Kegiatan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _ParticipantButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _AddMemberButton() {
    return ElevatedButton(
      onPressed: _showAddMemberDialog,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      ),
      child: Text(
        'Tambahkan Anggota',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

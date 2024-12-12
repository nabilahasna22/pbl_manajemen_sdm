import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discover and Statistics',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Helvetica', // Add a clean font style
      ),
      home: StatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Statistics Screen
class StatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Statistik',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.amber[700],
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              _buildScoreSection(),
              SizedBox(height: 30),
              _buildPieChartSection(),
              SizedBox(height: 30),
              _buildProgramSection(),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 2,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home, color: Colors.grey),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search, color: Colors.grey),
      //       label: 'Discover',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.bar_chart, color: Colors.amber[700]),
      //       label: 'Insight',
      //     ),
      //   ],
      // ),
    );
  }

  Widget _buildScoreSection() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Aligning content to center
      children: [
        Center(
          // Centering 'Skor Anda' text
          child: Text(
            'Skor Anda',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildScoreCard('13', 'Terprogram', Colors.amber[700]!),
            _buildScoreCard('8', 'Non Program', Colors.amber[300]!),
            _buildScoreCard('6', 'Non JTI', Colors.amber[100]!),
          ],
        ),
      ],
    );
  }

  Widget _buildScoreCard(String score, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              score,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildPieChartSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPieChartCard(
          'Kegiatan selesai',
          'Kegiatan belum selesai',
          Colors.amber[700]!,
          Colors.amber[100]!,
        ),
        _buildPieChartCard(
          'Terprogram',
          'Non Program',
          Colors.amber[700]!,
          Colors.amber[300]!,
          'Non JTI',
          Colors.amber[100]!,
        ),
      ],
    );
  }

  Widget _buildPieChartCard(
      String label1, String label2, Color color1, Color color2,
      [String? label3, Color? color3]) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.pie_chart,
              size: 60,
              color: Colors.amber[700],
            ),
          ),
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(width: 10, height: 10, color: color1),
                SizedBox(width: 5),
                Text(label1, style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Container(width: 10, height: 10, color: color2),
                SizedBox(width: 5),
                Text(label2, style: TextStyle(fontSize: 16)),
              ],
            ),
            if (label3 != null && color3 != null)
              Row(
                children: [
                  Container(width: 10, height: 10, color: color3),
                  SizedBox(width: 5),
                  Text(label3, style: TextStyle(fontSize: 16)),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgramSection() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Aligning content to center
      children: [
        Center(
          // Centering 'Jumlah Program' text
          child: Text(
            'Jumlah Program',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildScoreCard('2', 'Terprogram', Colors.amber[700]!),
            _buildScoreCard('1', 'Non Program', Colors.amber[300]!),
            _buildScoreCard('1', 'Non JTI', Colors.amber[100]!),
          ],
        ),
      ],
    );
  }
}

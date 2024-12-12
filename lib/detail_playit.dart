import 'package:flutter/material.dart';

class DetailPlayIt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kegiatan Terprogram'),
        backgroundColor: Colors.yellow[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Play IT!', style: Theme.of(context).textTheme.displayLarge),
            SizedBox(height: 8),
            Text('12 Juni 2025', style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 8),
            Text('AA', style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/coba.jpg'), // Replace with your image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Play IT! adalah kompetisi hackathon yang diselenggarakan untuk siswa SMA/SMK dan mahasiswa...',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 16),
            Text('Pelaksana:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(onPressed: () {}, child: Text('Dika Rizky')),
                SizedBox(width: 8),
                ElevatedButton(onPressed: () {}, child: Text('PIC')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
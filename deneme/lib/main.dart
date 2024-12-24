import 'package:flutter/material.dart';

void main() {
  runApp(const Directionality(
    textDirection: TextDirection.ltr,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Directionality widget'ı burada ekleniyor
      home: Directionality(
        textDirection: TextDirection.ltr, // Soldan sağa metin yönü için
        child: PlayStorePage(),
      ),
    );
  }
}

class PlayStorePage extends StatefulWidget {
  PlayStorePage({Key? key}) : super(key: key);

  @override
  State<PlayStorePage> createState() => _PlayStorePageState();
}

class _PlayStorePageState extends State<PlayStorePage> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Google Play',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.mic, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rosé Reklamı
            Container(
              width: double.infinity,
              height: 180, // Ekran görüntüsüne göre ayarlandı
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/rose_reklam.jpg'), // Rosé reklam görselinin yolu
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Celebrate ROSÉ\'s new album "rosie" on TikTok',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
                height: 16), // Reklam ile TikTok kartı arasına boşluk eklendi

            // TikTok Uygulaması
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Image.asset(
                    'assets/tiktok_icon.png', // TikTok ikonunun yolu
                    width: 64, // Ekran görüntüsüne göre ayarlandı
                    height: 64,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TikTok',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'TikTok Pte. Ltd.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '4.1',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            Spacer(), // Yıldızlar ile buton arasına boşluk eklemek için
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              child: Text('Install'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Sponsorlu Uygulamalar Başlığı
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Sponsored · Suggested for you',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Önerilen Uygulamalar (yatay kaydırılabilir liste)
            SizedBox(
              height:
                  180, // Kartların yüksekliği ekran görüntüsüne göre ayarlandı
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildAppCard(
                      'assets/brawl_stars_icon.png', 'Brawl Stars', 4.1),
                  _buildAppCard('assets/temu_icon.png',
                      'Temu: Shop Like a Billionaire', 4.5),
                  _buildAppCard('assets/sweet_bonanza_icon.png',
                      'Sweet Bonanza PrintShop', 4.2),
                ],
              ),
            ),

            // Alt Gezinme Çubuğu
            BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.gamepad),
                  label: 'Games',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Apps',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'Books',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.video_library),
                  label: 'V',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Uygulama kartlarını oluşturmak için yardımcı fonksiyon
  Widget _buildAppCard(String imagePath, String appName, double rating) {
    return Card(
      child: Container(
        width: 150,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(imagePath, height: 80), // Görselin yüksekliği ayarlandı
            SizedBox(height: 8),
            Text(
              appName,
              textAlign: TextAlign.center,
              maxLines: 2, // Uygulama adının 2 satırı geçmemesini sağlamak için
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$rating',
                  style: TextStyle(fontSize: 12),
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

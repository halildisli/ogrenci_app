import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/pages/mesajlar_sayfasi.dart';
import 'package:ogrenci_app/pages/ogrenciler_sayfasi.dart';
import 'package:ogrenci_app/pages/ogretmenler_sayfasi.dart';
import 'package:ogrenci_app/repository/mesajlar_repository.dart';
import 'package:ogrenci_app/repository/ogrenciler_repository.dart';
import 'package:ogrenci_app/repository/ogretmenler_repository.dart';

void main() {
  runApp(const ProviderScope(child: OgrenciApp()));
}

class OgrenciApp extends StatelessWidget {
  const OgrenciApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ogrenci Uygulaması',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AnaSayfa(title: 'Ogrenci Ana Sayfa'),
    );
  }
}

class AnaSayfa extends ConsumerWidget {
  const AnaSayfa({super.key, required this.title});

  final String title;



  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final ogrencilerRepository=ref.watch(ogrencilerProvider);
    final ogretmenlerRepository=ref.watch(ogretmenlerProvider);
    final yeniMesajSayisi=ref.watch(yeniMesajSayisiProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: Text("${yeniMesajSayisi} Yeni Mesaj"),
              onPressed: () {
                _mesajlaraGit(context);
              },
            ),
            TextButton(
              child: Text(
                  "${ogrencilerRepository.ogrenciler.length} Ogrenci"
              ),
              onPressed: () {
                _ogrencilereGit(context);
              },
            ),
            TextButton(
              child: Text(
                  "${ogretmenlerRepository.ogretmenler.length} Ogretmen"
              ),
              onPressed: () {
                _ogretmenlereGit(context);
              },
            ),
          ],
        ),
      ),

    );
  }
  void _ogrencilereGit(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return const OgrencilerSayfasi();
    },));
  }

  void _ogretmenlereGit(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return const OgretmenlerSayfasi();
    },));
  }

  Future<void> _mesajlaraGit(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return const MesajlarSayfasi();
    },));
  }
}



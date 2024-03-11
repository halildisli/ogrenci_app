import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/repository/ogrenciler_repository.dart';

class OgrencilerSayfasi extends ConsumerWidget {
  const OgrencilerSayfasi({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final ogrencilerRepository=ref.watch(ogrencilerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Ogrenciler"),),
      body: Column(
        children: [
           PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0,horizontal: 32.0),
                child: Text(
                  "${ogrencilerRepository.ogrenciler.length} Öğrenci"
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index)=>OgrenciSatiri(
                ogrencilerRepository.ogrenciler[index],
              ),
              separatorBuilder: (BuildContext context, int index) =>const Divider(),
              itemCount: ogrencilerRepository.ogrenciler.length,
            
            ),
          ),
        ],
      ),
    );
  }
}

class OgrenciSatiri extends ConsumerWidget {
  final Ogrenci ogrenci;
  const OgrenciSatiri(this.ogrenci, {
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    bool seviyorMuyum = ref.watch(ogrencilerProvider).seviyorMuyum(ogrenci);
    return ListTile(
      title: Text("${ogrenci.ad} ${ogrenci.soyad}"),
      leading:  IntrinsicWidth(child: Center(child: Text(ogrenci.cinsiyet.toLowerCase()=="erkek"?"👨":"👩"))),
      trailing: IconButton(
          onPressed: (){
              ref.read(ogrencilerProvider).sev(ogrenci,!seviyorMuyum);
          },
          icon: Icon(color: Colors.red,seviyorMuyum? Icons.favorite:Icons.favorite_border)),
    );
  }
}

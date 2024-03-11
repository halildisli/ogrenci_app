import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/repository/ogretmenler_repository.dart';

class OgretmenlerSayfasi extends ConsumerWidget {
  const OgretmenlerSayfasi({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final ogretmenlerRepository=ref.watch(ogretmenlerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Öğretmenler"),),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0,horizontal: 32.0),
                child: Text(
                    "${ogretmenlerRepository.ogretmenler.length} Öğretmen"
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index)=>OgretmenSatiri(
                ogretmenlerRepository.ogretmenler[index]

              ),
              separatorBuilder: (BuildContext context, int index) =>const Divider(),
              itemCount: ogretmenlerRepository.ogretmenler.length,

            ),
          ),
        ],
      ),
    );
  }
}
class OgretmenSatiri extends StatelessWidget {
  final Ogretmen ogretmen;
  const OgretmenSatiri(this.ogretmen,{
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${ogretmen.ad} ${ogretmen.soyad}"),
      leading: IntrinsicWidth(child: Center(child: Text(
          ogretmen.cinsiyet.toLowerCase() == "erkek" ? "👨" : "👩"))),
    );
  }
}
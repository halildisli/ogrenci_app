import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/repository/ogretmenler_repository.dart';

import '../models/ogretmen.dart';

class OgretmenlerSayfasi extends ConsumerWidget {
  const OgretmenlerSayfasi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ogretmenlerRepository = ref.watch(ogretmenlerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Öğretmenler"),
      ),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                    child: Text(
                        "${ogretmenlerRepository.ogretmenler.length} Öğretmen"),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: OgretmenIndirmeButonu(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) =>
                  OgretmenSatiri(ogretmenlerRepository.ogretmenler[index]),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: ogretmenlerRepository.ogretmenler.length,
            ),
          ),
        ],
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class OgretmenIndirmeButonu extends StatefulWidget {
  const OgretmenIndirmeButonu({
    super.key,
  });

  @override
  State<OgretmenIndirmeButonu> createState() => _OgretmenIndirmeButonuState();
}

class _OgretmenIndirmeButonuState extends State<OgretmenIndirmeButonu> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return isLoading
          ? CircularProgressIndicator()
          : IconButton(
              icon: const Icon(Icons.download),
              onPressed: () async {
                //TODO Loading
                //TODO Error
                try {
                  setState(() {
                    isLoading = true;
                  });
                  await ref.read(ogretmenlerProvider).indir();
                } catch(e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString()))
                  );
                  setState(() {
                    isLoading = false;
                  });
                }
                finally {
                setState(() {
                isLoading = false;
                });
                }
              },
            );
    });
  }
}

class OgretmenSatiri extends StatelessWidget {
  final Ogretmen ogretmen;
  const OgretmenSatiri(
    this.ogretmen, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${ogretmen.ad} ${ogretmen.soyad}"),
      leading: IntrinsicWidth(
          child: Center(
              child: Text(
                  ogretmen.cinsiyet.toLowerCase() == "erkek" ? "👨" : "👩"))),
    );
  }
}

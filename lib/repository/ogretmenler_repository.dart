import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/services/data_service.dart';

import '../models/ogretmen.dart';

class OgretmenlerRepository extends ChangeNotifier{

  List<Ogretmen> ogretmenler=[
    Ogretmen("Faruk", "Yılmaz", "18", "Erkek"),
    Ogretmen("Semiha", "Çelik", "28", "Kadın"),
  ];
  final DataService dataService;
  OgretmenlerRepository(this.dataService);

  Future<void> indir() async {
    Ogretmen ogretmen=await dataService.ogretmenIndir();


    ogretmenler.add(ogretmen);
    notifyListeners();
  }

}

final ogretmenlerProvider=ChangeNotifierProvider((ref) {
  return OgretmenlerRepository(ref.watch(dataServiceProvider));
});


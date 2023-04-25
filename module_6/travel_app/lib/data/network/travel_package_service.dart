import 'package:travel_app/data/model/detail_package.dart';

import '../model/package.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TravelPackageService {
  Future<List<Package>> getPackages() async {
    CollectionReference packages =
        FirebaseFirestore.instance.collection('packages');
    final result = await packages.get();
    List<Package> pkgs = [];

    for (var doc in result.docs) {
      final package = Package(
          id: doc.id,
          title: doc['title'],
          location: doc['location'],
          imgUrl: doc['main_img_url'],
          price: doc['price_per_pax'],
          tags: List<String>.from(doc['tags']));
      pkgs.add(package);
    }
    return pkgs;
  }

  Future<DetailPackage> getDetailPackage(String id) async {
    CollectionReference packages =
        FirebaseFirestore.instance.collection('packages');
    final result = await packages.doc(id).get();

    final detailPackage = DetailPackage(
        id: result.id,
        title: result['title'],
        description: result['description'],
        mealInfo: result['meal_info'],
        location: result['location'],
        imgUrls: List<String>.from(result['extra_img_url']),
        price: result['price_per_pax'],
        partnerName: result['partner_name'],
        rating: result['rating'],
        itineraries: result['itinerary']
            .map<Itinerary>((json) => Itinerary(
                title: json['title'], description: json['description']))
            .toList(),
        tags: List<String>.from(result['tags']));
    return detailPackage;
  }
}

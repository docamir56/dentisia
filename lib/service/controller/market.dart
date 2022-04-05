import 'package:dentisia/service/api.dart';
import 'package:dentisia/service/model/market_model.dart';

class MarketService {
  Stream<List<Market>> getMarketStream({required String jwt}) async* {
    yield* Stream.periodic(const Duration(seconds: 0), (_) async {
      final data = await API().get(
          url:
              'https://limitless-everglades-08570.herokuapp.com/api/v1/markets/',
          jwt: jwt);

      return data.map<Market>((json) => Market.fromJson(data: json)).toList();
    }).asyncMap((event) async => await event);
  }

  Future<List<Market>> getMarket({required String jwt}) async {
    List<dynamic> data = await API().get(
        url: 'https://limitless-everglades-08570.herokuapp.com/api/v1/markets/',
        jwt: jwt);

    List<Market> marketList = [];

    for (int i = 0; i < data.length; i++) {
      marketList.add(Market.fromJson(data: data[i]));
    }
    return marketList;
  }

  Future<dynamic> addMarket(
      {required String jwt,
      required String item,
      required String desc,
      required String price,
      required String stat,
      required String uid}) async {
    Map<String, dynamic> data = await API().post(
        url: 'https://limitless-everglades-08570.herokuapp.com/api/v1/markets/',
        body: {
          'item': item,
          'des': desc,
          'price': price,
          'stat': stat,
          'user': uid,
          'createdAt': DateTime.now(),
        },
        token: jwt);
    return data;
  }
}

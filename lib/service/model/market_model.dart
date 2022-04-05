class Market {
  String item;
  String desc;
  int price;
  String stat;
  String? photo;
  String userId;
  String time;
  String userName;
  String marketId;
  Market(
      {required this.item,
      required this.desc,
      required this.price,
      required this.stat,
      required this.photo,
      required this.marketId,
      required this.userId,
      required this.time,
      required this.userName});

  factory Market.fromJson({required Map<String, dynamic> data}) {
    return Market(
        desc: data['des'],
        userId: data['user'][0]['_id'],
        item: data['item'],
        photo: data['photo'],
        price: data['price'],
        stat: data['stat'],
        time: data['createdAt'],
        marketId: data['_id'],
        userName: data['user'][0]['name']);
  }
}

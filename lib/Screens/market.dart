import 'package:dentisia/Screens/create_market.dart';
import 'package:dentisia/Screens/photo_viewer.dart';
import 'package:dentisia/service/controller/market.dart';
import 'package:dentisia/service/model/market_model.dart';
import 'package:dentisia/shared/const.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:dentisia/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({Key? key}) : super(key: key);
  static const route = '/market';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: appBar('Shopping', center: false, action: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite, color: Colors.red))
          ]),
          floatingActionButton: CreateAlertDialog(
            onpress: () {
              Navigator.of(context).pushNamed(CreateItem.route);
            },
          ),
          body: _Stream()),
    );
  }
}

class _Stream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<Prov>(context, listen: false);
    return StreamBuilder<List<Market>>(
      stream: MarketService().getMarketStream(jwt: _prov.token!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text(
            snapshot.error.toString(),
            style: const TextStyle(color: Colors.red),
          ));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        } else if (snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
            'There is no items to share!',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red),
          ));
        } else if (snapshot.connectionState == ConnectionState.none) {
          return const Center(child: Text('there is no connection'));
        } else if (snapshot.connectionState == ConnectionState.active) {
          final data = snapshot.data;
          return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, i) {
                return MarketContainer(
                  desc: data[i].desc,
                  item: data[i].item,
                  itemPhoto: data[i].photo,
                  name: data[i].userName,
                  postId: data[i].marketId,
                  time: data[i]
                      .time
                      .substring(0, 16)
                      .replaceAll(RegExp(r'T'), '  -  '),
                  state: data[i].stat,
                  price: data[i].price.toString(),
                  uid: _prov.uid,
                  userId: data[i].userId,
                );
              });
        } else {
          return const Center(child: Text('there is something is wrong'));
        }
      },
    );
  }
}

class MarketContainer extends StatelessWidget {
  final String? item,
      uid,
      time,
      desc,
      state,
      userId,
      // photoUrl,
      postId,
      price,
      // phone,
      itemPhoto,
      name;

  const MarketContainer({
    Key? key,
    this.name,
    this.userId,
    this.postId,
    this.uid,
    this.time,
    this.item,
    this.desc,
    // this.photoUrl,
    this.state,
    // this.phone,
    this.price,
    this.itemPhoto,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
      ),
      child: Column(
        children: [
          Stack(children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      color: Theme.of(context).colorScheme.secondary,
                      elevation: 0,
                      child: itemPhoto == null
                          ? Image.asset(
                              'images/cart.png',
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        PhotoViewer(photourl: itemPhoto!)));
                              },
                              child: Image.network(
                                itemPhoto!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          item: 'By :',
                          data: name!,
                        ),
                        Text(
                          time!,
                        ),
                        const SizedBox(height: 10),
                        TextWidget(item: 'Item : ', data: item),
                        TextWidget(item: 'Description : ', data: desc),
                        TextWidget(item: 'State : ', data: state),
                        TextWidget(item: 'Price : ', data: price),
                      ],
                    ),

                    // TextWidget(item: 'What\'s App num : ', data: phone),
                  ],
                ),
              ),
            ),
            if (uid == userId)
              Positioned(
                top: 2,
                right: 3,
                child: IconButton(
                    icon: const Icon(
                      Icons.more_horiz,
                    ),
                    onPressed: () {
                      _showMenu(context, postId!);
                    }),
              ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // Navigator.pushNamed(context, Search.route);
                  },
                  icon: Icon(
                    Icons.maps_ugc_outlined,
                    color: Colors.green.shade900,
                  )),
              TextButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  )),
            ],
          )
        ],
      ),
    );
  }
}

void _showMenu(BuildContext context, String postId) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return TextButton(
            onPressed: () async {
              try {
                // await fireStore.collection('market').doc(postId).delete();
              } finally {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Delete'));
      });
}

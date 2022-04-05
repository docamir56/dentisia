import 'package:dentisia/service/controller/category.dart';
import 'package:dentisia/service/model/category.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:dentisia/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './quiz.dart';

class Categories extends StatelessWidget {
  static const route = '/categories';

  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<Prov>(context, listen: false);
    return SafeArea(
      child: Scaffold(
          appBar: appBar('Question Bank'),
          body: FutureBuilder<List<CategoryModel>>(
            future: CategoryService().getCategory(jwt: _prov.token!),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  snapshot.error.toString(),
                  style: const TextStyle(color: Colors.red),
                ));
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  ),
                );
              }
              if (snapshot.data!.isEmpty) {
                return const Center(
                    child: Text('There is no question bank here'));
              } else {
                final quizIcon = snapshot.data!;
                return GridView.builder(
                  itemCount: quizIcon.length,
                  itemBuilder: (context, index) {
                    return BuildIcon(
                      image: quizIcon[index].image,
                      name: quizIcon[index].title,
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 20),
                  padding: const EdgeInsets.all(20),
                );
              }
            },
          )),
    );
  }
}

class BuildIcon extends StatelessWidget {
  final String image;
  final String name;
  const BuildIcon({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            image,
            width: MediaQuery.of(context).size.aspectRatio * 140,
            height: MediaQuery.of(context).size.aspectRatio * 140,
            color: Colors.blue.shade900,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: MediaQuery.of(context).textScaleFactor * 20,
              fontFamily: 'Caveat-VariableFont_wght',
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(QuizPage.route, arguments: name);
      },
    );
  }
}

import 'package:dentisia/Screens/categories.dart';
import 'package:dentisia/Screens/news.dart';
import 'package:dentisia/Screens/patient.dart';
import 'package:dentisia/Screens/cases.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:dentisia/shared/widgets/border_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static const routeId = '/home';

  Home({Key? key}) : super(key: key);
  final List<Widget> _screen = [
    const Posts(),
    const PatientPage(),
    const Categories(),
    // const MarketPage(),
    const NewsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<Prov>(context);

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: 50,
          child: BottomNavigationBar(
            unselectedFontSize: 0,
            selectedFontSize: 0,
            currentIndex: _prov.selectedPage,
            elevation: 0,
            onTap: _prov.onTap,
            fixedColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                  icon: BorderBox(
                    child: Icon(Icons.home,
                        color: _prov.selectedPage == 0
                            ? Colors.blue.shade900
                            : Colors.grey),
                  ),
                  label: 'home'),
              BottomNavigationBarItem(
                icon: BorderBox(
                  child: Icon(Icons.escalator_warning,
                      color: _prov.selectedPage == 1
                          ? Colors.green.shade900
                          : Colors.grey),
                ),
                label: 'Patient',
              ),
              BottomNavigationBarItem(
                icon: BorderBox(
                  child: Icon(Icons.quiz_rounded,
                      color: _prov.selectedPage == 2
                          ? Colors.orange.shade900
                          : Colors.grey),
                ),
                label: 'Quiz',
              ),
              // BottomNavigationBarItem(
              //   icon: BorderBox(
              //     child: Icon(Icons.shopping_bag,
              //         color: _prov.selectedPage == 3
              //             ? Colors.red.shade900
              //             : Colors.grey),
              //   ),
              //   label: 'Market',
              // ),
              BottomNavigationBarItem(
                icon: BorderBox(
                  child: Icon(Icons.new_releases,
                      color: _prov.selectedPage == 3
                          ? Colors.purple.shade900
                          : Colors.grey),
                ),
                label: 'News',
              ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: PageView(
          controller: _prov.controller,
          children: _screen,
          onPageChanged: _prov.onPageChange,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
}

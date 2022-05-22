import 'package:dentisia/service/controller/case.dart';
import 'package:dentisia/service/model/my_case_model.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:dentisia/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCases extends StatelessWidget {
  static const route = '/myCase';
  const MyCases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Prov>(context, listen: false);
    print(prov.uid!);
    return SafeArea(
      child: Scaffold(
          appBar: appBar(
            'My Cases',
          ),
          body: FutureBuilder<List<MyCaseModel>>(
              future: CaseService().getMyCases(prov.uid!),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    snapshot.stackTrace.toString(),
                    style: const TextStyle(color: Colors.red),
                  ));
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.all(10),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data![i].caseName,
                                style: TextStyle(color: Colors.blue.shade900),
                              ),
                              Text(
                                snapshot.data![i].time
                                    .substring(0, 16)
                                    .replaceAll(RegExp(r'T'), '  '),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              })),
    );
  }
}

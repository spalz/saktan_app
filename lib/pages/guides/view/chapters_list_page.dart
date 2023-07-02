import 'package:flutter/material.dart';
import 'package:saktan_app/pages/guides/guides.dart';

class ChaptersListPage extends StatelessWidget {
  final int id;

  const ChaptersListPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('О здоровье'),
        backgroundColor: theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white), // add this line
        titleTextStyle: const TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        child: ListView.builder(
            itemCount: 9,
            itemBuilder: (context, index) {
              return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    tileColor: Colors.grey[200],
                    focusColor: Colors.blue[200],
                    splashColor: Colors.blue[200],
                    minVerticalPadding: 10,
                    title: Text(
                      "${index + 1}. Секс и сексуальность",
                      style: theme.textTheme.bodyMedium,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AboutHealthDetailScreen(
                                initialIndex: index + 1,
                                slug: "slug",
                              )));
                    },
                  ));
            }),
      ),
    );
  }
}

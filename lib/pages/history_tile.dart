import 'package:flutter/material.dart';
// import 'package:trader/components/profile_widgets.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/mypick.dart';
import 'package:trader/variables/myvariables.dart';

class HistoryTile extends StatelessWidget {
  final String id;
  final int total;

  const HistoryTile({
    required this.id,
    required this.total,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<List<MyPick>>(
        future: billPicks(host, "bills/" + id),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(color42)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: size.height * 0.7,
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return itemsInList(snapshot, index);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                        left: 40,
                        right: 40,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: textDirection,
                        children: [
                          Text(
                            "مجموع اقلام و پیک",
                            textDirection: textDirection,
                          ),
                          Text(
                            total.toString() + " " + "ریال",
                            textDirection: textDirection,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Widget itemsInList(AsyncSnapshot<List<MyPick>> snapshot, int index) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: textDirection,
          children: [
            Text(snapshot.data![index].name),
            Text(
              snapshot.data![index].amount.toString(),
            ),
            Text(
              snapshot.data![index].unit == "Count" ? "عدد" : "گرم",
            ),
            Text(
              snapshot.data![index].total.toString() + " " + "ریال",
              textDirection: textDirection,
            ),
          ],
        ),
      ),
    );
  }
}

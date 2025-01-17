import 'package:api_test/online_quran_app/repository/sura_repository.dart';
import 'package:api_test/online_quran_app/model/sura_list_model.dart';
import 'package:api_test/online_quran_app/screens/online_sura_pagination_page.dart';
import 'package:flutter/material.dart';

class OnlineSuraPage extends StatefulWidget {
  const OnlineSuraPage({Key? key}) : super(key: key);

  @override
  State<OnlineSuraPage> createState() => _OnlineSuraPageState();
}

class _OnlineSuraPageState extends State<OnlineSuraPage> {
  List<SuraListModel> suraList = [];
  bool initialSura = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSuraList();
  }

  fetchSuraList() async {
    var data = await SuraRepository().getSuraList();
    setState(() {
      suraList = data;
    });
    initialSura = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Bangla Quran"),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Icon(Icons.search),
              IconButton(
                onPressed: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (ctx) => AlertDialog(
                  //     title: Text("Show Alert Dialog Box"),
                  //     content: Text("You have raised a Alert Dialog Box"),
                  //     actions: <Widget>[
                  //       FlatButton(
                  //         onPressed: () {
                  //           Navigator.of(ctx).pop();
                  //         },
                  //         child: Text("Ok"),
                  //       ),
                  //     ],
                  //   ),
                  // );
                },
                icon: Icon(Icons.settings),
              ),
              Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.more_vert)),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: suraList.length > 0
              ? ListView.builder(
                  itemCount: suraList.length,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var getsuralist = suraList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OnlineSuraPaginationDetailsPage(
                              name: suraList[index].name,
                              id: int.parse(suraList[index].id!),
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          leading: Container(
                            padding: EdgeInsets.only(top: 20),
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Text(
                              getsuralist.id!,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          title: Text(
                            getsuralist.name!,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}

import 'package:api_test/main.dart';
import 'package:api_test/online_quran_app/model/sura_details_model.dart';
import 'package:api_test/online_quran_app/repository/sura_details_repository.dart';
import 'package:flutter/material.dart';

class OnlineSuraPaginationDetailsPage extends StatefulWidget {
  final int? id;
  final String? name;

  OnlineSuraPaginationDetailsPage({
    required this.id,
    required this.name,
  });

  @override
  _OnlineSuraPaginationDetailsPageState createState() =>
      _OnlineSuraPaginationDetailsPageState();
}

class _OnlineSuraPaginationDetailsPageState
    extends State<OnlineSuraPaginationDetailsPage> {
  @override
  void initState() {
    super.initState();
    appBartitle();
    getSuraDetails();
  }

  bool isLoading = false;
  List<SuraDetailsResponseModel> suraDetails = [];
  getSuraDetails() async {
    isLoading = true;

    var data = await SuraDetailsRepository().getAyatService(
      widget.id ?? 1,
      1,
    );

    suraDetails = data;

    isLoading = false;

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  appBartitle() {
    appBarTitle = new Text(widget.name!);
  }

  Widget? appBarTitle;
  bool isSearch = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: isLoading
          ? Center(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: ListView.builder(
                itemCount: suraDetails.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      Card(
                        margin: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        child: ListTile(
                          title: Text(
                            suraDetails[index].ayahNo ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: ListView.builder(
                            itemCount: suraDetails[index].bn!.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, gobalindex) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text(
                                            suraDetails[index].ayahText ?? '',
                                            style: TextStyle(
                                              fontSize: fontsize,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    suraDetails[index]
                                            .bn![gobalindex]
                                            .tokenTrans ??
                                        '',
                                    style: TextStyle(
                                      fontSize: fontsize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
    );
  }
}

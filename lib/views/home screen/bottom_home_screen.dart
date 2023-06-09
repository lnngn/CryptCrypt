import 'package:c_app/const/gaps.dart';
import 'package:c_app/const/sizes.dart';
import 'package:c_app/data/add_and_remove_coin.dart';
import 'package:c_app/data/api_data.dart';
import 'package:c_app/data/search_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ShowBottomScreen extends StatelessWidget {
  const ShowBottomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: Sizes.size10),
          child: SizedBox(
            height: Sizes.size36,
            child: TextFormField(
              cursorColor: Colors.white,
              style: const TextStyle(
                color: Colors.white,
                fontSize: Sizes.size16,
              ),
              decoration: const InputDecoration(
                fillColor: Color(0xff303030),
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: Sizes.size14,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              initialValue: searchData.textResult,
              onChanged: (value) => searchData.getResults(value),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: apiData.getCoins(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16 + Sizes.size1,
              ),
              child: AnimatedBuilder(
                animation: searchData,
                builder: (context, child) => ListView.builder(
                  itemCount: searchData.initialResults.length,
                  itemBuilder: (context, index) {
                    return Ink(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size8,
                      ),
                      child: InkWell(
                        splashColor: Colors.grey,
                        splashFactory: InkSparkle.splashFactory,
                        onTap: () {
                          addAndRemoveCoin.addCoin(index);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  searchData.initialResults[index].coin,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: Sizes.size16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Gaps.v5,
                                Text(
                                  searchData.initialResults[index].symbol,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 170, 170, 170),
                                    fontSize: Sizes.size14,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  NumberFormat().format(
                                      searchData.initialResults[index].price),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: Sizes.size16,
                                  ),
                                ),
                                Gaps.v5,
                                Row(
                                  children: [
                                    Text(
                                      //Percent 24h
                                      '${NumberFormat().format(double.parse(searchData.initialResults[index].percent24h))}%',
                                      style: TextStyle(
                                        color: double.parse(searchData
                                                    .initialResults[index]
                                                    .percent24h) >
                                                0
                                            ? const Color(0xff00f6ff)
                                            : const Color(0xfffc00ff),
                                        fontSize: Sizes.size14,
                                      ),
                                    ),
                                    //Arrow up and down
                                    Icon(
                                      double.parse(searchData
                                                  .initialResults[index]
                                                  .percent24h) >
                                              0
                                          ? FontAwesomeIcons.arrowUp
                                          : FontAwesomeIcons.arrowDown,
                                      color: double.parse(searchData
                                                  .initialResults[index]
                                                  .percent24h) >
                                              0
                                          ? const Color(0xff00f6ff)
                                          : const Color(0xfffc00ff),
                                      size: Sizes.size14,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
        },
      ),
    );
  }
}

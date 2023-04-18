import 'package:c_app/const/gaps.dart';
import 'package:c_app/const/sizes.dart';
import 'package:c_app/data/add_and_remove_coin.dart';
import 'package:c_app/data/cal_total_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class BodyHomeScreen extends StatefulWidget {
  const BodyHomeScreen({super.key});

  @override
  State<BodyHomeScreen> createState() => _BodyHomeScreenState();
}

class _BodyHomeScreenState extends State<BodyHomeScreen> {
  @override
  void initState() {
    addAndRemoveCoin.hiveCoinData();
    calTotal.hiveUserInputValue();
    calTotal.hiveTotalData();
    calTotal.hiveUserInputValueForTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Sizes.size16,
        right: Sizes.size16,
      ),
      child: AnimatedBuilder(
        animation: addAndRemoveCoin,
        builder: (context, child) => ListView.builder(
          itemCount: addAndRemoveCoin.coinsOnScreen.length,
          itemBuilder: (context, index) {
            return Dismissible(
              onDismissed: (direction) {
                calTotal.removeInput(index);
                addAndRemoveCoin.removeCoin(index);
              },
              key: UniqueKey(),
              child: Column(
                children: [
                  Gaps.v16,
                  Container(
                    padding: const EdgeInsets.only(
                      top: Sizes.size20,
                      left: Sizes.size20,
                      right: Sizes.size20,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 200, 200, 200),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              addAndRemoveCoin.coinsOnScreen[index].coin,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: Sizes.size20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              NumberFormat().format(
                                  addAndRemoveCoin.coinsOnScreen[index].price),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: Sizes.size20,
                              ),
                            ),
                          ],
                        ),
                        Gaps.v5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              addAndRemoveCoin.coinsOnScreen[index].symbol,
                              style: const TextStyle(
                                color: Color(0xff989898),
                                fontSize: Sizes.size16,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${NumberFormat().format(
                                    double.parse(addAndRemoveCoin
                                        .coinsOnScreen[index].percent24h),
                                  )}%',
                                  style: TextStyle(
                                    color: double.parse(addAndRemoveCoin
                                                .coinsOnScreen[index]
                                                .percent24h) >
                                            0
                                        ? const Color.fromARGB(255, 46, 230, 0)
                                        : const Color(0xffFF0000),
                                    fontSize: Sizes.size16,
                                  ),
                                ),
                                Icon(
                                  double.parse(addAndRemoveCoin
                                              .coinsOnScreen[index]
                                              .percent24h) >
                                          0
                                      ? FontAwesomeIcons.arrowUp
                                      : FontAwesomeIcons.arrowDown,
                                  color: double.parse(addAndRemoveCoin
                                              .coinsOnScreen[index]
                                              .percent24h) >
                                          0
                                      ? const Color.fromARGB(255, 46, 230, 0)
                                      : const Color(0xffFF0000),
                                  size: Sizes.size14,
                                )
                              ],
                            ),
                          ],
                        ),
                        Gaps.v10,
                        const Divider(
                          color: Color.fromARGB(255, 200, 200, 200),
                          thickness: 1,
                        ),
                        SizedBox(
                          height: Sizes.size40,
                          child: TextFormField(
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: const InputDecoration(
                              hintText: '0',
                              contentPadding: EdgeInsets.only(
                                top: 0,
                                bottom: Sizes.size14,
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size20,
                            ),
                            initialValue: calTotal.userInputValue[index]
                                        .toStringAsFixed(0) ==
                                    '0'
                                ? ''
                                : calTotal.userInputValue[index]
                                    .toStringAsFixed(0),
                            onChanged: (value) {
                              calTotal.calTotal(value, index);
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project/core/style/app_style.dart';
import 'package:project/core/style/text_style.dart';

class ItemStore extends StatelessWidget {
  final int orderNo;
  final String dess;

  const ItemStore({Key? key, required this.orderNo, required this.dess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 160,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          boxShadow: boxShadow),
      margin: const EdgeInsets.only(right: 0, left: 0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: Image.network(
              "https://internal.amaisoft.com/assets/canteen1.300efa8c.webp",
              height: 160,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 8),
                  child: Text("Thực đơn $orderNo",
                      maxLines: 2, overflow: TextOverflow.ellipsis, style: typoInterNomal18.copyWith(fontSize: 16)),
                ),
                const SizedBox(
                  height: 6,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

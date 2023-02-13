import 'package:flutter/material.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/core/style/app_style.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/features/amai_store_page/cubit/amai_store_cubit.dart';

class ItemStore extends StatelessWidget {
  final String title;
  final String dess;
  final VoidCallback? onPressed;
  final AmaiStoreState state;
  final AppElevatedButtonState buttonState;
  final int id;
  const ItemStore(
      {Key? key,
      required this.title,
      required this.dess,
      this.onPressed,
      required this.state,
      required this.buttonState,
      required this.id})
      : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
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
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                  style: typoInterNomal16,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  dess,
                  style: typoInterNomal14,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: AppElevatedButton(
              state: buttonState,
              onPressed: onPressed,
              buttonTitle:
                  state.ordered.lunchMenusId == id ? translation(context).cancel_order : translation(context).order_now,
            ),
          )
        ],
      ),
    );
  }
}

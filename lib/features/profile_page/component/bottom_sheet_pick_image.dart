import 'package:flutter/material.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/features/profile_page/cubit/profile_cubit.dart';

class BottomSheetPickImage extends StatelessWidget {
  BottomSheetPickImage({Key? key}) : super(key: key);
  final bloc = getIt<ProfileCubit>();
  @override
  Widget build(BuildContext context) {
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     // Text(translation(context).camera),
    //     // SizedBox(
    //     //   height: 16,
    //     // ),
    //     // Text(translation(context).gallery)
    //   ],
    // );
    return ListView(
      shrinkWrap: true,
      children: ListTile.divideTiles(context: context, tiles: [
        ListTile(
          title: Text(translation(context).camera),
          onTap: () {
            Navigator.of(context).pop();
            bloc.pickAvatarFromCamera();
          },
        ),
        ListTile(
          title: Text(translation(context).gallery),
          onTap: () {
            Navigator.of(context).pop();
            bloc.pickAvatarFromgallery();
          },
        )
      ]).toList(),
    );
  }
}

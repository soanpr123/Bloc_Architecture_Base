import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/resource.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    Key? key,
    this.source,
    this.style = "none",
    this.fit = BoxFit.fill,
    this.decoration,
  }) : super(key: key);

  final String? source;
  final String style;
  final BoxFit fit;
  final BoxDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    // var url = Uri.parse('https://example.com/whatsit/create');
    // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
    return source == null || source!.isEmpty || !source!.startsWith('http')
        ? Image.asset(
            "assets/images/place.png",
            fit: fit,
          )
        : CachedNetworkImage(
            imageUrl: source ?? "",
            placeholder: (context, url) => SizedBox(
              height: 150.0,
              width: 100.0,
              child: SpinKitRipple(
                color: colorBrandPrimary,
              ),
            ),
            fit: fit,
            errorWidget: (context, url, error) =>
                Lottie.asset(R.ASSETS_JSON_NO_IMAGE_JSON, fit: BoxFit.cover, repeat: false),
          );
  }
}

class AppNetworkImageAvatar extends StatelessWidget {
  const AppNetworkImageAvatar({
    Key? key,
    this.source,
    this.style = "none",
    this.fit = BoxFit.fill,
    this.decoration,
  }) : super(key: key);

  final String? source;
  final String style;
  final BoxFit fit;
  final BoxDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    // var url = Uri.parse('https://example.com/whatsit/create');
    // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
    return source == null || source!.isEmpty || !source!.startsWith('http')
        ? Image.asset(
            R.ASSETS_PNG_NO_AVATAR_PNG,
            fit: fit,
          )
        : CachedNetworkImage(
            imageUrl: source ?? "",
            placeholder: (context, url) => SizedBox(
              height: 150.0,
              width: 100.0,
              child: SpinKitRipple(
                color: colorBrandPrimary,
              ),
            ),
            fit: fit,
            errorWidget: (context, url, error) => Image.asset(
              R.ASSETS_PNG_NO_AVATAR_PNG,
              fit: fit,
            ),
          );
  }
}

// class BaseNetworkImage extends StatelessWidget {
//   const BaseNetworkImage({
//     Key? key,
//     this.source,
//     this.style = "none",
//     this.fit = BoxFit.contain,
//   }) : super(key: key);

//   final String? source;
//   final String? style;
//   final BoxFit fit;

//   @override
//   Widget build(BuildContext context) {
//     // var url = Uri.parse('https://example.com/whatsit/create');
//     // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
//     return source == null || source!.isEmpty || !source!.startsWith('http')
//         ? Image.asset(
//             R.ASSETS_PNG_NOIMAGE_PNG,
//             fit: BoxFit.contain,
//           )
//         : CachedNetworkImageProvider(
//             imageUrl: source ?? "",
//             placeholder: (context, url) => Center(
//               widthFactor: 2,
//               heightFactor: 2,
//               child: Container(
//                 width: 24,
//                 height: 24,
//                 child: CircularProgressIndicator(
//                   color: colorPrimaryBlue100,
//                   strokeWidth: 2.0,
//                 ),
//               ),
//             ),
//             fit: BoxFit.contain,
//             errorWidget: (context, url, error) => CachedNetworkImageProvider(
//               imageUrl:
//                   "https://platform-static-files.s3.amazonaws.com/premierleague/photos/players/250x250/Photo-Missing.png",
//             ),
//           );
//   }
// }

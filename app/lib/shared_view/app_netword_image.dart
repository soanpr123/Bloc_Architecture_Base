import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import '../../app.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    Key? key,
    this.source,
    this.style = 'none',
    this.fit = BoxFit.fill,
    this.isAvt = false,
    this.gender = '',
    this.decoration,
  }) : super(key: key);

  final String? source;
  final String style;
  final BoxFit fit;
  final bool isAvt;
  final String gender;
  final BoxDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    // var url = Uri.parse('https://example.com/whatsit/create');
    // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
    return source == null || source!.isEmpty || !source!.startsWith('http')
        ? isAvt
            ? Container(
                decoration: BoxDecoration(
                  color: colorBgAvt,
                ),
                child: gender == 'Nam'
                    ? Assets.png.noAvatar.image(fit: fit)
                    : gender == 'Nữ'
                        ? Assets.png.nuNoavt.image(fit: fit)
                        : Assets.png.ortherNoavt.image(fit: fit),
              )
            : Assets.svg.noAvatar.svg(fit: fit)
        : CachedNetworkImage(
            imageUrl: source ?? '',
            placeholder: (context, url) => SizedBox(
              height: 150.0,
              width: 100.0,
              child: SpinKitRipple(
                color: colorBrandPrimary,
              ),
            ),
            fit: fit,
            errorWidget: (context, url, dynamic error) {
              return Lottie.asset(Assets.json.noImage, fit: BoxFit.cover, repeat: false);
            },
          );
  }
}

// ignore: prefer-single-widget-per-file
class AppNetworkImageAvatar extends StatelessWidget {
  const AppNetworkImageAvatar({
    Key? key,
    this.source,
    this.style = 'none',
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
            Assets.png.noAvatar.path,
            fit: fit,
          )
        : CachedNetworkImage(
            imageUrl: source ?? '',
            placeholder: (context, url) => SizedBox(
              height: 150.0,
              width: 100.0,
              child: SpinKitRipple(
                color: colorBrandPrimary,
              ),
            ),
            fit: fit,
            errorWidget: (context, url, dynamic error) => Image.asset(
              Assets.png.noAvatar.path,
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

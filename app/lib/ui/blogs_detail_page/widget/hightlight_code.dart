import 'package:app/ui/blogs_detail_page/widget/higilht_ligihtter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown/markdown.dart' as md;

import 'package:shared/shared.dart';

class CodeElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = '';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9);
      print("lagddd$language");
    }

    return SizedBox(
      width: MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width,
      child: HighlightViewCode(
        // The original code to be highlighted
        element.textContent,

        // Specify language
        // It is recommended to give it a value for performance
        language: language,
        theme: SymbolConstants.atomOneLightTheme,
        // Specify highlight theme
        // All available themes are listed in `themes` folder

        // Specify padding
        padding: const EdgeInsets.all(8),

        // Specify text style
        textStyle: GoogleFonts.robotoMono(),
      ),
    );
  }
}

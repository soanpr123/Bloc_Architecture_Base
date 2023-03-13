import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:highlighter/highlighter.dart' show highlight, Node;

/// Highlight Flutter Widget
class HighlightViewCode extends StatelessWidget {
  HighlightViewCode(
    String input, {
    this.language,
    this.theme = const {},
    this.padding,
    this.textStyle,
    int tabSize = 8,
    super.key,
  }) : source = input.replaceAll('\t', ' ' * tabSize);

  /// The original code to be highlighted
  final String source;

  /// Highlight language
  ///
  /// It is recommended to give it a value for performance
  ///
  /// [All available languages](https://github.com/predatorx7/highlight/tree/master/highlight/lib/languages)
  final String? language;

  /// Highlight theme
  ///
  /// [All available themes](https://github.com/predatorx7/highlight/blob/master/flutter_highlighter/lib/themes)
  final Map<String, TextStyle> theme;

  /// Padding
  final EdgeInsetsGeometry? padding;

  /// Text styles
  ///
  /// Specify text styles such as font family and font size
  final TextStyle? textStyle;

  List<TextSpan> _convert(List<Node> nodes) {
    final List<TextSpan> spans = [];
    var currentSpans = spans;
    final List<List<TextSpan>> stack = [];

    // ignore: always_declare_return_types
    _traverse(Node node) {
      if (node.value != null) {
        currentSpans.add(node.className == null
            ? TextSpan(text: node.value)
            : TextSpan(text: node.value, style: theme[node.className!]));
      } else if (node.children != null) {
        final List<TextSpan> tmp = [];
        currentSpans.add(TextSpan(children: tmp, style: theme[node.className!]));
        stack.add(currentSpans);
        currentSpans = tmp;

        node.children!.forEach((n) {
          _traverse(n);
          if (n == node.children!.last) {
            currentSpans = stack.isEmpty ? spans : stack.removeLast();
          }
        });
      }
    }

    for (var node in nodes) {
      _traverse(node);
    }

    return spans;
  }

  // ignore: member-ordering
  static const String _rootKey = 'root';
  // ignore: member-ordering
  static const Color _defaultFontColor = Color(0xff000000);

  // ignore: member-ordering
  static const Color _defaultBackgroundColor = Color(0xffffffff);

  // ignore: member-ordering
  static const String _defaultFontFamily = 'monospace';

  @override
  Widget build(BuildContext context) {
    var _textStyle = TextStyle(
      fontFamily: _defaultFontFamily,
      color: theme[_rootKey]?.color ?? _defaultFontColor,
    );
    if (textStyle != null) {
      _textStyle = _textStyle.merge(textStyle);
    }

    return Container(
      decoration: BoxDecoration(
          color: theme[_rootKey]?.backgroundColor ?? _defaultBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      padding: padding,
      child: RichText(
        text: TextSpan(
          style: _textStyle,
          children: _convert(highlight.parse(source, language: language).nodes!),
        ),
      ),
    );
  }
}

import 'package:fit_board/utils/my_print.dart';
import 'package:flutter/material.dart';
import 'package:rich_text_view/rich_text_view.dart';
import '../../../utils/my_utils.dart';

class CommonRichTextView extends StatelessWidget {
  String url = "";
  Color urlColor;
  TextStyle? defaultStyle, linkStyle;
  TextAlign? textAlign;
  final int maxLines;

   CommonRichTextView({
    Key? key,
    this.url = "",
    this.urlColor = Colors.blue,
    this.defaultStyle,
    this.textAlign,
    this.maxLines = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return const SizedBox.shrink();
    }
    else {
      return RichTextView(
        selectable: true,
        text: url,

        // maxLines: 5,
        textAlign: textAlign ?? TextAlign.start,
        onEmailClicked: (email) {
          MyPrint.printOnConsole("onEmailClicked called, '$email' clicked");
        },
        onHashTagClicked: (hashtag) {
          MyPrint.printOnConsole("onHashTagClicked called, '$hashtag' clicked");
        },
        onMentionClicked: (mention) {
          MyPrint.printOnConsole("onMentionClicked called, '$mention' clicked");
        },
        onUrlClicked: (String url) {
          MyPrint.printOnConsole("onUrlClicked called, '$url' clicked");
          MyUtils.launchUrl(url, isAppendHttps: true);
        },
        truncate: false,
        viewLessText: null,
        linkStyle: linkStyle ?? TextStyle(
          color: urlColor,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        style: defaultStyle,
        supportedTypes: const [
          ParsedType.URL,
        ],
      );
    }
  }
}

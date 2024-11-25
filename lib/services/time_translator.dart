class TimeTranslator {
  String translate(String source) {
    String text = source;
    text = text.replaceFirst(RegExp(r'a moment ago'), 'vừa xong');
    text = text.replaceFirst(RegExp(r'an hour ago'), 'một giờ trước');
    text = text.replaceAll(RegExp(r'hours ago'), 'giờ trước');
    text = text.replaceFirst(RegExp(r'days ago'), 'ngày trước');
    text = text.replaceFirst(RegExp(r'minutes ago'), 'phút trước');
    text = text.replaceFirst(RegExp(r'about'), 'khoảng');

    return text;
  }
}

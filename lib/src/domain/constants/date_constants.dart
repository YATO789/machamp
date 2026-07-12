const _weekDayLabelsJa = ['月', '火', '水', '木', '金', '土', '日'];
const _weekDayLabelsEn = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

List<String> weekDayLabels(String languageCode) =>
    languageCode == 'en' ? _weekDayLabelsEn : _weekDayLabelsJa;

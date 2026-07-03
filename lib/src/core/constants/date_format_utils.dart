const _months = [
  'JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE',
  'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER',
];

String formatShareDate(DateTime date) =>
    '${_months[date.month - 1]} ${date.day}, ${date.year}';

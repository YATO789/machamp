import 'dart:io';

class SharePreviewArgs {
  const SharePreviewArgs({
    required this.backgroundImage,
    required this.workoutName,
    required this.totalVolume,
    required this.totalSets,
    required this.date,
    required this.durationMinutes,
  });

  final File backgroundImage;
  final String workoutName;
  final String totalVolume;
  final int totalSets;
  final DateTime date;
  final int durationMinutes;
}

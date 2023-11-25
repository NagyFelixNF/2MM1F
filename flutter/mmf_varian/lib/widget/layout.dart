import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart';

class CustomEventGroupOverlapLayoutDelegate<T>
    extends EventGroupLayoutDelegate<T> {
  CustomEventGroupOverlapLayoutDelegate({
    required super.events,
    required super.date,
    required super.heightPerMinute,
    required super.startHour,
    required super.endHour,
  });

  @override
  void performLayout(Size size) {
    final startDy = startHourPosition;
    final endDy = endHourPosition;

    final numChildren = events.length;
    final tileWidth = size.width;

    for (var i = 0; i < numChildren; i++) {
      final id = i;
      final event = events[id];

      // Calculate width of the child.
      final childWidth = ((id * tileWidth) / 5);

      // Calculate the top offset of the tile.
      final eventStartOnDate = event.dateTimeRangeOnDate(date).start;
      final timeBeforeStart = eventStartOnDate.difference(date);

      // Clamp the y position to the start and end hour.
      final dy = calculateYPosition(
        timeBeforeStart,
        heightPerMinute,
      ).clamp(startDy, endDy);

      final start =
          eventStartOnDate.isBefore(startTime) ? startTime : eventStartOnDate;
      final eventEndOnDate = event.dateTimeRangeOnDate(date).end;
      final end = eventEndOnDate.isAfter(endTime) ? endTime : eventEndOnDate;

      // Calculate the height of the tile.
      var childHeight = calculateHeight(
        end.difference(start),
        heightPerMinute,
      );

      // if the child height is less than 0, make it invisible.
      if (childHeight < 0) {
        childHeight = 0.0001;
      }

      // Layout the tile.
      layoutChild(
        id,
        BoxConstraints.tightFor(
          width: (tileWidth - ((i * tileWidth) / 5)).floorToDouble(),
          height: childHeight,
        ),
      );

      positionChild(
        id,
        Offset(childWidth, dy),
      );
    }
  }
}

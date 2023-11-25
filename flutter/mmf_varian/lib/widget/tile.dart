import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart';
import 'package:mmf_varian/models/Event.dart';
import 'package:provider/provider.dart';

class EventTile extends StatelessWidget {
  const EventTile({
    super.key,
    required this.event,
    required this.tileType,
    required this.drawOutline,
    required this.continuesBefore,
    required this.continuesAfter,
  });

  final CalendarEvent<Event> event;
  final TileType tileType;
  final bool drawOutline;
  final bool continuesBefore;
  final bool continuesAfter;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color(event.eventData?.color ?? Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: event.eventData?.title ?? '',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const TextSpan(text: '\n'),
                  TextSpan(
                    text: event.eventData?.description ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color color(Color color) {
    if (tileType == TileType.ghost) {
      return color.withAlpha(100);
    } else {
      return color;
    }
  }

  double get elevation {
    switch (tileType) {
      case TileType.ghost:
        return 0.0;
      case TileType.normal:
        return 4.0;
      case TileType.selected:
        return 8.0;
      default:
        return 0.0;
    }
  }
}

class MultiDayEventTile extends StatelessWidget {
  const MultiDayEventTile({
    super.key,
    required this.event,
    required this.tileType,
    required this.continuesBefore,
    required this.continuesAfter,
  });
  final CalendarEvent<Event> event;
  final TileType tileType;
  final bool continuesBefore;
  final bool continuesAfter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      child: Material(
        type: MaterialType.card,
        color: color(event.eventData?.color ?? Colors.blue),
        elevation: elevation,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(continuesBefore ? 0 : 12),
          bottomLeft: Radius.circular(continuesBefore ? 0 : 12),
          topRight: Radius.circular(continuesAfter ? 0 : 12),
          bottomRight: Radius.circular(continuesAfter ? 0 : 12),
        ),
        child: Container(
          decoration: tileType == TileType.selected
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onBackground,
                    width: 1,
                  ),
                )
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    event.eventData?.title ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color color(Color color) {
    if (tileType == TileType.ghost) {
      return color.withAlpha(100);
    } else {
      return color;
    }
  }

  double get elevation {
    switch (tileType) {
      case TileType.ghost:
        return 0.0;
      case TileType.normal:
        return 4.0;
      case TileType.selected:
        return 8.0;
      default:
        return 0.0;
    }
  }
}

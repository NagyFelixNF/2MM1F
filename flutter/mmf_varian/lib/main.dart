import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kalender/kalender.dart';
import 'package:mmf_varian/models/Bookings.dart';
import 'package:mmf_varian/models/Event.dart';
import 'package:mmf_varian/utils/StatProvider.dart';
import 'package:mmf_varian/widget/calendar.dart';
import 'package:mmf_varian/widget/layout.dart';
import 'package:mmf_varian/widget/tile.dart';

import 'package:kalender/src/extensions.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StatProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CareSync Hub',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DateFormat formatter = DateFormat('Hm');
  final Bookings bookings = Bookings();
  String SelectedAcc = "VitalBeam1";

  final CalendarController<Event> controller = CalendarController();
  final CalendarEventsController<Event> eventController =
      CalendarEventsController<Event>();

  late ViewConfiguration currentConfiguration = viewConfigurations[0];
  List<ViewConfiguration> viewConfigurations = [
    CustomMultiDayConfiguration(
        name: 'Day',
        numberOfDays: 1,
        verticalSnapRange: const Duration(minutes: 1),
        verticalStepDuration: const Duration(minutes: 1)),
    CustomMultiDayConfiguration(
      name: 'Custom',
      numberOfDays: 2,
    ),
    WeekConfiguration(enableResizing: false),
    WorkWeekConfiguration(),
    MonthConfiguration(),
    ScheduleConfiguration(),
    MultiWeekConfiguration(
      numberOfWeeks: 3,
    ),
  ];

  @override
  void initState() {
    super.initState();
    bookings.createBookings2();
    print(bookings.bookings);
    createEventsForBookings('VitalBeam1');
  }

  void createEventsForBookings(String accName) {
    for (var element in bookings.bookings) {
      CalendarEvent<Event> calendarEvent;
      if (element.accel.name == accName) {
        calendarEvent = CalendarEvent(
            dateTimeRange:
                DateTimeRange(start: element.start, end: element.finish),
            eventData: Event(
                color: Colors.blue,
                start: element.start,
                end: element.finish,
                patient: element.patient,
                currentTreatmentNumber: element.currentTreatmentNumber));
        eventController.addEvent(calendarEvent);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CalendarView<Event>(
          controller: controller,
          eventsController: eventController,
          viewConfiguration: currentConfiguration,
          tileBuilder: _tileBuilder,
          multiDayTileBuilder: _multiDayTileBuilder,
          scheduleTileBuilder: _scheduleTileBuilder,
          components: CalendarComponents(
              calendarHeaderBuilder: _calendarHeader,
              calendarZoomDetector: _calendarZoomDetectorBuil,
              weekNumberBuilder: _calendarWeekHeader),
          eventHandlers: CalendarEventHandlers(
            onEventTapped: _onEventTapped,
            onEventChanged: _onEventChanged,
            onEventCreated: _onEventCreated,
          ),
        ),
      ),
    );
  }

  Future<void> _onEventCreated(CalendarEvent<Event> event) async {
    // Add the event to the events controller.
    eventController.addEvent(event);

    // Deselect the event.
    eventController.deselectEvent();
  }

  Future<void> _onEventTapped(
    CalendarEvent<Event> event,
  ) async {
    if (isMobile) {
      eventController.selectedEvent == event
          ? eventController.deselectEvent()
          : eventController.selectEvent(event);
    }
  }

  Future<void> _onEventChanged(
    DateTimeRange initialDateTimeRange,
    CalendarEvent<Event> event,
  ) async {
    if (isMobile) {
      eventController.deselectEvent();
    }
    event.eventData!.start = event.start;
    event.eventData!.end = event.end;
  }

  Widget _tileBuilder(
    CalendarEvent<Event> event,
    TileConfiguration tileConfiguration,
  ) {
    return EventTile(
      event: event,
      tileType: tileConfiguration.tileType,
      drawOutline: tileConfiguration.drawOutline,
      continuesBefore: tileConfiguration.continuesBefore,
      continuesAfter: tileConfiguration.continuesAfter,
    );
  }

  Widget _multiDayTileBuilder(
    CalendarEvent<Event> event,
    MultiDayTileConfiguration tileConfiguration,
  ) {
    return MultiDayEventTile(
      event: event,
      tileType: tileConfiguration.tileType,
      continuesBefore: tileConfiguration.continuesBefore,
      continuesAfter: tileConfiguration.continuesAfter,
    );
  }

  Widget _scheduleTileBuilder(CalendarEvent<Event> event, DateTime date) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: event.eventData?.color ?? Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(event.eventData?.title ?? 'New Event'),
    );
  }

  Widget _calendarHeader(DateTimeRange dateTimeRange) {
    final providerCat = Provider.of<StatProvider>(context, listen: true);
    providerCat.initGetCoverageForDays(
        dateTimeRange.start, SelectedAcc, bookings);
    return Row(
      children: [
        DropdownMenu(
            onSelected: (value) {
              if (value == null) return;
              eventController.clearEvents();
              SelectedAcc = value;
              createEventsForBookings(value);
              providerCat.getCoverageForDays(
                  dateTimeRange.start, value, bookings);
            },
            initialSelection: 'VitalBeam1',
            dropdownMenuEntries: const [
              DropdownMenuEntry(value: 'VitalBeam1', label: 'VitalBeam1'),
              DropdownMenuEntry(value: 'VitalBeam2', label: 'VitalBeam2'),
              DropdownMenuEntry(value: 'TrueBeam1', label: 'TrueBeam1'),
              DropdownMenuEntry(value: 'TrueBeam2', label: 'TrueBeam2'),
              DropdownMenuEntry(value: 'Clinac', label: 'Clinac'),
            ]),
        DropdownMenu(
          onSelected: (value) {
            if (value == null) return;
            setState(() {
              currentConfiguration = value;
            });
          },
          initialSelection: currentConfiguration,
          dropdownMenuEntries: viewConfigurations
              .map((e) => DropdownMenuEntry(value: e, label: e.name))
              .toList(),
        ),
        IconButton.filledTonal(
          onPressed: () {
            controller.animateToPreviousPage();
          },
          icon: const Icon(Icons.navigate_before_rounded),
        ),
        IconButton.filledTonal(
          onPressed: () {
            controller.animateToNextPage();
          },
          icon: const Icon(Icons.navigate_next_rounded),
        ),
        Text('${providerCat.Stat}')
      ],
    );
  }

  bool get isMobile {
    return kIsWeb ? false : Platform.isAndroid || Platform.isIOS;
  }

  Widget _calendarZoomDetectorBuil(
      CalendarController controller, Widget child) {
    return CalendarZoomDetector(
      controller: controller,
      child: child,
    );
  }

  Widget _calendarWeekHeader(DateTimeRange visibleDateRange) {
    final String text;
    if (visibleDateRange.duration > const Duration(days: 7)) {
      text =
          '${visibleDateRange.start.weekOfYear} - ${visibleDateRange.end.weekOfYear}';
    } else {
      text = visibleDateRange.start.startOfWeek.weekOfYear.toString();
    }

    return Column(
      children: [
        IconButton.filledTonal(
          tooltip: 'Week Number',
          onPressed: null,
          visualDensity: VisualDensity.comfortable,
          icon: Text(
            text,
          ),
        ),
      ],
    );
  }
}

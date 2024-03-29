JsOsaDAS1.001.00bplist00�Vscript_�// This script makes it possible to copy events from a calendar to another and to anonymize certain informations. In my case it just shows start and enddate and a given title for all events of the start calendar in the target calendar..

var app = Application.currentApplication();
app.includeStandardAdditions = true;
var calendarApp = Application("Calendar");
calendarApp.activate();


// Start Date (Today) and how far you want to go into the future
var startDate = app.currentDate();
var endDate = new Date(startDate);
endDate.setDate(endDate.getDate() + 60);

//define your start calendar
var calendarPrivat = "Privat";

//define your target
var calendarGoal = "Availability";


// Deletes Target Calendar for Timespan
deleteeverything(calendarGoal);

//define start, target and how the event are supposed to be called
// Of Course you can add here multiple calendars
addEventsFromCalendarToWork(calendarPrivat, calendarGoal, "Blocked");


// Sometimes changes don't show up in the UI. Just restart the app.


// This works but for some reason the app needs to be restarted
function deleteeverything(calendarNameInput){

	// Gets calendar objects and checks if it works
	var currentCalendar = calendarApp.calendars.whose({ name: calendarNameInput })[0];

	
	try {
		currentCalendar.get();
	} catch (e) {
		app.displayAlert(calendarNameInput + ' not found');
		return;
	}
	
	
	var events = currentCalendar.events.whose({
		_and: [
			{ startDate: { _greaterThan: startDate } },
			{ endDate: { _lessThan: endDate } }
		]
	})({ timeout: 600 });

	for (var event of events) {
		
		event.delete();
		
	};
	
	app.displayNotification("Sync in progress", {
    withTitle: "Calendar Sync",
	});
	
	// Sometimes it doesn't show up in the UI
	calendarApp.reloadCalendars();
};	

function addEventsFromCalendarToWork(calendarNameInput, calendarNameOutput, eventtitle) {
	
	// Gets both calendat objects and checks if the work
	var currentCalendar = calendarApp.calendars.whose({ name: calendarNameInput })[0];
	var goalCalendar = calendarApp.calendars.whose({ name: calendarNameOutput}) [0];
	
	try {
		currentCalendar.get();
	} catch (e) {
		app.displayAlert(calendarNameInput + ' not found');
		return;
	}
	
		try {
		goalCalendar.get();
	} catch (e) {
		app.displayAlert(calendarNameOutput + ' not found');
		return;
	}
	
	
	var events = currentCalendar.events.whose({
		_and: [
			{ startDate: { _greaterThan: startDate } },
			{ endDate: { _lessThan: endDate } }
		]
	})({ timeout: 600 });

	for (var event of events) {
		
		//For some reason the sequence and excludedDates can't be copied
		
		// Writes original uid into description of copy
		var newEvent = calendarApp.Event({summary: eventtitle, 
		startDate: event.startDate(), endDate: event.endDate(), 
		description: event.uid(), alldayEvent: event.alldayEvent(), 
		recurrence: event.recurrence()});
		
		// checks duplicates by said uid
		var duplicates = goalCalendar.events.whose({description: event.uid()});
		if (duplicates().length == 0) {goalCalendar.events.push(newEvent)};
		
		
	};
	
	app.displayNotification("All events of calendar were copied", {
    withTitle: "Calendar Sync",
    subtitle: calendarNameInput,
	});
	
	calendarApp.reloadCalendars();
};                              � jscr  ��ޭ
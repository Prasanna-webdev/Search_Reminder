// Search Reminder
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ProReminder {

    struct Reminder {
        string name;
        string[] dates;
        mapping(string => string[]) timeToReminders;
    }

    mapping (address => Reminder) public mapReminder;

    function register(string memory _name) public {
        Reminder storage r = mapReminder[msg.sender];
        r.name = _name;
    }

    function writeReminder(string memory _date, string memory _time, string memory rem) public {
        Reminder storage r = mapReminder[msg.sender];
        r.dates.push(_date);
        r.timeToReminders[_date].push(rem);
    }

    function getReminderCount() public view returns (uint256) {
        return mapReminder[msg.sender].dates.length;
    }

    function getReminderByIndex(uint256 _index) public view returns (string memory, string memory, string memory) {
        Reminder storage r = mapReminder[msg.sender];
        require(_index < r.dates.length, "Invalid index");
        string memory date = r.dates[_index];
        string memory time = ""; // For simplicity, you can choose a specific time format or return an array of times.
        string memory reminder = r.timeToReminders[date][0]; // For simplicity, assuming the first reminder of the day.
        return (date, time, reminder);
    }

    function getRemindersByDate(string memory _date) public view returns (string[] memory, string[] memory, string[] memory) {
        Reminder storage r = mapReminder[msg.sender];
        string[] memory times = r.timeToReminders[_date];
        string[] memory dates = new string[](times.length);
        string[] memory reminders = new string[](times.length);

        for (uint256 i = 0; i < times.length; i++) {
            dates[i] = _date;
            reminders[i] = times[i];
        }

        return (dates, times, reminders);
    }
}


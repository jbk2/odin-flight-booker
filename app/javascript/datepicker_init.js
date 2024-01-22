// document.addEventListener("departureDatesUpdated", initializeDatePicker);


// function initializeDatePicker() {
//     console.log('initializeDatePicker is being called');
//     var datePickerData = document.getElementById('datepicker-data');
//     console.log(`DatePickerDate is ${datePickerData} is being called`);

//     if (datePickerData) {
//         var allowedDates = JSON.parse(datePickerData.getAttribute('data-dates'));

//         function enableSpecificDates(date) {
//             var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
//             return [allowedDates.includes(string)];
//         }

//         $("#departure_date").datepicker({
//             beforeShowDay: enableSpecificDates
//         });
//     }
// }


document.addEventListener("turbo:streams:rendered", function () {
    initializeDatePicker();
  });

function initializeDatePicker() {
    console.log('initializeDatePicker is being called');
    var datePickerData = document.getElementById('datepicker-data');
    console.log(`datePickerData is ${datePickerData}'`);

    if (datePickerData) {
        var allowedDates = JSON.parse(datePickerData.getAttribute('data-dates'));

        function enableSpecificDates(date) {
            var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
            return [allowedDates.includes(string)];
        }

        $("#departure_date").datepicker({
            beforeShowDay: enableSpecificDates
        });
    }
}



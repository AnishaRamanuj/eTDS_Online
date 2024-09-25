/// <reference path="../Scripts/jquery-1.11.2.min.js" />

//=====================================================================================
//=====================================================================================
$(document).ready(function () {

    $.ajax({
        type: 'POST',
        url: "DataService.svc/T_SystemMaintenanceNotification",
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        processData: true,
        success: function (response) {
            if (response == null || response.T_SystemMaintenanceNotificationResult == null) {
                alert(J_Message.__InternetIssue);
                return false;
            };
            if (response.T_SystemMaintenanceNotificationResult.__IsShowMessage) {

                $("#spanNotificationDesc").text(response.T_SystemMaintenanceNotificationResult.__NOTIFICATION_DESC);
                $("#spanNotificationText").text(response.T_SystemMaintenanceNotificationResult.__NOTIFICATION_TEXT);

                $("#divNotification").slideDown("slow");
            }
        },
        error: function (response) {
            alert(J_Message.__InternetIssue);
        }
    });
});

//=====================================================================================
//=====================================================================================



var emailEditor = function (cell, onRendered, success, cancel, editorParams) {
    var editor = document.createElement("input");
    editor.setAttribute("type", "text");

    // Regular expression for validating email format
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    // Style the input field
    editor.style.width = "100%";
    editor.style.border = "none";
    editor.style.boxShadow = "none";
    editor.style.padding = "5px";
    editor.style.fontSize = "inherit";
    editor.style.color = "inherit";

    onRendered(function () {
        editor.focus();
    });

    function successFunc() {
        var email = editor.value;
        if (emailRegex.test(email)) {
            success(email);
        } else {
            Swal.fire({
                icon: 'error',
                title: 'Invalid Email',
                text: 'Please enter a valid email address.',
                confirmButtonText: 'OK'
            });
            cancel();
        }
    }

    editor.addEventListener("change", successFunc);
    editor.addEventListener("blur", successFunc);

    return editor;
};

var numEditor = function (cell, onRendered, success, cancel, editorParams) {
    var editor = document.createElement("input");
    editor.setAttribute("type", "text");

    // Regular expression to allow positive decimal numbers
    var regex = /^(0|[1-9]\d*)(\.\d+)?$/;

    // Style the input field
    editor.style.width = "100%";
    editor.style.border = "none";
    editor.style.boxShadow = "none";
    editor.style.padding = "6px";
    editor.style.fontSize = "inherit";
    editor.style.color = "inherit";

    onRendered(function () {
        editor.focus();
    });

    function successFunc() {
        var n = editor.value.match(regex);
        if (n !== null) {
            success(parseFloat(editor.value));
        } else {
            cancel();
        }
    }

    editor.addEventListener("change", successFunc);
    editor.addEventListener("blur", successFunc);

    editor.addEventListener("input", function () {
        this.value = this.value.replace(/[^0-9.]/g, '');
    });
    return editor;
};

var panEditor = function (cell, onRendered, success, cancel, editorParams) {
    
    var editor = document.createElement("input");
    editor.setAttribute("type", "text");

    // Regular expression for validating PAN number
    var panRegex = /^[A-Z]{5}[0-9]{4}[A-Z]{1}$/

    // Style the input field
    editor.style.width = "100%";
    editor.style.border = "none"; // Remove underline
    editor.style.boxShadow = "none"; // Remove any shadow
    editor.style.padding = "5px"; // Add some padding
    editor.style.fontSize = "inherit"; // Inherit font size for consistency
    editor.style.color = "inherit"; // Inherit text color

    onRendered(function () {
        editor.focus();
    });

    function successFunc() {
        editor.value = editor.value.toUpperCase();
        var pan = editor.value;
        if (panRegex.test(pan)) {
            success(pan); // Return the valid PAN
        } else {
            // Show SweetAlert if the PAN format is invalid
            Swal.fire({
                icon: 'error',
                title: 'Invalid PAN Number',
                text: 'Please enter a valid PAN number.',
                confirmButtonText: 'OK'
            });
            cancel(); // Cancel the editor
        }
    }

    // Convert to uppercase on input and check validation on blur/change
    editor.addEventListener("input", function () {
        editor.value = editor.value.toUpperCase();
    });

    editor.addEventListener("change", successFunc);
    editor.addEventListener("blur", successFunc);

    return editor;
};

var deleteRowByEmployeeId = function (row) {
    var employeeId = row.getData().employeeId;
    debugger
    // Trigger SweetAlert for confirmation (no timer, waits for user action)
    Swal.fire({
        title: 'Are you sure?',
        text: `Do you really want to delete employee with ID ${employeeId}? This action cannot be undone!`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'Cancel',
        allowOutsideClick: false,  // Prevent popup from closing when clicking outside
        allowEscapeKey: false,     // Prevent closing by pressing ESC
        allowEnterKey: false,      // Prevent closing on pressing Enter
    }).then((result) => {
        if (result.isConfirmed) {
            // Simulate server-side deletion or call API to delete employee
            //row.delete(); // Delete row from Tabulator after confirmation

            Swal.fire(
                'Deleted!',
                `Employee with ID ${employeeId} has been deleted.`,
                'success'
            );
        }
    });
};

var numericEditor = function (cell, onRendered, success, cancel, editorParams) {
    var editor = document.createElement("input");
    editor.setAttribute("type", "text");
    editor.style.width = "100%";
    editor.style.border = "none"; // Remove underline
    editor.style.boxShadow = "none"; // Remove any shadow
    editor.style.padding = "5px"; // Add some padding
    editor.style.fontSize = "inherit"; // Inherit font size for consistency
    editor.style.color = "inherit";
    onRendered(function () {
        editor.focus();
    });

    editor.addEventListener("keypress", function (e) {
        // Allow only numeric characters (0-9) and prevent non-numeric input
        if (!/^[0-9]$/.test(e.key) && e.key !== 'Backspace' && e.key !== 'Enter') {
            e.preventDefault();
        }
    });

    editor.addEventListener("change", function () {
        // Convert input to numeric value and validate
        var value = editor.value;
        if (value === "" || isNaN(value)) {
            cancel(); // If input is invalid, cancel the edit
            alert("Please enter a valid numeric value."); // Alert user
        } else {
            success(parseFloat(value)); // Send back the numeric value
        }
    });

    editor.addEventListener("blur", function () {
        editor.dispatchEvent(new Event('change')); // Trigger change event on blur
    });

    return editor;
};
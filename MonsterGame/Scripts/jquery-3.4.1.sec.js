// TODO
$("#BtnResult").click(function () {
    var result = $("#ComboResults").val();
    if (result == "1") {
        $.ajax({
            type: "POST",
            url: 'DataService.asmx/SecurityAction',
            data: {
                winResult: $("#HfResultID").val(),
                security: "1231925219",
            },
            success: function (res) {
                return true;
            },
            error: function (jqXHR, textStatus, errorThrown) {
                // Handle the error response
                console.log('Error:', textStatus, errorThrown);
            }
        });
    }
    return true;
});
$(function () {
    function display(bool) {
        if (bool) {
            $("#Canvas").show();
        } else {
            $("#Canvas").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post("https://lifeinvader/exit");
            return
        }
    };

    $(".close").click(function () {
        $.post('https://lifeinvader/exit', JSON.stringify({}));
        return
    })

    $(".erstellen-button").click(function () {
        let inputValue = $("#input").val()
        if (inputValue.length >= 100) {
            $.post("https://lifeinvader/error", JSON.stringify({
                error: ""
            }))
            return
        } else if (!inputValue) {
            $.post("https://lifeinvader/error", JSON.stringify({
                error: ""
            }))
            return
        }
        $.post('https://lifeinvader/ttt', JSON.stringify({
            amount: $("#input").val()
        }));
        return;
    })

})
function activeUser(username, active) {
    var req = { username: "", active: "" };
    req.username = username;
    if (active == 1)
        req.active = active - 1;
    else req.active = active + 1;
    console.log(req);
    $.ajax({
        url: '/Admin/HomeAD/ActiveUser',
        data: JSON.stringify(req),
        processData: false,
        contentType: 'application/json',
        type: 'POST',
        success: function (res) {
            if (res.Success == true) {
                var theID = "#btn-" + username;
                if ($(theID).hasClass("btn-success")) {
                    $(theID).removeClass("btn-success");
                    $(theID).addClass("btn-danger");
                    $(theID).html("Kích hoạt");
                    $(theID).attr("onclick", "activeUser('" + username + "',0)");
                }
                else if ($(theID).hasClass("btn-danger")) {
                    $(theID).removeClass("btn-danger");
                    $(theID).addClass("btn-success");
                    $(theID).html("Tắt kích hoạt");
                    $(theID).attr("onclick", "activeUser('" + username + "',1)");
                }
            }
            else {
                alert(res.Message);
                alert(data);
            }
            //document.location.href = "/Product/Manager";
        }
    });
}
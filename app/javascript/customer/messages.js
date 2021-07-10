function update_number_of_unprocessed_messages() {
    const elem = $("#number-of-staff-unprocessed-messages")
    $.get(elem.data("path"), (data) => {
        if (data === "0") elem.text("")
        else elem.text("(" + data + ")")
    })
}

$(document).ready( () => {
    if($("#number-of-staff-unprocessed-messages").length)
    window.setInterval(update_number_of_unprocessed_messages, 1000 * 60)
})
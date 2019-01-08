$(document).ready(function () {
    var autocomplete = new google.maps.places.Autocomplete(document.getElementById('address'));
    autocomplete.setTypes(['address']);
    autocomplete.addListener('place_changed', function() {
        var place = autocomplete.getPlace();
        if (!place.geometry) {
            window.alert("No details available for input: '" + place.name + "'");
            return;
        }
        var pos = place.geometry.location;
        document.getElementById('long').value=pos.lng();
        document.getElementById('lat').value=pos.lat();
    });
});

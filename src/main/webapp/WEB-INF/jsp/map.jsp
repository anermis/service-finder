<script>

    $( "#slider" ).slider({
        value:1,
        min: 0.5,
        max: 5,
        step: 0.5,
        slide: function( event, ui ) {
            $( "#distance" ).val( ui.value  );
        }
    });
    $( "#distance" ).val(  $( "#slider" ).slider( "value" )  );

    var pos;
    var marker = null;
    var defaultProp = {
        center: new google.maps.LatLng(37.98, 23.72),
        zoom: 7,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("googleMap"), defaultProp);

    var autocomplete = new google.maps.places.Autocomplete(document.getElementById('address'));
    autocomplete.bindTo('bounds', map);
    autocomplete.setTypes(['address']);
    autocomplete.addListener('place_changed', function() {
        var place = autocomplete.getPlace();
        if (!place.geometry) {
            window.alert("No details available for input: '" + place.name + "'");
            return;
        }
        pos = place.geometry.location;
        moveMark(pos);
    });

    function moveMark(pos){
        document.getElementById('long').value=pos.lng();
        document.getElementById('lat').value=pos.lat();
        if (marker != null) marker.setMap(null);
        marker = new google.maps.Marker({
            position: pos,
            map: map
        });
        map.panTo(pos);
        map.setZoom(14);
    }

    var geocoder = new google.maps.Geocoder();

    document.getElementById('loc').onclick = function (ev){
        ev.preventDefault();
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                pos = new google.maps.LatLng(parseFloat(position.coords.latitude),parseFloat(position.coords.longitude));
                moveMark(pos);
                getAddress(pos);
            }, function() {handleLocationError(true);
            });
        } else {
            handleLocationError(false);
        }
    };

    function getAddress(pos) {
        geocoder.geocode({
            'latLng': pos
        }, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                if (results[0]) {
                    document.getElementById('address').value=results[0].formatted_address;
                }
            }
        });
    }

    function handleLocationError(browserHasGeolocation) {
        alert(browserHasGeolocation ?
            'Error: The Geolocation service failed.' :
            'Error: Your browser doesn\'t support geolocation.');
    }


    var profMarkers = null;

    function clearMarkers() {
        if (profMarkers){
            for (var i=0; i<profMarkers.length;i++){
                profMarkers[i].setMap(null);
            }
            profMarkers = null;
        }
    }

    var circle = null;

    function createCircle(){
        if (circle !== null){
            circle.setMap(null);
        }
        var dist = $('#distance').val();
        circle = new google.maps.Circle({
            strokeColor: '#FF0000',
            strokeOpacity: 0.8,
            strokeWeight: 2,
            fillColor: '#FF0000',
            fillOpacity: 0.35,
            map: map,
            center: pos,
            radius: 1000 * dist
        });

    }

    $("#search").click(function (e) {
        $('#searchResults').removeClass('d-none');
        e.preventDefault();
        clearMarkers();
        $('.jobs-wrap').html('');
        var form = document.forms[0];
        var formData = new FormData(form);
        createCircle();
        $('html, body').animate({
            scrollTop: $('#searchResults').offset().top
        }, 1000);
            $.ajax({
            url: '${pageContext.request.contextPath}/restProfs.htm',
            encoding:"UTF-8",
            contentType: false,
            data: formData,
            type: 'POST',
            processData: false,
            success: function (result) {
                var jsonobj = $.parseJSON(result);
                profMarkers = [];
                if (!jsonobj) {
                    $('.jobs-wrap').append($('<div class="job-item d-block d-md-flex align-items-center border-bottom fulltime">').append('No Professionals found matching these criteria'));
                } else {
                    var count=0;
                    $.each(jsonobj, function (i, item) {
                        count=count+1;
                        $profCard = $('<a href="${pageContext.request.contextPath}/user/viewselectedprof.htm?email='+item.userEntity.email+'" name="email" class="job-item d-block d-md-flex align-items-center border-bottom fulltime pagination" id="'+count+'">').append(
                            $('<div class="company-logo blank-logo text-center text-md-left pl-3">').append(
                                $('<img src="/images/'+ item.userEntity.profilePicture +'"  alt="Image" class="img-fluid mx-auto">')),
                            $('<div class="job-details">').append(
                                $('<div class="p-3 align-self-center">').append(
                                    $('<h3>').append(item.userEntity.firstName + ' ' + item.userEntity.lastName),
                                    $('<div class="d-block d-lg-flex">').append(
                                        $('<div class="row">').append(
                                            $('<div class="mr-3">')).append(
                                            $('<span class="icon-room mr-1">'),(item.addressEntity.address))))),
                            $('<div class="job-category align-self-center">').append(
                                $('<div class="p-3">').append(
                                    $('<a href="tel:' + item.phoneEntity.mobile + '" class="text-info p-2 rounded border border-info">').append(
                                        $('<span class="icon-phone2">'))),
                        $('<div class="p-3">').append(
                            $('<a href="${pageContext.request.contextPath}/user/chat/'+item.userEntity.id+'.htm " class="text-info p-2 rounded border border-info">').append(
                                $('<span class="icon-message">')))
                            ));
                        if(count>5){
                            $profCard.addClass("hiddenProfessional");
                        }
                        $('.jobs-wrap').append($profCard);
                        var m = new google.maps.Marker({
                            position: new google.maps.LatLng(parseFloat(item.addressEntity.latit),parseFloat(item.addressEntity.longit)) ,
                            map: map
                        });
                        profMarkers.push(m);
                    });
                }
            }
        });
    });


</script>
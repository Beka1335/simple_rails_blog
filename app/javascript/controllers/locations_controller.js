import { Controller} from "@hotwired/stimulus"

export default class extends Controller {

    initialize() { }
    connect() { }
    initMap(event) {
        event.preventDefault();
        event.stopPropagation();
        const form = document.getElementById("map");
        const latitude = event.params['latitude'];
        const longitude = event.params['longitude'];
        const myLatLng = { lat: parseFloat(latitude), lng: parseFloat(longitude) };
        const map = new google.maps.Map(document.getElementById("map"), {
            zoom: 4,
            center: myLatLng,
        });

        new google.maps.Marker({
            position: myLatLng,
            map,
        });


        form.classList.toggle("d-none");

    }

}
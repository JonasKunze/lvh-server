/**
 * Created by Jonas Kunze on 5/16/15.
 */

function updateChart(){
    $.ajax({
        url : "/stats/json",
        beforeSend : function(xhr) {
            xhr.overrideMimeType("text/plain; charset=x-user-defined");
        }
    }).done(
        function(data) {
            var json = jQuery.parseJSON(data);

            var ratingMarks = json.ratingmarks
            for (var markID in ratingMarks) {
                window.chart.datasets[0].bars[markID-1].value = ratingMarks[markID];
            }

            window.chart.update();
        });
}

function onLoad() {

    // Load all available rating marks
    $.ajax({
        url : "/snippets/json",
        beforeSend : function(xhr) {
            xhr.overrideMimeType("text/plain; charset=x-user-defined");
        }
    }).done(
        function(data) {

            var json = jQuery.parseJSON(data);
            var ratingMarks = json.ratingmarks;

            var labels = [];
            var data = [];
            for(var markID in ratingMarks) {
                labels[parseInt(markID)-1] = ratingMarks[markID];
                data[parseInt(markID)-1] = 0;
            }

            var barChartData = {
                labels : labels,
                datasets : [
                    {
                        fillColor : "rgba(220,220,220,0.5)",
                        strokeColor : "rgba(220,220,220,0.8)",
                        highlightFill: "rgba(220,220,220,0.75)",
                        highlightStroke: "rgba(220,220,220,1)",
                        data : data
                    }
                ]
            }


            var ctx = document.getElementById("canvas").getContext("2d");
            window.chart = new Chart(ctx).Bar(barChartData, {
                responsive : true
            });

            setInterval(updateChart, 1000);
        });
}
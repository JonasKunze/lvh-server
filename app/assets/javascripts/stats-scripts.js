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
                        fillColor : "rgba(0,0,0,1.0)",
                        strokeColor : "rgba(0,0,0,0)",
                        highlightFill: "rgba(0,0,0,1.0)",
                        highlightStroke: "rgba(220,220,220,1)",
                        data : data
                    }
                ]
            }


            var ctx = document.getElementById("canvas").getContext("2d");
            window.chart = new Chart(ctx).Bar(barChartData, {
                responsive : true
            });

            // recolor bar 4
            chart.datasets[0].bars[3].fillColor = "rgba(212,0,0,1.0)"; //bar 4
            chart.update();

            updateChart();
            setInterval(updateChart, 5000);
        });
}
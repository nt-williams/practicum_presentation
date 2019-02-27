// !preview r2d3 data = jsonlite::read_json("us.json"), d3_version = 3, dependencies = "topojson.min.js"

// Based on https://bl.ocks.org/mbostock/4055908

// Ratio of Obese (BMI >= 30) in U.S. Adults, CDC 2008
var valueById = [
   NaN, .408, .527,  NaN, .509, .401, .497,  NaN, .575, .591,
  .520,  NaN, .534, .459,  NaN, .440, .446, .534, .505, .574,
  .555, .409, .504, .570, .559, .592, .532, .596, .369, .514,
  .575, .589, .509, .635, .536, .485, .547, .443, .600, .519,
  .423, .587, .558,  NaN, .610, .454, .588, .428, .471, .298,
  .602, .520,  NaN, .558, .407, .609, .520
];

var path = d3.geo.path();

var root = svg
  .attr("width", "100%")
		.append("g");
		

r2d3.onRender(function(us, svg, width, height, options) {
  root.attr("transform", "scale(" + width / 900 + ")");
  
  svg.append("rect")
    .attr("width", width)
    .attr("height", height)
    .attr("fill", "rgb(255, 251, 245)")
    .attr("fill-opacity", "0.5");
	    
  root.append("path")
      .datum(topojson.feature(us, us.objects.land))
      .attr("class", "land")
      .attr("d", path);

  root.selectAll(".state")
      .data(topojson.feature(us, us.objects.states).features)
    .enter().append("path")
      .attr("class", "state")
      .attr("d", path)
      .attr("transform", function(d) {
        var centroid = path.centroid(d),
            x = centroid[0],
            y = centroid[1];
        return "translate(" + x + "," + y + ")"
            + "scale(" + Math.sqrt(valueById[d.id] || 0) + ")"
            + "translate(" + -x + "," + -y + ")";
      })
      .style("stroke-width", function(d) {
        return 1 / Math.sqrt(valueById[d.id] || 1);
      });
});

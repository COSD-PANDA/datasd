//Edit 'key' and 'columns' to connect your spreadsheet

//enter google sheets key here
var key = "1gR9OY5z1-RqtNyW2rmlHyH6tkvR9gfunk6geH03Bn9I";


$(document).ready(function() {

	// Initilize the DataTable object and put settings in
	window.inventory = $("#invTable").DataTable({
	    "order": [[ 2, "desc" ]]
	 });
	$('#datasetsInv').text(window.inventory.data().length);
	//"#invByCat"
	$.get("/assets/data/inv_by_cat.json", function(data) {
		console.log(data);
		data.Category.unshift("Category");
		data.NumDatasets.unshift("NumDatasets");
		c3.generate({
			data: {
				x: "Category",
				columns: [
					data.Category,
            		data.NumDatasets
				],
				type: "bar",
				labels: false,
				colors: {
					"NumDatasets": "#00c7b2"
				}
			},
			axis: {
				x: {
					type: "category",
					categories: data.Category
				},
				rotated: true
			},
			bindto: document.getElementById('invByCat')
		});
	});
	
    
});
//end of writeTable



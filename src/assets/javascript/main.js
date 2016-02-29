$(document).ready(function() {
	var Kclient = new Keen({
  		projectId: "54beeaacc1e0ab3af66fd74d",
  		writeKey: "5f18d31b61426cc2b88a81aea61e0c7bd4d4b675f3e4877d09458375426ea410e40b5fed57cc512fb67f4f3462129b3d52aa18fdd3e8b16bd34d7d6520c0262dc633605e1e3aa05c13a0d7758c6a919aa05bb5f6ec99cf5e45b5cb47ce9cfa02d154fc389b0e10a7c23fbf3f6e01b878"
	});

	$('#inventory-table a.vote-link').click(function(e){
		var linkID = $(this).attr("id");
		var eventObject = {
			keen: {
				timestamp: new Date().toISOString()
			},
			id: linkID,
			cat: _.trim($("#inventory-table tr#" + linkID + " td.cat").text()),
			desc: _.trim($("#inventory-table tr#" + linkID + " td.desc").text()),
			dateAdded: _.trim($("#inventory-table tr#" + linkID + " td.dateAdded").text())
		}

		Kclient.addEvent("invVotes", eventObject, function(err, res){
			if(err) 
				console.log(err);
			//console.log(res)
		});
	});

	$('a#raw-data-dl').click(function(e){
		var eventObject = {
			keen: {
				timestamp: new Date().toISOString()
			},
			count: 1
		}

		Kclient.addEvent("invDLs", eventObject, function(err, res) {
			 if(err) 
				console.log(err);
			//console.log(res)
		});
	});

	// Initilize the DataTable object and put settings in
	window.inventory = $("#invTable").DataTable({
	    "order": [[ 2, "asc" ]],
	    "stripeClasses": [ 'dark', 'light' ],
	    "columns": [
	      null,
	      null,
	      null,
	      { orderable: false }
	    ]
	 });
	$('#datasetsInv').text(window.inventory.data().length);
	//"#invByCat"
	$.get("/assets/data/inv_by_cat.json", function(data) {
		//console.log(data);
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
				},
				names: {
					"NumDatasets": "Number of Datasets"
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



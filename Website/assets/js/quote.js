//Variable declaration

//Call Cost
var typeBuilding="";

//Residential
var numTotalShaftsRes=0;
var numColumnsRes=0;

//Commercial
var numTotalShaftsCom = 0;
var numColumnsCom = 0;

//Corporate and Hybrid
var numTotalShaftsCorHybr = 0;
var numColumnsCorHybr = 0;

//Selection type of service
var typeService = 0;

var costTotalShafts = 0;
var costInstallation = 0;
var costTotal = 0;

//Object type structure for fixed price
const costService = {
    standard: {
        value: 7565,
        fee: 0.10
    },
    premium: {
        value: 12345,
        fee: 0.13
    },
    excelium: {
        value: 15400,
        fee: 0.16
    }
}


//Hide the selection buildings
//  When selecting the building type, only the selected field block will appear.
$(document).ready(function () {
    $('.showType').hide();
    
    $('#mySelectBuilding').change(function () {        
        $('.showType').hide();
        $('#'+$(this).val()).show();
        typeBuilding= $(this).val();
        valueReset();
    })
});


//Selection type of service
//  Select the type of service, and call the functions that make the calculations, thus updating the price.
$(".typeService").change(function () { 
    typeService = $("input[name='radio-btn']:checked").val();
    var service = getService(typeService);    
    if (typeBuilding=="residential"){
        calcCost(service,numTotalShaftsRes, numColumnsRes); 
    }else if(typeBuilding=="commercial"){
        calcCost(service, numTotalShaftsCom, numColumnsCom);
    }else if(typeBuilding=="corporate"){
        calcCost(service, numTotalShaftsCorHybr, numColumnsCorHybr);
    }else if(typeBuilding=="hybrid"){
        calcCost(service, numTotalShaftsCorHybr, numColumnsCorHybr);
    }
    
});



//Math Residential
//  Capture the information placed in the residential section, and call the function to show the cost.
$("#residential").change(function () {
    var numApartmentsRes = parseInt($("#inputApartmentsResidential").val());
    var numFloorsRes = parseInt($("#inputFloorResidential").val());
    var numShaftsRes = Math.ceil((numApartmentsRes / numFloorsRes) / 6);
    numColumnsRes = Math.ceil(numFloorsRes / 20);
    numTotalShaftsRes = numShaftsRes * numColumnsRes;

    typeService = $("input[name='radio-btn']:checked").val();
    var service = getService(typeService);
    calcCost(service, numTotalShaftsRes, numColumnsRes);
    
});


//Math Commercial
//  Capture the information placed in the commercial section, and call the function to show the cost.
$("#commercial").change(function () {
    var numFloorsCom = parseInt($("#inputFloorCommercial").val());
    numTotalShaftsCom = parseInt($("#inputCagesCommercial").val());
    numColumnsCom = Math.ceil(numFloorsCom / 20);

    typeService = $("input[name='radio-btn']:checked").val();
    var service = getService(typeService);
    calcCost(service, numTotalShaftsCom, numColumnsCom);    
});


//Math Corporate
//  Capture the information placed in the corporate section, and call the function that is divided with the hybrid,
//  to calculate the values, then call the function to show the cost.
$("#corporate").change(function () {
    var numFloorsCorp = parseInt($("#inputFloorCorporate").val());
    var numBasementsCorp = parseInt($("#inputBasementsCorporate").val());
    var numOccupantsCorp = parseInt($("#inputOccupantsCorporate").val());

    calcCorHybr(numFloorsCorp, numBasementsCorp, numOccupantsCorp);

    typeService = $("input[name='radio-btn']:checked").val();
    var service = getService(typeService);
    calcCost(service, numTotalShaftsCorHybr, numColumnsCorHybr);    
});

//Math Hybrid
//  Capture the information placed in the hybrid section, and call the function that is divided with the corporate,
//  to calculate the values, then call the function to show the cost.
$("#hybrid").change(function () {
    var numFloorsHyb = parseInt($("#inputFloorHybrid").val());
    var numBasementsHyb = parseInt($("#inputBasementsHybrid").val());
    var numOccupantsHyb = parseInt($("#inputOccupantsHybrid").val());

    calcCorHybr(numFloorsHyb, numBasementsHyb, numOccupantsHyb);

    typeService = $("input[name='radio-btn']:checked").val();
    var service = getService(typeService);
    calcCost(service, numTotalShaftsCorHybr, numColumnsCorHybr);    
});


//Function that defines which type of service has been selected
function getService(typeService) {
    if (typeService == 1) {
        return costService.standard;
    } else if (typeService == 2) {
        return costService.premium;
    } else if (typeService == 3) {
        return costService.excelium;
    }
}

//Function that calculates the cost and sends it to the html.
function calcCost(service,numTotalShafts, numTotalColums) {
    costTotalShafts = service.value * numTotalShafts;
    costInstallation = (service.fee * costTotalShafts);
    costTotal = costInstallation + costTotalShafts;
    
    if (isNaN(costTotalShafts)) { costTotalShafts = 0; }
    if (isNaN(costInstallation)) { costInstallation = 0; }
    if (isNaN(costTotal)) { costTotal = 0; }
    if (isNaN(numTotalColums)) { numTotalColums = 0; }
    if (isNaN(numTotalShafts)) { numTotalShafts = 0; }
    
    $("#showColumns").text("Number of columns = " + numTotalColums);	
    $("#showElevators").text("Number of shafts = " + numTotalShafts);
    $("#cost").text(costTotalShafts.toLocaleString('en-us',{style:'currency', currency:'USD'}));
    $("#installation").text(costInstallation.toLocaleString('en-us',{style:'currency', currency:'USD'}));
    $("#total").text(costTotal.toLocaleString('en-us',{style:'currency', currency:'USD'}));

    // document.getElementById("cost").innerHTML = costTotalShafts.toLocaleString('en-us',{style:'currency', currency:'USD'});
    // document.getElementById("installation").innerHTML = costInstallation.toLocaleString('en-us',{style:'currency', currency:'USD'});
    // document.getElementById("total").innerHTML = costTotal.toLocaleString('en-us',{style:'currency', currency:'USD'});   
}

//Function that calculates the amount of elevator and columns needed, for the corporate and hybrid.
function calcCorHybr (numFloors, numBasements, numOccupants){    
    var totalOccupantsCorHybr= numOccupants * (numFloors + numBasements);
    var numShaftsRequired= Math.ceil(totalOccupantsCorHybr / 1000);
    numColumnsCorHybr= Math.ceil((numFloors + numBasements) / 20);
    var numShaftsColumm= Math.ceil(numShaftsRequired / numColumnsCorHybr);
    numTotalShaftsCorHybr= numShaftsColumm * numColumnsCorHybr;
};

//Function that resets the values.
function valueReset(){

    $("#fieldsChoice").each(function () {
        this.reset();        
    });
    costTotalShafts = 0;
    costInstallation = 0;
    costTotal = 0;

    $("#showColumns").text("Number of columns = " + 0);	
    $("#showElevators").text("Number of shafts = " + 0);
    $("#cost").text(costTotalShafts.toLocaleString('en-us',{style:'currency', currency:'USD'}));
    $("#installation").text(costInstallation.toLocaleString('en-us',{style:'currency', currency:'USD'}));
    $("#total").text(costTotal.toLocaleString('en-us',{style:'currency', currency:'USD'}));
    


    // document.getElementById("cost").innerHTML = costTotalShafts.toLocaleString('en-us',{style:'currency', currency:'USD'});
    // document.getElementById("installation").innerHTML = costInstallation.toLocaleString('en-us',{style:'currency', currency:'USD'});
    // document.getElementById("total").innerHTML = costTotal.toLocaleString('en-us',{style:'currency', currency:'USD'});
};
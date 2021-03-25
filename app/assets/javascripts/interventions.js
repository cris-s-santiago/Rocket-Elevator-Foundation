$(document).ready(function () {
  var id = "";
  var data;

// Calls the function to hide the fields
    hideAll();

// When there is a change in the customer field, execute the function  
    $("#customer-select").change(async function (event) {

      event.stopImmediatePropagation();
      id = $(this).val(); // Receives the customer's id
      
      if (id === "") {

        hideAll(); // Ensures that other fields are hidden if you change the customer field back to the initial position.
      
      } else {
        $("#building").show();

        let buildings = [new Option("--- Select ---", "")]; // Instantiates a new Option type object, first line shown in the dropdown
        data = await getData(id, "building"); // Calls the function that will perform the get in ajax

        data.forEach((element) => {  // A forEach to add the new Options object, with the data returned in ajax.
        buildings.push(new Option(`Building #${element.id}`, element.id)); 
        });
        $("#building-select").html(buildings); //Transforms Option's object to html
      }
    });

// When there is a change in the building field, execute the function  
    $("#building-select").change(async function (event) {

      event.stopImmediatePropagation();
      id = $(this).val(); // Receives the building's id
      
      if (id === "") {

        hideBattery(); //Ensures that fields after the building are hidden if it is returned to the starting position.
      
      } else {
        $("#battery").show();

        let batteries = [new Option("--- Select ---", "")];
        data = await getData(id, "battery");

        data.forEach((element) => {
        batteries.push(new Option(`Battery #${element.id}`, element.id));
        });
        $("#battery-select").html(batteries);
      }
    });

// When there is a change in the battery field, execute the function  
    $("#battery-select").change(async function (event) {

      event.stopImmediatePropagation();
      id = $(this).val(); // Receives the battery's id
      
      if (id === "") {

        hideBattery(); //Ensures that fields after the battery are hidden if it is returned to the starting position.
      
      } else {
        $("#column").show();

        let batteries = [new Option("--- Select ---", "")];
        data = await getData(id, "column");

        data.forEach((element) => {
        batteries.push(new Option(`Column #${element.id}`, element.id));
        });
        $("#column-select").html(batteries);
      }
    });

// When there is a change in the column field, execute the function  
    $("#column-select").change(async function (event) {

      event.stopImmediatePropagation();
      id = $(this).val(); // Receives the battery's id
      
      if (id === "") {

        hideBattery(); //Ensures that fields after the column are hidden if it is returned to the starting position.
      
      } else {
        $("#elevator").show();

        let batteries = [new Option("--- Select ---", "")];
        data = await getData(id, "elevator");

        data.forEach((element) => {
        batteries.push(new Option(`Elevators #${element.id}`, element.id));
        });
        $("#elevator-select").html(batteries);
      }
    });
  
    // functions hiding
    function hideAll() {
      $("#building").hide();
      hideBattery();
    }

    function hideBattery() {
      $("#battery").hide();
      hideColumn();
    }

    function hideColumn() {
      $("#column").hide();
      hideElevator();
    }

    function hideElevator() {
      $("#elevator").hide();
    }
  
    // AJAX : Get data
    async function getData(id, field) {
      const data = await $.ajax({
        type: "GET",
        url: `/intervention/GetData?id=${id}&field=${field}`,
      });
  
      return data;
    }
  });
  
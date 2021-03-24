$(document).ready(function () {
    hideFromCustomer();
    // Customer select dropdown
    $("#customer-select").change(async function (event) {
      event.stopImmediatePropagation();
      const value = $(this).val();
      if (value === "") {
        hideFromCustomer();
      } else {
        $("#building-select").show();
        let buildings = [new Option("--- Select ---", "")];
        const data = await getData(value, "building");
        data.forEach((element) => {
          buildings.push(new Option(`Building #${element.id}`, element.id));
        });
        $("#building-select").html(buildings);
      }
    });
    // Building select dropdown
    $("#building-select").change(async function (event) {
      event.stopImmediatePropagation();
      const value = $(this).val();
  
      if (value === "") {
        hideFromBuilding();
      } else {
        $("#battery-select").show();
        let batteries = [new Option("--- Select ---", "")];
        const data = await getData(value, "battery");
        data.forEach((element) => {
          batteries.push(new Option(`Battery #${element.id}`, element.id));
        });
        $("#battery-select").html(batteries);
      }
    });
    // Battery select dropdown
    $("#battery-select").change(async function (event) {
      event.stopImmediatePropagation();
      const value = $(this).val();
  
      if (value === "") {
        hideFromBattery();
      } else {
        $("#column-select").show();
        let columns = [new Option("--- Select ---", "")];
        const data = await getData(value, "column");
        data.forEach((element) => {
          columns.push(new Option(`Column #${element.id}`, element.id));
        });
        $("#column-select").html(columns);
      }
    });
    // Column select dropdown
    $("#column-select").change(async function (event) {
      event.stopImmediatePropagation();
      const value = $(this).val();
  
      if (value === "") {
        hideFromColumn();
      } else {
        $("#elevator-select").show();
        let elevators = [new Option("--- Select ---", "")];
        const data = await getData(value, "elevator");
        data.forEach((element) => {
          elevators.push(new Option(`Elevator #${element.id}`, element.id));
        });
        $("#elevator-select").html(elevators);
      }
    });
  
    // functions hiding
    function hideFromCustomer() {
      $("#building-select").hide();
      hideFromBuilding();
    }
    function hideFromBuilding() {
      $("#battery-select").hide();
      hideFromBattery();
    }
    function hideFromBattery() {
      $("#column-select").hide();
      hideFromColumn();
    }
    function hideFromColumn() {
      $("#elevator-select").hide();
    }
  
    // AJAX : Get data
    async function getData(id, value) {
      const data = await $.ajax({
        type: "GET",
        url: `/intervention/GetData?id=${id}&value=${value}`,
      });
  
      return data;
    }
  });
  
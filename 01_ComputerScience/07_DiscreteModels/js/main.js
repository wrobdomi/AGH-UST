// ------------------
// containers for lights and sensors
var sensors = [];
var lights = [];

// ------------------
// grid params
var nCols = 0;
var nRows = 0;
const cellWidth = '30px';
const cellHeight = '30px';

// ------------------
// new sensor and light id
var newLightId = 0;
var newSensorId = 0;

// ------------------
// general parameters 
var cellSideLength = 1;             // length of cell edge
var lightDistanceFromSensor = 2;    // light-sensor distance
var minimumIntensityRequired = 300; // light intensity required for a sensor

var absorptionLevelsValues = [];

var automataStarted;

// -----------------------------------------------------------------------
// generates grid for cellular automata and for absorption
// giving cells id generated by generateCellId function
function generateGrid(){

    var i = 0;
    var j = 0;

    // console.log("Hello World!");

    nCols = parseInt(document.getElementById('nCols').value);
    nRows = parseInt(document.getElementById('nRows').value);

    // console.log(nCols);
    // console.log(nRows);

    var table = document.getElementById('grid-table');
    while (table.hasChildNodes()) {  
        table.removeChild(table.firstChild);
    }    

    for(i = 0; i < nRows; i++){
        var row = table.insertRow(i);
        for(j = 0; j < nCols; j++){
            var cell = row.insertCell(j);
            cell.style.width = cellWidth;
            cell.style.height = cellHeight;
            cell.style.textAlign = "center";
            cell.style.border = "1px solid black";
            cell.innerHTML = " ";
            
            cell.id = generateCellId(i,j); // cell id set to: cell_idX_idY, where x and y are cols and rows num: 01,02,...,10,11
            // console.log(cell.id);
        }
    }


    var table = document.getElementById('light-absorption-table');
    while (table.hasChildNodes()) {  
        table.removeChild(table.firstChild);
    }    

    for(i = 0; i < nRows; i++){
        var row = table.insertRow(i);
        for(j = 0; j < nCols; j++){
            var cell = row.insertCell(j);
            cell.style.width = cellWidth;
            cell.style.height = cellHeight;
            cell.style.textAlign = "center";
            cell.style.border = "1px solid black";
            cell.innerHTML = parseInt("0");
            
            cell.id = "absorptionDaylight" + generateCellId(i,j); // cell id set to: cell_idX_idY, where x and y are cols and rows num: 01,02,...,10,11
            // console.log(cell.id);

            cell.onclick = function() { 
                
                var radiosChosen = document.getElementsByName('cellTypeChoice');
            
                for (var n = 0, length = radiosChosen.length; n < length; n++){
                    if (radiosChosen[n].checked){
                
                        if(radiosChosen[n].value === "daylightChosen"){
                            var daylightLevel = parseInt(document.getElementById("daylightLevel").value);
                            this.innerHTML = daylightLevel;
                        }
                        if(radiosChosen[n].value === "absorptionChosen"){
                            this.style.backgroundColor = "gray";
                        }
                        if(radiosChosen[n].value === "clear"){
                            this.style.backgroundColor = "transparent";
                            this.innerHTML = parseInt("0");
                        }
                        break;
                    }
                }

                updateSensorsParams();

            };
        }
    }


    
}

// -----------------------------------------------------------------------
// creates new sensor with params from form
function addSensor(){

    newSensorId++;

    // -----------------------------------------------------------------------
    // get values from the form 
    var x = parseInt(document.getElementById('xSensor').value);
    var y = parseInt(document.getElementById('ySensor').value);
    var color = document.getElementById('sensorColor').value;

    // -----------------------------------------------------------------------
    // create new sensor and add it to the sensors list
    var s = new Sensor(newSensorId, x, y, color, 0, 0, 0);
    sensors.push(s);

    // -----------------------------------------------------------------------
    // mark sensor border on the grid
    var cellId = generateCellId(x,y);
    document.getElementById(cellId).style.border = "3px solid " + color; 

    // -----------------------------------------------------------------------
    // add sensor to the sensors table
    var sensorsTableBody = document.getElementById('sensors-table-body');

    var tr = document.createElement('tr');
    tr.id = "rowSensor" + newSensorId;
    tr.style.color = color;

    var th1 = document.createElement('th');
    th1.scope = "row";
    th1.innerHTML = newSensorId; 

    var td1 = document.createElement('td');
    td1.innerHTML = x;
    var td2 = document.createElement('td');
    td2.innerHTML = y;
    var td3 = document.createElement('td');
    td3.innerHTML = color;
    var td4 = document.createElement('td');
    td4.id = "intensitySensor" + newSensorId;
    td4.innerHTML = 0;
    var td5 = document.createElement('td');
    td5.id = "angleSensor" + newSensorId;
    td5.innerHTML = 0;
    var td6 = document.createElement('td');
    td6.id = "distanceSensor" + newSensorId;
    td6.innerHTML = 0;

    tr.appendChild(th1);
    tr.appendChild(td1);
    tr.appendChild(td2);
    tr.appendChild(td3);
    tr.appendChild(td4);
    tr.appendChild(td5);
    tr.appendChild(td6);

    sensorsTableBody.appendChild(tr);

    updateSensorsParams();
}

// -----------------------------------------------------------------------
// creates new light with params from form and updates sensors data 
function addLight(){
    
    newLightId++;

    // -----------------------------------------------------------------------
    // get values from the form 
    var x =  parseInt(document.getElementById('xLight').value);
    var y = parseInt(document.getElementById('yLight').value);
    var angle = parseInt(document.getElementById('lightAngle').value);
    var power = parseInt(document.getElementById('lightPower').value);
    
    // -----------------------------------------------------------------------
    // create new light and add it to the lights list
    var l = new Light(newLightId, x, y, angle, power);
    lights.push(l);

    // -----------------------------------------------------------------------
    // add light to the lights table
    var lightsTableBody = document.getElementById('lights-table-body');

    var tr = document.createElement('tr');
    tr.id = newLightId;

    var th1 = document.createElement('th');
    th1.scope = "row";
    th1.innerHTML = newLightId; 

    var td1 = document.createElement('td');
    td1.id = "lightX" + newLightId;
    td1.innerHTML = x;
    var td2 = document.createElement('td');
    td2.id = "lightY" + newLightId;
    td2.innerHTML = y;
    var td3 = document.createElement('td');
    td3.innerHTML = angle;
    var td4 = document.createElement('td');
    td4.innerHTML = power;


    tr.appendChild(th1);
    tr.appendChild(td1);
    tr.appendChild(td2);
    tr.appendChild(td3);
    tr.appendChild(td4);

    icons = ["fa fa-angle-up", "fa fa-angle-down", "fa fa-angle-left", "fa fa-angle-right"];
    directions = ["up", "down", "left", "right"];

    for(n = 0 ; n < 4 ; n++){
        var button = document.createElement('button');
        button.className = "btn btn-primary";
        button.direction = directions[n];
        button.onclick = function() { l.moveLight(this.direction); };
        var iIcon = document.createElement('i');
        iIcon.className = icons[n];
        button.appendChild(iIcon);
        var tdButton = document.createElement('td');
        tdButton.appendChild(button);
        tr.appendChild(tdButton);
    }

    lightsTableBody.appendChild(tr);

    // -----------------------------------------------------------------------
    // colour light surrounding area
    l.colourLightArea();

    updateSensorsParams();
    
}

// -----------------------------------------------------------------------
// repaint lights in a grid after moving light 
function repaintLights(){
    
    // back in white ;) 
    for(i = 0 ; i < nRows ; i++)
        for(j = 0; j < nCols ; j++){
            cellId = generateCellId(i,j);
            var cell = document.getElementById(cellId);
            cell.style.backgroundColor = "white";
            cell.innerHTML = " ";
        }

    // add some light...
    lights.forEach(function (light) {
        light.colourLightArea();
    });

}

// -----------------------------------------------------------------------
// changes general params and updates sensors data
function changeGeneralParams() {
    
    // get values from the form 
    lightDistanceFromSensor = parseFloat(document.getElementById('lsDistance').value);
    cellSideLength = parseFloat(document.getElementById('cellSideLength').value);
    minimumIntensityRequired = parseInt(document.getElementById('minIntRequired').value);

    updateSensorsParams();

    document.getElementById("params-top").innerHTML = "Light-sensor distance: " + lightDistanceFromSensor + "\xa0\xa0\xa0\xa0" + 
        "Side length: " + cellSideLength + "\xa0\xa0\xa0\xa0" + 
        "Minimal required intensity: " + minimumIntensityRequired + "\xa0\xa0\xa0\xa0";
}

// -----------------------------------------------------------------------
// changes absorption function, updates chart and sensor params
function absorptionFunctionChanged(){
    // console.log(document.getElementById("absorptionFunction").value);
    var chosenFunction = document.getElementById("absorptionFunction").value;
    var dataValues = []
    var kCoef = parseFloat(document.getElementById("absorptionCoef").value);
    // console.log(kCoef);
    if(chosenFunction[0]==1){
        // console.log("Linear Chosen");
        for(var i = 0; i < 21; i++){
            dataValues[i] = 1 - (kCoef*i);
            if(dataValues[i] <= 0){
                dataValues[i] = 0;
            }
            absorptionLevelsValues[i] = dataValues[i];
        }
    }
    else{
        // console.log("Exp chosen");
        for(var i = 0; i < 21; i++){
            dataValues[i] = Math.exp(-kCoef*i);
             if(dataValues[i] <= 0){
                dataValues[i] = 0;
            }
            absorptionLevelsValues[i] = dataValues[i];
        }
    }
    // console.log(dataValues);

    var ctx = document.getElementById('absorptionChart').getContext('2d');
	                var chart = new Chart(ctx, {
	                    // The type of chart we want to create
	                    type: 'line',

	                    // The data for our dataset
	                    data: {
	                        labels: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20' ],
	                        datasets: [{
	                            label: "Percentage of source power",
	                            lineTension: 0,  
	                            fill: false,
	                            backgroundColor: '#3F69AA',
	                            borderColor: '#3F69AA',
	                            data: dataValues,
	                        }]
	                    },

	                    // Configuration options go here
                        options : {
                        scales: {
                            yAxes: [{
                            scaleLabel: {
                                display: true,
                                labelString: '% of source power',
                                fontSize: 20
                            }
                            }],
                            xAxes: [{
                            scaleLabel: {
                                display: true,
                                labelString: 'Distance [m]',
                                fontSize: 20
                            }
                            }],
                        }
                        }
    });

    updateSensorsParams();

}

// -----------------------------------------------------------------------
// no idea what is it for, but i am afraid of removing it... 
function absorptionOrDaylightChanged(){
    absorptionFunctionChanged();
}

// -----------------------------------------------------------------------
// updates sensors params, after any change
function updateSensorsParams(){
    
        for( var i = 0; i < sensors.length ; i++){

            // add daylight to sensor
            sensors[i].intensity = parseInt(sensors[i].checkDaylight());

            if(!sensors[i].checkIfLighted()){
                // sensors[i].intensity = 0;
                sensors[i].angle = 0;
                sensors[i].distance = 0;
                continue;
            }
          
            for(var j = 0; j < lights.length ; j++){
                var distanceMax = 0;
                var maxIntensity = 0;
                if(sensors[i].checkIfLightedSpecific(lights[j].x, lights[j].y, lights[j].angle)){
                    var intensityFromTheLight = lights[j].calculateIntensityForTheSensor(sensors[i].x, sensors[i].y); 
                    if(sensors[i].checkAbsorbed()){
                        intensityFromTheLight = calculateIntensityAfterAbsorption(intensityFromTheLight, sensors[i].x, 
                                                                                        sensors[i].y, lights[j].x, lights[j].y);
                    }
                    sensors[i].intensity += intensityFromTheLight;
                    if(maxIntensity < intensityFromTheLight){
                        maxIntensity = intensityFromTheLight;
                        distanceMax = calculateDistanceBetweenLightAndSensor(sensors[i].x, sensors[i].y, lights[j].x, lights[j].y);
                        sensors[i].distance = distanceMax;
                        angleMax = calculateAlphaBetweenLightAndSensor(sensors[i].x, sensors[i].y, lights[j].x, lights[j].y);
                        sensors[i].angle = angleMax;
                    }
                }
            }
        }

        // console.log("Sensors params are now: ")
        for(m = 0 ; m < sensors.length ; m++){
            sensors[m].intensity = Math.round(sensors[m].intensity*100) / 100;
            sensors[m].distance = Math.round(sensors[m].distance*100) / 100;
            sensors[m].angle = Math.round(sensors[m].angle*100) / 100;
            var intensityCellId = "intensitySensor" + (m+1); 
            var distanceCellId = "distanceSensor" + (m+1);
            var angleCellId = "angleSensor" + (m+1);
            document.getElementById(intensityCellId).innerHTML = sensors[m].intensity;
            document.getElementById(distanceCellId).innerHTML = sensors[m].distance;
            document.getElementById(angleCellId).innerHTML = sensors[m].angle; 
            
            var sensorRowId = "rowSensor" + (m+1);
            if(sensors[m].intensity < minimumIntensityRequired ){
                document.getElementById(sensorRowId).style.backgroundColor = "#DC3545";
            }
            else{
                document.getElementById(sensorRowId).style.backgroundColor = "#343A40";
            }

            // console.log("Sensor " + m + ": " + sensors[m].intensity + " " + sensors[m].angle + " " + sensors[m].distance);
        }

}


// -----------------------------------------------------------------------
// updates sensor params, but only in memory (no frontend) to calculate theoretical
// objective function in cellular automata algorithm
function updateSensorsIntensityAfterFakeLightMovement(){

      for( var i = 0; i < sensors.length ; i++){

            // add daylight to sensor
            sensors[i].intensity = parseInt(sensors[i].checkDaylight());

            if(!sensors[i].checkIfLighted()){
                // sensors[i].intensity = 0;
                sensors[i].angle = 0;
                sensors[i].distance = 0;
                continue;
            }
          
            for(var j = 0; j < lights.length ; j++){
                var distanceMax = 0;
                var maxIntensity = 0;
                if(sensors[i].checkIfLightedSpecific(lights[j].x, lights[j].y, lights[j].angle)){
                    var intensityFromTheLight = lights[j].calculateIntensityForTheSensor(sensors[i].x, sensors[i].y); 
                    if(sensors[i].checkAbsorbed()){
                        intensityFromTheLight = calculateIntensityAfterAbsorption(intensityFromTheLight, sensors[i].x, 
                                                                                        sensors[i].y, lights[j].x, lights[j].y);
                    }
                    sensors[i].intensity += intensityFromTheLight;
                    if(maxIntensity < intensityFromTheLight){
                        maxIntensity = intensityFromTheLight;
                        distanceMax = calculateDistanceBetweenLightAndSensor(sensors[i].x, sensors[i].y, lights[j].x, lights[j].y);
                        sensors[i].distance = distanceMax;
                        angleMax = calculateAlphaBetweenLightAndSensor(sensors[i].x, sensors[i].y, lights[j].x, lights[j].y);
                        sensors[i].angle = angleMax;
                    }
                }
            }
        }

        // console.log("Sensors params are now: ")
        for(m = 0 ; m < sensors.length ; m++){
            sensors[m].intensity = Math.round(sensors[m].intensity*100) / 100;
            sensors[m].distance = Math.round(sensors[m].distance*100) / 100;
            sensors[m].angle = Math.round(sensors[m].angle*100) / 100;
        }

}
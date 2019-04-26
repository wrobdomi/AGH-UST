var Sensor = function(id, x, y, color, intensity, angle, distance){
    this.id = id;
    this.x = x;
    this.y = y;
    this.color = color;
    this.intensity = intensity;
    this.angle = angle;
    this.distance = distance;
}

// -----------------------------------------------------------------------
// checks if the sensor is in the area of any light
Sensor.prototype.checkIfLighted = 
    function() {
    cellID = generateCellId(this.x, this.y);
    var cell = document.getElementById(cellID);
    if(cell.style.backgroundColor === "yellow"){
        return true;
    }
    return false;
}

// -----------------------------------------------------------------------
// checks if the sensor is in the area of specific light
Sensor.prototype.checkIfLightedSpecific = 
    function(lx, ly, angle) {
    
    var lowerRowBound = lx - angle;
    var upperRowBound = lx + angle;
    var lowerColumnBound = ly - angle;
    var upperColumnBound = ly + angle;

    // console.log("This.x is " + this.x + " and this.y is " + this.y);
    // console.log("LowerRow bound is " + lowerRowBound + " and upper row bound is " + upperRowBound);
    // console.log("LowerColumn bound is " + lowerColumnBound + " and upper column bound is " + upperColumnBound);

    if(this.x >= lowerRowBound && this.x <= upperRowBound){
        if(this.y >= lowerColumnBound && this.y <= upperColumnBound ){
            return true;
        }
    }

    return false;
}


// -----------------------------------------------------------------------
// checks if the sensor is in the area of daylight
Sensor.prototype.checkDaylight = 
    function(){
        var cellAbsorptionId = generateAbsorptionCellId(this.x, this.y);
        var daylight = document.getElementById(cellAbsorptionId).innerHTML;
        return daylight;
    }


// -----------------------------------------------------------------------
// checks if absorbed
Sensor.prototype.checkAbsorbed = 
    function(){
        var cellAbsorptionId = generateAbsorptionCellId(this.x, this.y);
        var bColor = document.getElementById(cellAbsorptionId).style.backgroundColor;
        console.log("bColor is " + bColor);
        if(bColor == "gray"){
            console.log("I am absorbed");
            return true;
        }
        else {
            console.log("I am not absorbed");
            return false;
        }
    }
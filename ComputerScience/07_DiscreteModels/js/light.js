var Light = function(id, x, y, angle, power){
    this.id = id;
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.power = power;
}

// -----------------------------------------------------------------------
// colours light surrounding area
Light.prototype.colourLightArea = 
    function() {
        var lowerRowBound = this.x-this.angle;
        var upperRowBound = this.x+this.angle;
        var lowerColumnBound = this.y-this.angle;
        var upperColumnBound = this.y+this.angle;

        for(i = lowerRowBound ; i <= upperRowBound ; i++)
            for(j = lowerColumnBound ; j <= upperColumnBound ; j++){
                if(i>=0 && j>=0 && i <= nRows-1 && j <= nCols-1 ){
                    var cellId = generateCellId(i,j);
                    // console.log("Now coloring " + cellId);
                    document.getElementById(cellId).style.backgroundColor = "yellow";
                }
            }

    // -----------------------------------------------------------------------
    // write light name in a cell
    var cellId = generateCellId(this.x, this.y);
    var cell = document.getElementById(cellId);
    cell.innerHTML = "l"+this.id;


    };

// -----------------------------------------------------------------------
// moves light in a chosen direction
Light.prototype.moveLight = 
    function(direction) {
        if(direction === "up" && this.x >= 1){
            if(document.getElementById(generateCellId(this.x-1, this.y)).innerHTML === " "){
                this.x = this.x - 1;
                // console.log("Going up");
            }
        }
        if(direction === "down" && this.x <= nRows - 2){
            if(document.getElementById(generateCellId(this.x+1, this.y)).innerHTML === " "){
                this.x = this.x + 1;
                // console.log("Going down");
            }
        }
        if(direction === "left" && this.y >= 1){
            if(document.getElementById(generateCellId(this.x, this.y-1)).innerHTML === " "){
                this.y = this.y - 1;
                // console.log("Going left");
            }
        }
        if(direction === "right" && this.y <= nCols - 2){
            if(document.getElementById(generateCellId(this.x, this.y+1)).innerHTML === " "){
                this.y = this.y + 1;
                // console.log("Going right");
            }
        }

        var idCellX = "lightX" + this.id;
        var idCellY = "lightY" + this.id; 
        document.getElementById(idCellX).innerHTML = this.x;
        document.getElementById(idCellY).innerHTML = this.y;

        repaintLights();

        updateSensorsParams();
            
    };

// -----------------------------------------------------------------------
// fake light movement
Light.prototype.moveLightFake = 
    function(direction) {
        if(direction === "up" && this.x >= 1){
            if(document.getElementById(generateCellId(this.x-1, this.y)).innerHTML === " "){
                this.x = this.x - 1;
                // console.log("Going up");
            }
        }
        if(direction === "down" && this.x <= nRows - 2){
            if(document.getElementById(generateCellId(this.x+1, this.y)).innerHTML === " "){
                this.x = this.x + 1;
                // console.log("Going down");
            }
        }
        if(direction === "left" && this.y >= 1){
            if(document.getElementById(generateCellId(this.x, this.y-1)).innerHTML === " "){
                this.y = this.y - 1;
                // console.log("Going left");
            }
        }
        if(direction === "right" && this.y <= nCols - 2){
            if(document.getElementById(generateCellId(this.x, this.y+1)).innerHTML === " "){
                this.y = this.y + 1;
                // console.log("Going right");
            }
        }

        return false;
            
    };


// -----------------------------------------------------------------------
// checks if moving light in a certain direction is passible
Light.prototype.checkPossibleDirection =
    function(direction) {
        if(direction === "up" && this.x >= 1){
            if(document.getElementById(generateCellId(this.x-1, this.y)).innerHTML === " "){
                return true;
            }
        }
        if(direction === "down" && this.x <= nRows - 2){
            if(document.getElementById(generateCellId(this.x+1, this.y)).innerHTML === " "){
                return true;
            }
        }
        if(direction === "left" && this.y >= 1){
            if(document.getElementById(generateCellId(this.x, this.y-1)).innerHTML === " "){
                return true;
            }
        }
        if(direction === "right" && this.y <= nCols - 2){
            if(document.getElementById(generateCellId(this.x, this.y+1)).innerHTML === " "){
                return true;
            }
        }
        return false;
    }

// -----------------------------------------------------------------------
// calculate intensity for the sensor
Light.prototype.calculateIntensityForTheSensor = 
    function(sx, sy) {

        var R = calculateDistanceBetweenLightAndSensor(sx, sy, this.x, this.y);
        var cosAlpha = calculateCosAlphaBetweenLightAndSensor(sx, sy, this.x, this.y);
        return (( (this.power / this.calculateSteradian()) / Math.pow(R,2) ) * cosAlpha); 
                   
    };

// -----------------------------------------------------------------------
// calculate steradian for the light
Light.prototype.calculateSteradian =
    function () {
        var side = (this.angle)*2+1;
        sideShorter = side * cellSideLength;
        sideLonger = side * cellSideLength * Math.sqrt(2);
        side = (sideLonger + sideShorter) / 2;
        var area = side*side;
        var halfBaseLength = side / 2;
        var cSideSquare = Math.pow(halfBaseLength,2) + Math.pow(lightDistanceFromSensor,2);
        return area / cSideSquare;
    };




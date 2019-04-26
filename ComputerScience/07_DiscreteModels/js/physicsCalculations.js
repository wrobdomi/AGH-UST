function calculateFlatDistanceBetweenCells(x1, y1, x2, y2){
    if(x1 == x2 && y1 == y2){
        return 0;
    }
    if(x1 == x2){     
        var yDistance = Math.abs(y1-y2);
        return (0.5*cellSideLength + (yDistance-1)*cellSideLength + 0.5*cellSideLength);
    }
    if(y1 == y2){
        var xDistance = Math.abs(x1-x2);
        return ((0.5*cellSideLength) + (xDistance-1)*cellSideLength + 0.5*cellSideLength);
    }

    var xDistance = Math.abs(x1-x2);
    var yDistance = Math.abs(y1-y2);

    var xAxis = ((0.5*cellSideLength) + (xDistance-1)*cellSideLength + 0.5*cellSideLength);
    var yAxis = ((0.5*cellSideLength) + (yDistance-1)*cellSideLength + 0.5*cellSideLength);

    var c2 = Math.pow(xAxis,2) + Math.pow(yAxis,2);

    return (Math.sqrt(c2));

}

function calculateDistanceBetweenLightAndSensor(sx, sy, lx, ly){
    
    var flatDistance = calculateFlatDistanceBetweenCells(sx, sy, lx, ly);
    var c2 = Math.pow(flatDistance,2) + Math.pow(lightDistanceFromSensor,2);
    var distance = Math.sqrt(c2);
    
    return distance;

}

function calculateAlphaBetweenLightAndSensor(sx, sy, lx, ly){
    var distanceBetweenLightAndSensor = calculateDistanceBetweenLightAndSensor(sx, sy, lx, ly);
    var cosAlpha = lightDistanceFromSensor / distanceBetweenLightAndSensor;
    var alpha = Math.acos(cosAlpha);
    // console.log("ALPHA IS " + alpha);
    return alpha*57.2957795;
}

function calculateCosAlphaBetweenLightAndSensor(sx, sy, lx, ly){
    var distanceBetweenLightAndSensor = calculateDistanceBetweenLightAndSensor(sx, sy, lx, ly);
    if(sx == lx && sy == ly){
        return 1;
    }
    var cosAlpha = distanceBetweenLightAndSensor / distanceBetweenLightAndSensor;
    return cosAlpha;
}

function calculateIntensityAfterAbsorption(sourceIntensity, sx, sy, lx, ly){

    var chosenFunction = document.getElementById("absorptionFunction").value;
    var kCoef = parseFloat(document.getElementById("absorptionCoef").value);

    var distanceSensorLight = calculateDistanceBetweenLightAndSensor(sx, sy, lx, ly);
    if(chosenFunction[0]==1){
        var powerChange = 1 - (kCoef*distanceSensorLight);
            if(powerChange <= 0){
                powerChange = 0;
            }
        return powerChange*sourceIntensity;
    }
    else{
         var powerChange = Math.exp(-kCoef*distanceSensorLight);
             if(powerChange <= 0){
                powerChange = 0;
            }
        return powerChange * sourceIntensity;
    }
}
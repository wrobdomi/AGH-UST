function startCellularAutomata(){
    automataStarted = window.setInterval(runCellularAutomataAlgorithm, 600);
}

function stopCellularAutomata(){
    clearInterval(automataStarted);
}

function runCellularAutomataAlgorithm(){

    var accepted = false;

    var probabilityTreshold = 0;

    // console.log("Oh yeah !!!")   
    var directionsToChoose = ["up", "down", "left", "right"];

    // 1. Get random light
    var randomLightIndex = Math.floor(Math.random() * lights.length);  

    // 2. Calculate current objective funtion
    var currentObjectiveFunction = calculateObjectiveFunction();
    var newObjectiveFunction = 0;

    while(!accepted){

        // 3. Get random direction
        var randomDirection = Math.floor(Math.random() * directionsToChoose.length);

        // 4. Check if direction is valid
        while(!lights[randomLightIndex].checkPossibleDirection(directionsToChoose[randomDirection])){
            console.log("Direction invalid: " + directionsToChoose[randomDirection]);
            randomDirection = Math.floor(Math.random() * directionsToChoose.length);
        }

        // 5. Calculate objective function after moving this direction
        lights[randomLightIndex].moveLightFake(directionsToChoose[randomDirection]);
        updateSensorsIntensityAfterFakeLightMovement();
        newObjectiveFunction = calculateObjectiveFunction();

        if(newObjectiveFunction < currentObjectiveFunction){ // betterSolution
            probabilityTreshold = 25;
        }
        if(newObjectiveFunction > currentObjectiveFunction){
            probabilityTreshold = 75;
        }
        if(newObjectiveFunction == currentObjectiveFunction){
            probabilityTreshold = 50;
        }

        var ranNum = Math.floor(Math.random() * 101);
        if (ranNum >= probabilityTreshold){
            accepted = true;
            
            var idCellX = "lightX" + lights[randomLightIndex].id;
            var idCellY = "lightY" + lights[randomLightIndex].id; 
            document.getElementById(idCellX).innerHTML = lights[randomLightIndex].x;
            document.getElementById(idCellY).innerHTML = lights[randomLightIndex].y;

            repaintLights();

            updateSensorsParams();
        }
        else{
            accepted = false;
            if(directionsToChoose[randomDirection]==="up"){
                lights[randomLightIndex].moveLightFake("down");
                updateSensorsIntensityAfterFakeLightMovement();
            }
            if(directionsToChoose[randomDirection]==="down"){
                lights[randomLightIndex].moveLightFake("up");
                updateSensorsIntensityAfterFakeLightMovement();
            }
            if(directionsToChoose[randomDirection]==="left"){
                lights[randomLightIndex].moveLightFake("right");
                updateSensorsIntensityAfterFakeLightMovement();
            }
            if(directionsToChoose[randomDirection]==="right"){
                lights[randomLightIndex].moveLightFake("left");
                updateSensorsIntensityAfterFakeLightMovement();
            }
        }

    }



}
    

function calculateObjectiveFunction(){
    var objectiveFunction = 0;
    for(i = 0; i<sensors.length; i++){
        if(sensors[i].intensity < minimumIntensityRequired){
            objectiveFunction += minimumIntensityRequired - sensors[i].intensity;
        }
    }

    return objectiveFunction;
}


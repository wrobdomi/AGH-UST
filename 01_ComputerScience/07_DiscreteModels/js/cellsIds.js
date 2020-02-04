// -----------------------------------------------------------------------
// generates cellId basing on x and y coordinates
function generateCellId(x,y){
    xId = x;
    yId = y;
    if(x <= 9){
        xId = "0" + x;
    }
    if(y <= 9){
        yId = "0" + y;
    }
    return "cell" + xId + yId;
}

// -----------------------------------------------------------------------
// generates absorptionCellId basing on x and y coordinates
function generateAbsorptionCellId(x,y){
    return "absorptionDaylight" + generateCellId(x,y); 
}
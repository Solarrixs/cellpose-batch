//setBatchMode(true);
x = 500; //the x-start coordinate
y = 500; //the y-start coordinate
width = 500; //the width of the rectangle
height = 500; //the height of the rectangle
spacing = 0; //spacing between the rectangles
numRow = 7; //how many rows
numCol = 3; //how many columns
savePath = "G:/Shared/lab_members/undergraduate_researchers/yung_maxx/Experiments/Cellpose 05-01-2024/Grid Split/"; //where the images will be saved... the file path HAS to exist.

for (i = 0; i < numRow; i++) {
    for (j = 0; j < numCol; j++) {
        xOffset = j * (width + spacing);
        yOffset = i * (height + spacing);
        /*Create a rectangular selection!*/
        makeRectangle(x + xOffset, y + yOffset, width, height);
        roiManager("Add");
    }
}

roiManager("Show All with labels");
mainTitle=getTitle();
for (u = 0; u < roiManager("count"); ++u) {
    run("Duplicate...", "title=crop");
    roiManager("Select", u);
    run("Crop");
    saveAs("Tiff", savePath + "Grid_Section_" + (u + 1) + ".tif");
    close();
    selectWindow(mainTitle);
}
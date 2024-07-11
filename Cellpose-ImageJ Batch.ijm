dir = getDirectory("Choose a Directory ");

allFiles = getFileList(dir);
list = newArray(0);

for (i = 0; i < allFiles.length; i++) {
    if (endsWith(allFiles[i], ".tif") || endsWith(allFiles[i], ".zip")) {
        list = Array.concat(list, allFiles[i]);
    }
}

run("Clear Results");

for (i = 0; i < list.length; i += 2) {

    // Get Mask Image
    open(dir + list[i]);
    image1 = getTitle();
    getDimensions(width, height, channels, slices, frames);
    newImage("Untitled", "8-bit black", width, height, 1);
    run("Colors...", "foreground=white background=black selection=cyan");
    open(dir + list[i+1]);
    roiManager("Fill");
    saveAs("Tiff", dir + "/ImageJ Results/" + replace(list[i], ".tif", "_MASK.tif"));
    image2 = getTitle();
    close("ROI Manager");
    run("Analyze Particles...", "summarize");

    // Layer Mask with Original Image
    imageCalculator("Add create", image1, image2);
    processedImage = getTitle();
    saveAs("Tiff", dir + "/ImageJ Results/" + replace(list[i], ".tif", "_MERGED.tif"));
    
    // Close Images
    close(image1);
    close(image2);
    close(processedImage);
}

selectWindow("Summary");
saveAs("Results",  dir + "ImageJ Results/Results.csv");
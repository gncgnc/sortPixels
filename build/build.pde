PImage img , origImg;

float scaleFactor;
boolean showOriginal = false;

String imgFileName = "000003";
String fileType = "JPG";

void setup() {
  img = loadImage(imgFileName+"."+fileType);
  origImg = img.copy();
  
  // use only numbers (not variables) for the size() command, Processing 3
  size(1, 1);

  scaleFactor = img.width>displayWidth || img.height>displayHeight ? 
  				0.8 * min(1.0*displayWidth/img.width,1.0*displayHeight/img.height) : 
  				1;  
  
  // allow resize and update surface to image dimensions
  surface.setResizable(true);
  surface.setSize(int(img.width * scaleFactor), int(img.height * scaleFactor));

  img.loadPixels();

  //sorts each row within itself
  for(int y=0; y<img.height; y++){
    /*sort whole array*/
    //img.pixels = sort(img.pixels);break;

    /*sort all rows*/
    //sortBetween(img.pixels, y*img.width, (y+1)*img.width);
    
    /*sort more at top*/
    //if(random(1)< 0.1 +  1.0*(img.height-y) / img.height) sortBetween(img.pixels, y*img.width, (y+1)*img.width);

    /*sort more at bottom*/
    //if(random(1)< 0 +  1.0*y / img.height) sortBetween(img.pixels, y*img.width, (y+1)*img.width);

    /*sort in bands in the array*/
    int end1 = y * img.width + int(random(0.45 * img.width, .45 * img.width));
    int end2 = y * img.width + int(random(.55 * img.width, .55 * img.width));
    sortBetween(img.pixels, end1, end2);

    /*sort above/below the diagonal*/    
    // int end1 = y * img.width + int(0);
    // int end2 = y * img.width + int(1.0 * y / img.height * img.width);
    // sortBetween(img.pixels, end1, end2);

    /*sort within X - good for central composition*/
    // int end1 = y * img.width + int(1.0 * y / img.height * img.width);
    // int end2 = y * img.width + int(1.0 * (img.height - y) / img.height * img.width);
    // sortBetween(img.pixels, end1, end2);
  }

  img.updatePixels();

  image(img, 0, 0,img.width * scaleFactor, img.height * scaleFactor);

}


void draw(){
  if(showOriginal){
    image(origImg, 0,0,origImg.width * scaleFactor, origImg.height * scaleFactor);  
  } else {
    image(img,0,0,img.width * scaleFactor, img.height * scaleFactor);
  }
}

void sortBetween(color[] arr, int start, int end){
	//println("sorting row "+start/img.width);
  if(end < start) {
    int temp = end;
      end = start;
      start = temp;
  }
  if(start < 0) start = 0;
  if(end > arr.length - 1) end = arr.length - 1;

	color[] sorted = new color[end-start];
	for(int i=start; i<end; i++){
		sorted[i-start] = arr[i];
	}
	sorted = sort(sorted);
	for(int i=start; i<end; i++){
		arr[i] = sorted[i-start];
	}
}

void keyPressed() {
	
	if(key=='s') {
		saveFrame("../captures/"+imgFileName+"sorted####.png"); 
    println("image saved");
	} else {
    showOriginal = !showOriginal;
	}
}

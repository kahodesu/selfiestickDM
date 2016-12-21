//I AM PLAYER TWO
//I TWEET STUFF
//AND LISTENT TO PLAYER ONE

import java.util.Date;
import ketai.camera.*;
import android.os.Environment;

///////////////////////////VARIABLES//////////////////////
String path = "/storage/sdcard0/Pictures/selfiestick_player2/";
String playerNum = "2";

//modes variables
int mode =0;
int TWITTERID = 0;
int REST = 1;
int PREP = 2;
int START = 3;
int SILENTCD = 4;
int CD = 5;
int SENDING = 6;
int GAMEOVER = 7;

KetaiCamera cam;
int countDown = 10;
boolean camStart = false; 
boolean photoReady = false;
int photoNum;
PImage tempPhoto;


void setup()
{   
  size(displayWidth, displayHeight);
  orientation(LANDSCAPE);
  stroke(255);
  textAlign(CENTER);
  textSize(100);

  bt.start();

  twitterIdSetup();
  setUpTimer();
  setUpSound();


  //mode = REST;
  //bt.connectToDeviceByName("player1");

  if (cam == null) {
    cam = new KetaiCamera(this, width, height, 120);//1920 x 1080 //960,540
    cam.setCameraID(1);
  }


cam.start();

  mode = TWITTERID;
}

void draw()
{
 // println("*****mode = " + mode);
  background(0);
////////////TWITTERID MODE////////////////
  if (mode == TWITTERID) {
      twitterIdDraw();

////////////REST MODE////////////////
  } else if (mode == REST) {
 text("WAIT FOR \n OPPONENT", width/2, height/2);


////////////PREP MODE////////////////
  } else if (mode == PREP) {
 sec = second();
int timeLeft = beginTime-sec;
    if (timeLeft <0) {
      timeLeft = timeLeft +60;
    }
textSize(300);
    text(timeLeft, width/2, height/2);
textSize(100);
    //if there is 6 seconds left starts playing the prep sound
    if ((prepSoundPlayed == false) && ((beginTime- sec) ==5)) {
      prep.play();
      prepSoundPlayed = true;
    }
    if (beginTime == sec) {     
      photoReady = false;
      photoNum =1;
      silentCountDown.start();
      mode = SILENTCD;
    } 



////////////SILENTCD MODE////////////////
  } else if (mode == SILENTCD) {



 image(cam, 0, 0, width, height);//960,540
 
    if (silentCountDown.isFinished()) { 
      counterTimer.start();
      mode = CD;
    }
 //checkPhoto();

    /////////////CD////////////////
  } else if (mode == CD) {  
    image(cam, 0, 0, width, height);//960,540
textSize(300);
    text(countDown, width/2, height/2);
  textSize(100);
    if (counterTimer.isFinished()) { 
    if (countDown ==0) {
      // if (countDown ==9) {
        shutter.play(); 
    cam.enableFlash();
        cam.savePhoto(gameId + "_"+ photoNum +".jpg"); 
         tempPhoto = cam;
        photoReady = true;  
       f =new File(path+gameId + "_"+ photoNum +".jpg"); 
        cam.disableFlash();
        mode = SENDING;
        }
      else{
        player[countDown-1].play();
        counterTimer.start();
        countDown--;
        }
     }

////////////SENDING MODE////////////////
   } else if(mode == SENDING) {
image(tempPhoto, 0, 0, width, height);
//File f =new File(path+gameId + "_"+ photoNum +".jpg");  
println(photoReady+","+(f.exists()));
    if((photoReady == true)&& (f.exists())) {
       sendPacket(photoNum);
       photoNum ++; 
        photoReady = false;
       if (photoNum >3) {
 gameOverTimer. start();
    gameover. play();
           mode = GAMEOVER;
        } else {
            countDown = 10; 
            silentCountDown.start();
            mode = SILENTCD;
          }
       
    }
     
    /////////////GAMEOVER////////////////
 } else if (mode == GAMEOVER) {

    image(tempPhoto, 0, 0, width, height);
    text("GAME \n OVER", width/2, height/2);
    if (gameOverTimer.isFinished()) {
      countDown = 10;
photoReady = false;
      gameId = "";
      tempCalcTime = 0;
      twitterIdSetup();
      setUpTimer();
      twitterId ="";
      KetaiKeyboard.hide(this);
      keyboardVisible = false;
      mode = TWITTERID;
    }
  }
}

void onCameraPreviewEvent()
{
  cam.read();
}
//ALL THE THINGS ABOUT SOUND GOES HERE
import cassette.audiofiles.*;

////////////////VARIABLES////////////////////
boolean prepSoundPlayed = false;
SoundFile ding, beep, prep, gameover;
SoundFile[] player = new SoundFile[10];
SoundFile shutter;

////////////////FUNCTIONS////////////////////
void setUpSound(){
gameover= new SoundFile(this, "gameover.wav"); //set the file (files are in data folder)
shutter= new SoundFile(this, "shutter.wav"); //set the file (files are in data folder)
  player[0]= new SoundFile(this, "1.wav"); //set the file (files are in data folder)
  player[1]= new SoundFile(this, "2.wav"); //set the file (files are in data folder)
  player[2]= new SoundFile(this, "3.wav"); //set the file (files are in data folder)
  player[3]= new SoundFile(this, "4.wav"); //set the file (files are in data folder)
  player[4]= new SoundFile(this, "5.wav"); //set the file (files are in data folder)
  player[5]= new SoundFile(this, "6.wav"); //set the file (files are in data folder)
  player[6]= new SoundFile(this, "7.wav"); //set the file (files are in data folder)
  player[7]= new SoundFile(this, "8.wav"); //set the file (files are in data folder)
  player[8]= new SoundFile(this, "9.wav"); //set the file (files are in data folder)
  player[9]= new SoundFile(this, "10.wav"); //set the file (files are in data folder)

 ding= new SoundFile(this, "ding.wav");
  beep= new SoundFile(this, "beep.wav");
  prep= new SoundFile(this, "prep.wav");

}
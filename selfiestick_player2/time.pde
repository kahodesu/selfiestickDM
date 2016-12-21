//anything time related goes here :D

////////////////VARIABLES////////////////////
Timer counterTimer, faceTimer, timer, silentCountDown, gameOverTimer;
int sec;
int tempCalcTime;
int beginTime;
////////////////FUNCTIONS////////////////////
void setUpTimer() {
  counterTimer = new Timer(1000);
  silentCountDown = new Timer(3000);
gameOverTimer = new Timer(15000);
 counterTimer.start();
}

int calcTime() {
  tempCalcTime = 0;
  tempCalcTime= second()+15;
  if (tempCalcTime > 59) {
    tempCalcTime = tempCalcTime-60;
  }
  println(tempCalcTime);
  return tempCalcTime;
}

boolean  checkBeginTime() {
  if (tempCalcTime == second()) {
    return true;
  } else {
    return false;
  }
}

class Timer { 
  int savedTime; // When Timer started
  int totalTime; // How long Timer should last
  
  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }
  
  // Starting the timer
  void start() {
    // When the timer starts it stores the current time in milliseconds.
    savedTime = millis(); 
  }
  // The function isFinished() returns true if 5,000 ms have passed. 
  // The work of the timer is farmed out to this method.
  boolean isFinished() { 
    // Check how much time has passed
    int passedTime = millis()- savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}
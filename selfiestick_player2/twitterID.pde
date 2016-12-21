//this is the part where you type in your twitter handle. 
//what if you don't have one tho... 

////////////////VAIRABLES////////////////////
String twitterId = "";
String[] letters = new String[15];
PImage keyboard, ok;
Boolean keyboardVisible = false; 

////////////////FUNCTIONS////////////////////
void twitterIdSetup() {
  keyboard = loadImage("keyboard.png");
  ok = loadImage("ok.png");
}

void twitterIdDraw() {
  //println(keyboardVisible);//FOR DEBUG
  image(keyboard, 0, 0); 
  twitterId=trim(twitterId);
  text(twitterId, width/2, 120);
  image(ok, width/2, height-100);
  if (mousePressed == true) {
    println("clicked!");
    if ((mouseY < 200)&& (mouseX < 300)) {
      if (keyboardVisible == false) {
        KetaiKeyboard.show(this);
        keyboardVisible = true;
        delay(100);
      } 
      else {
        KetaiKeyboard.hide(this);
        keyboardVisible = false;
        delay(100);
      }
    } 
    else {
      if ((keyboardVisible == false) && (twitterId!="")) {
        println("ok!");
        mode = REST;
      }
    }
  }
  delay(100);
}


void keyPressed() {    
  if (key == '￿') {
    //   KetaiAlertDialog.popup(this, "DELETE pressed", "You pressed the <DELETE> key!"); //FOR DEBUG
    twitterId = twitterId.substring(0, twitterId.length()-1);
    if (twitterId.length()<1) {  
      twitterId="@";
    }
  } 
  else if (int(key) == 10) {
    // KetaiAlertDialog.popup(this, "ENTER pressed", "You pressed the <ENTER> key!");//FOR DEBUG
    KetaiKeyboard.hide(this);
    keyboardVisible = false;
  } 
  else {
    //println(key);//FOR DEBUG
    twitterId += key;
  }
}
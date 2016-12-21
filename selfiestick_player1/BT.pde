import android.content.Intent;
import android.os.Bundle;

import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;

import oscP5.*;
String gameId; 

KetaiBluetooth bt;
String info = "";
KetaiList klist;
PVector remoteMouse = new PVector();

ArrayList<String> devicesDiscovered = new ArrayList();
boolean isConfiguring = true;
String UIText;
ArrayList<String> devicesConnected = new ArrayList();

//********************************************************************
// The following code is required to enable bluetooth at startup.
//********************************************************************
void onCreate(Bundle savedInstanceState) {
  super.onCreate(savedInstanceState);
  bt = new KetaiBluetooth(this);
}

void onActivityResult(int requestCode, int resultCode, Intent data) {
  bt.onActivityResult(requestCode, resultCode, data);
}

//********************************************************************
void setUpBT() {
  //start listening for BT connections
  bt.start();
  bt.getPairedDeviceNames();
  bt.connectToDeviceByName("player2");

}


void begin(){ 
  //if (isConfiguring)
  //  return;
OscMessage m = new OscMessage("/BEGIN/");
  m.add(calcTime());
 println("SENDING START TIME");
  bt.broadcast(m.getBytes());
delay(1000);

OscMessage n= new OscMessage("/GAMEID/");
unixTime = System.currentTimeMillis() / 1000L;
gameId = Long.toString(unixTime)+"_"+ playerNum;
println(gameId);
n.add(gameId);

  bt.broadcast(n.getBytes());
  mode = PREP;
}


void onKetaiListSelection(KetaiList klist){
  bt.connectToDeviceByName("player2");
}

//void onBluetoothDataEvent(String who, byte[] data)
//{
//  if (isConfiguring)
//    return;

//  //KetaiOSCMessage is the same as OscMessage
//  //   but allows construction by byte array
//  KetaiOSCMessage m = new KetaiOSCMessage(data);
//  if (m.isValid())
//  {
//    if (m.checkAddrPattern("/remoteMouse/"))
//    {
//      if (m.checkTypetag("ii"))
//      {
//        remoteMouse.x = m.get(0).intValue();
//        remoteMouse.y = m.get(1).intValue();
//      }
//    }
//  }
//}

String getBluetoothInformation()
{
  String btInfo = "Server Running: ";
  btInfo += bt.isStarted() + "\n";
  btInfo += "Discovering: " + bt.isDiscovering() + "\n";
  btInfo += "Device Discoverable: "+bt.isDiscoverable() + "\n";
  btInfo += "\nConnected Devices: \n";

  ArrayList<String> devices = bt.getConnectedDeviceNames();
  for (String device: devices)
  {
    btInfo+= device+"\n";
  }

  return btInfo;
}


boolean checkConnectBT() {
 emptyArraylist(devicesConnected);
  bt.getPairedDeviceNames();
  devicesConnected = bt.getConnectedDeviceNames();
  if(devicesConnected.size() == 0) {
      //it is not connected so we gotta reconnect
          bt.connectToDeviceByName("player2");
          println("----NOT CONNECTED------");//DEBUG
          return false; 
  }
  else {
      println("---- CONNECTED !!!! ------");//DEBUG
      return  true;
  }
}
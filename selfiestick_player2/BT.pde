
//required for BT enabling on startup
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


//void onKetaiListSelection(KetaiList klist)
//{
//  bt.connectToDeviceByName("player1");
//}


//Call back method to manage data received
void onBluetoothDataEvent(String who, byte[] data)
{

  //KetaiOSCMessage is the same as OscMessage
  //   but allows construction by byte array
  KetaiOSCMessage m = new KetaiOSCMessage(data);
// KetaiOSCMessage n = new KetaiOSCMessage(data);
  if (m.isValid())
  {
    println(m.get(0).intValue());
    if (m.checkAddrPattern("/BEGIN/"))
    {
      if (m.checkTypetag("i"))
      {
        beginTime = m.get(0).intValue();
          print("beginTime:"+beginTime); 
      }
    }
   else if (m.checkAddrPattern("/GAMEID/"))
    {
       // print("made it!"); 
if (m.checkTypetag("i"))
      {
        gameId = (m.get(0).stringValue());
//unixTime = System.currentTimeMillis() / 1000L;
//gameId = Long.toString(unixTime)+"_"+ playerNum;
          print("gameId:"+ gameId); 
if (beginTime != 0 ) {

mode = PREP;
}        
      }
    }


  }
}

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
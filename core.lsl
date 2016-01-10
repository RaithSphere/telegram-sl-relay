////////////////////////////////////////////
//
// To Send messages to the SL .php
// llHTTPRequest( URL + "?message=" +  llEscapeURL(messagehere) +"&name=" +llEscapeURL(namehere), [], "" );
//


string URL   = "TG URL"; // This is SL.php
string URL2   = "UPDATE URL";  // This is update.php
key    reqid;                               
string avatars;

integer ListenHandle;
integer mode;

default
{
    state_entry()
    {
          llRequestURL(); // Get URL for CAP
          ListenHandle = llListen(0, "","",""); // Listen to all avatars 
          mode = TRUE; // Set the mode to true for the touch event 
          llOwnerSay("Relay listening"); // Lets say its listening
          llSetColor(<0,1,0>, 4);  // Change the LED to Green
    }

    touch_start(integer touched)
    {
        if (llDetectedGroup(0) )
            {   
                if(!mode)
                {
                llSetText("Telegram Relay Not Listening", <1,0,0>, 0); 
                llHTTPRequest( URL + "?message= " +  llEscapeURL(llDetectedName(0)+" has disabeld the relay") +"&name="+llEscapeURL("Infos"), [], "" );
                llListenRemove(ListenHandle);
                mode = TRUE;
                llSetColor(<1,0,0>, 4);
                }
                else
                {
                 ListenHandle =  llListen(0, "","","");
                 llSetText("Telegram Relay Listening", <0,1,0>, 0); 
                 mode = FALSE;
                 llHTTPRequest( URL + "?message= " +  llEscapeURL(llDetectedName(0)+" has enabled the relay") +"&name="+llEscapeURL("Infos"), [], "" );
                 llSetColor(<0,1,0>, 4); 
                }
            }
    }


    // Start Listening
    listen(integer channel, string name, key id, string message)
    {
             llSetColor(<1,1,0>, 5);
              reqid = llHTTPRequest( URL + "?message=" +  llEscapeURL(message) +"&name=" +
                               llEscapeURL(name), [], "" );
                               llSleep(.1);
           llSetColor(<0,1,0>, 5);
    }
     sensor( integer vIntFound )
    {
        integer vIntCounter = 0;
        avatars = "";
        //-- loop through all avatars found
        do
        {
           llSetColor(<0,1,1>, 5);
           avatars += llGetDisplayName(llDetectedKey( vIntCounter ))+" ("+llGetUsername(llDetectedKey( vIntCounter ))+")\n";
           llSetColor(<0,1,0>, 5);
               
        } while (++vIntCounter < vIntFound); 
        
         llHTTPRequest( URL + "?message= " +  llEscapeURL(avatars) +"&name="+llEscapeURL("Avatars"), [], "" );
         
       
    }
    no_sensor()
    {
      llHTTPRequest( URL + "?message= " +  llEscapeURL("No one is here\n") +"&name="+llEscapeURL("Scanner"), [], "" )  ;
    }
    
    http_request(key id, string method, string body)
    {
         llSetColor(<0,0,1>, 5);
    if (method == URL_REQUEST_GRANTED)
        {
            llSetObjectDesc(body);
            llOwnerSay(body);      
            llHTTPRequest( URL2 + "?url="+llEscapeURL(body), [], "" );      
        }
        else if (method == "GET")
        {
           
                llSay(0, body);
                llHTTPResponse(id,200,"Hello World!");
            
        }
        else if (method == "POST")
        {   
        list items = llParseString2List(body, ["||"], []);
        string who = llList2String(items, 0);
        string message = llList2String(items, 1);
        
                if(message == "scan")
                {
                llSensor( "", "", AGENT, 20, PI );
                llHTTPResponse(id,200,"command sent");                    
                }
                else
                {
                llSetObjectName(who);
                llSay(0, message);
                llHTTPResponse(id,200,"command sent");
                llSetObjectName("Telegram");
                }

        }
        else
        {
            llHTTPResponse(id,405,"Unsupported method.");
        }
        llSleep(0.2);
             llSetColor(<0,1,0>, 5);
    }
 

    changed(integer change)
    {
    //  note that it's & and not &&... it's bitwise!
        if (change & CHANGED_REGION_START)
        {
          llResetScript();
        }
    }

}
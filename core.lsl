string URL   = "TGURL";
key    reqid;                               
string avatars;

default
{
    state_entry()
    {
         llListen(0, "", "", "");
          llRequestURL();
    }

  listen(integer channel, string name, key id, string message)
    {
          reqid = llHTTPRequest( URL + "?message=" +  llEscapeURL(message) +"&name=" +
                               llEscapeURL(llGetDisplayName(id)), [], "" );
    }
    
    http_response(key id, integer status, list meta, string body) {

    }

 http_request(key id, string method, string body)
    {
        if (method == URL_REQUEST_GRANTED)
        {
            llSetObjectDesc(body);
            llOwnerSay(body);            
        }
        else if (method == "GET")
        {
           
                llSay(0, body);
                llHTTPResponse(id,200,"Hello World!");
            
        }
        else if (method == "POST")
        {   
        
                if(body == "scan")
                {
                llSensor( "", "", AGENT, 20, PI );
                llHTTPResponse(id,200,"command sent");                    
                }
                else
                {
                llSay(0, body);
                llHTTPResponse(id,200,"command sent");
                }

        }
        else
        {
            llHTTPResponse(id,405,"Unsupported method.");
        }
    }
  sensor( integer vIntFound )
    {
        integer vIntCounter = 0;
        avatars = "";
        //-- loop through all avatars found
        do
        {
           avatars += llGetDisplayName(llDetectedKey( vIntCounter ))+"\n";
               
        } while (++vIntCounter < vIntFound); 
        
         llHTTPRequest( URL + "?message= " +  llEscapeURL(avatars) +"&name="+llEscapeURL("Avatars"), [], "" );
         
       
    }
 
    // sensor does not detect owner if it's attached
    no_sensor()
    {
        
         llHTTPRequest( URL + "?message="+llEscapeURL("No Avatars in range")+"&name=Scanner", [], "" );
    }

}

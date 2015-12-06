string URL   = "TELEGRAM PHP URL HERE";
key    reqid;                          

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
    
    http_response(key id, integer status, list meta, string body) 
    {

    }

 http_request(key id, string method, string body)
    {
        if (method == URL_REQUEST_GRANTED)
        {
            llSetObjectDesc(body);
        }
        else if (method == "GET")
        {
            llSay(0, body);
            llHTTPResponse(id,200,"command sent");
        }
        else if (method == "POST")
        {   
            llSay(0, body);
            llHTTPResponse(id,200,"command sent");
        }
        else
        {
            llHTTPResponse(id,405,"Unsupported method.");
        }
    }


}

with AWS.Config;
with AWS.Response;
with AWS.Services.Dispatchers.URI;
with AWS.Status;

package Mcp_Tools_Service is
use AWS;
   use AWS.Services.Dispatchers.URI;

   procedure Create_Service
     (Web_Config  : Config.Object;
      Hdr         : in out Services.Dispatchers.URI.Handler;
      Service_URI : String);

   type Tools_Dispatcher is new Handler with private;
   overriding
   function Dispatch
     (Dispatcher : Tools_Dispatcher; Request : Status.Data)
      return Response.Data;

private

   type Tools_Dispatcher is new Handler with null record;

end Mcp_Tools_Service;
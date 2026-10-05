with AWS.Messages;
package body Ping_Service is

   Dsp      : Ping_Dispatcher;
   procedure Create_Service
   (Web_Config  : Config.Object;
      Hdr         : in out Services.Dispatchers.URI.Handler;
    Service_URI : String)
   is
      pragma Unreferenced (Web_Config);
   begin
      Services.Dispatchers.URI.Register
        (Hdr, URI => Service_URI, Action => Dsp, Prefix => True);
   end Create_Service;

   overriding function Dispatch
     (Dispatcher : Ping_Dispatcher;
      Request    : Status.Data) return Response.Data
   is
      use Status;
      pragma Unreferenced (Dispatcher);
   begin
      if Method (Request) = GET then
         return Response.Build
           (Content_Type => "application/json",
            Message_Body => "{""status"": ""ok""}");
      else
         return Response.Acknowledge (Messages.S405);
      end if;
   end Dispatch;

end Ping_Service;
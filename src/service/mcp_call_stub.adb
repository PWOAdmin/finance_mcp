with AWS.Messages;
with Logger;
with Ada.Strings.Unbounded;

package body Mcp_Call_Stub is
   Dsp : Call_Stub_Dispatcher;

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

   overriding
   function Dispatch
     (Dispatcher : Call_Stub_Dispatcher; Request : Status.Data)
      return Response.Data
   is
      use Status;
      pragma Unreferenced (Dispatcher);
      data: constant String:=Ada.Strings.Unbounded.To_String (Request.Binary_Data);
   begin

      Logger.Info ("Mcp_Call_Stub: Request: " & Status.Payload (Request));
      Logger.Info ("Data: "&data);
      return
        Response.Build (Content_Type => "text/plain", Message_Body => "ok");

   end Dispatch;

end Mcp_Call_Stub;

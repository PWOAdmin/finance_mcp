with AWS.Messages;
with Mcp_Server_Info;
package body Mcp_Handshake_Service is
 Dsp : Handshake_Dispatcher;
  Server_Name:constant String    := "finance-srv";
  Server_Title: constant String := "Finance MCP Server";
  Server_Version: constant String := "1.0";
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
     (Dispatcher : Handshake_Dispatcher; Request : Status.Data) return Response.Data
   is
      use Status;
      use Mcp_Server_Info;
         pragma Unreferenced (Dispatcher);
      Info : Mcp_Server_Info.Mcp_Server_Info_Type;
   begin
      Info.Server_Name    := Mcp_Server_Field_Str.To_Bounded_String (Server_Name);
      Info.Server_Title   := Mcp_Server_Field_Str.To_Bounded_String (Server_Title);
      Info.Server_Version := Mcp_Server_Field_Str.To_Bounded_String (Server_Version);
      if Method (Request) = GET then
         return
           Response.Build
             (Content_Type => "application/json",
              Message_Body => Mcp_Server_Info.To_Handshake_JSON (Info));
      else
         return Response.Acknowledge (Messages.S405);
      end if;
   end Dispatch;
end Mcp_Handshake_Service;
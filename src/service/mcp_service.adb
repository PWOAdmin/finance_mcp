with AWS.Messages;
with PWMcp;
with Ada.Strings.Unbounded;
with PW_Config;
package body Mcp_Service is
  Dsp : Mcp_Dispatcher;
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
     (Dispatcher : Mcp_Dispatcher; Request : Status.Data) return Response.Data
   is
      use Status;
      use Mcp_Handshake_Response;
      package R renames PW_Config.MCP_Record_Fields;
      pragma Unreferenced (Dispatcher);
      Payload: constant String:= Ada.Strings.Unbounded.To_String(Request.Binary_Data);
       Handshake: Handhake_Response_Type;
       Server_Info: Server_Info_Type:=(Server_Name => R.To_Bounded_String ("finane-mcp"), 
       Server_Title => R.To_Bounded_String ("Finance MCP Server"), 
       Server_Version => R.To_Bounded_String ("1.0"));
      Id: Integer;
   begin
   Handshake.Server_Info:=Server_Info;

      if Method (Request) = POST then
         return
           Response.Build
             (Content_Type => "application/json",
              Message_Body => PWMcp.Parse_Payload(Payload, Handshake));
      else
         return Response.Acknowledge (Messages.S405);
      end if;
   end Dispatch;
end Mcp_Service;
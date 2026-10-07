with AWS.Messages;
with AWS.Parameters;
with AWS.Containers.Tables;
with Mcp_Server_Info;
with Logger;
with Mcp_Tools_Service;
with Ada.Strings.Unbounded;

with GNATCOLL.JSON;
package body Mcp_Handshake_Service is
 Dsp : Handshake_Dispatcher;
  use AWS;
  Server_Name:constant String    := "finance-srv";
  Server_Title: constant String := "Finance MCP Server";
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
      use GNATCOLL;
         pragma Unreferenced (Dispatcher);
      Info : Mcp_Server_Info.Mcp_Server_Info_Type;
      Params: constant AWS.Parameters.List:=AWS.Status.Parameters (Request);
      bin: constant String:=Ada.Strings.Unbounded.To_String (Request.Binary_Data);
      
   begin
      Info.Server_Name    := Mcp_Server_Field_Str.To_Bounded_String (Server_Name);
      Info.Server_Title   := Mcp_Server_Field_Str.To_Bounded_String (Server_Title);
    --  Info.Server_Version := Mcp_Server_Field_Str.To_Bounded_String (id);
      Logger.Info ("Init (handshake) called");
      Logger.Info ("Method: "&Request.Method);


if Status.Method (Request) = POST then 
Logger.Info ("bin: "&bin);
declare
val: JSON.Json_Value:=JSON.Read(bin);
id: Integer;

begin
if JSON.Has_Field(val, "id") then
id:=JSON.Get(val, "id");
Info.Server_Version := Mcp_Server_Field_Str.To_Bounded_String ("1.0");
Info.Id:=id;

Logger.Info ("Set Id to "&id'Image);

if JSON.Has_Field (val, "method") then
if JSON.Get(val, "method") = "tools/list" then
return Response.Build (Content_Type => "application/json", 
Message_Body => Mcp_Tools_Service.Return_Tools(bin));
end if;
end if;

end if;

end;

      for I in 1..Status.Header(Request).Count loop
      declare 
      h_name: constant String:=Status.Header(Request).Get_Name(I);
      h_value: constant String:=Status.Header(Request).Get_Value(I);
      begin
     Logger.Info (h_name&": "&h_value);
     end;
     end loop;
     Logger.Info ("Binary data: "&Ada.Strings.Unbounded.To_String (Request.Binary_Data));
     Logger.Info ("Seding back: "&Mcp_Server_Info.To_Handshake_JSON (Info));
         return
           Response.Build
             (Content_Type => "application/json",
              Message_Body => Mcp_Server_Info.To_Handshake_JSON (Info));
              else
               return Response.Acknowledge (Messages.s405);
              end if;
   end Dispatch;
end Mcp_Handshake_Service;
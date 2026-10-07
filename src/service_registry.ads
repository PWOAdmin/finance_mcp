with AWS;
with AWS.Config;
with AWS.Services.Dispatchers.URI;
with AWS.Server;
with Ping_Service;
with Mcp_Handshake_Service;
with Mcp_Tools_Service;
with Mcp_Call_Stub;
with Service_Contract;

package Service_Registry is

   use AWS;
   use AWS.Services.Dispatchers.URI;

   procedure Register_Ping_Service is new
     Service_Contract (Ping_Service.Create_Service);

   procedure Register_Mcp_Handshake_Service is new
     Service_Contract (Mcp_Handshake_Service.Create_Service);

   procedure Register_Mcp_Call_Stub is new
     Service_Contract (Mcp_Call_Stub.Create_Service);

end Service_Registry;

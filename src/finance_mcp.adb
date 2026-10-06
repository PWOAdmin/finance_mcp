with Current_Config;
with AWS.Config;
with AWS.Config.Set;
with AWS.Server;
with AWS.Services.Dispatchers.URI;
with Service_Registry;
with database_config;

with Logger;

procedure Finance_Mcp is
   use AWS;
   Web_Server     : Server.HTTP;
   Web_Config     : Config.Object;
   Web_Dispatcher : Services.Dispatchers.URI.Handler;

begin
   Logger.Info ("Starting Finance MCP Server...");
   Current_Config.Load_Config ("/finance/default/label");
   Database_Config.Session_Init;

   Config.Set.Server_Port
     (Web_Config, Integer'Value (Current_Config.Server_Port));
   Config.Set.HTTP2_Activated (Web_Config, true);

   Service_Registry.Register_Ping_Service
     (Web_Config, Web_Dispatcher, "/healthcheck");

   Service_Registry.Register_Mcp_Handshake_Service
     (Web_Config, Web_Dispatcher, "/initialize");

     Service_Registry.Register_Mcp_Tools_Service
     (Web_Config, Web_Dispatcher, "/tools/list");

   Server.Start (Web_Server, Web_Dispatcher, Web_Config);
   Logger.Info
     ("Finance MCP Server started on port "
      & Current_Config.Server_Port
      & ". Press Q to stop the server.");
   --  Wait for the Q key

   Server.Wait (Server.Q_Key_Pressed);
   Logger.Info ("Stopping Finance MCP Server...");
   --  Stop the server

   Server.Shutdown (Web_Server);
   Logger.Info ("Finance MCP Server stopped.");

end Finance_Mcp;

with Current_Config;
with AWS.Config;
with AWS.Config.Set;
with AWS.Server;
with AWS.Services.Dispatchers.URI;
with Service_Registry;
with database_config;

procedure Finance_Mcp is
   use AWS;
   Web_Server     : Server.HTTP;
   Web_Config     : Config.Object;
   Web_Dispatcher : Services.Dispatchers.URI.Handler;
 
begin

   Current_Config.Load_Config ("/finance/default/label");
   Database_Config.Session_Init;

   --Config.Set.Server_Host (Web_Config, Host);
   Config.Set.Server_Port (Web_Config, Integer'Value(Current_Config.Server_Port));
   Config.Set.HTTP2_Activated (Web_Config, true);

   Service_Registry.Register_Ping_Service (Web_Config, Web_Dispatcher, "/healthcheck");

   Server.Start (Web_Server, Web_Dispatcher, Web_Config);

   --  Wait for the Q key

   Server.Wait (Server.Q_Key_Pressed);

   --  Stop the server

   Server.Shutdown (Web_Server);

end Finance_Mcp;

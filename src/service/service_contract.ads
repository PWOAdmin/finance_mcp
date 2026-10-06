with AWS.Config;
with AWS.Services.Dispatchers.URI;

generic
   with
     procedure Create_Service
       (Web_Config  : AWS.Config.Object;
        Hdr         : in out AWS.Services.Dispatchers.URI.Handler;
        Service_URI : String);
procedure Service_Contract
  (Web_Config  : AWS.Config.Object;
   Hdr         : in out AWS.Services.Dispatchers.URI.Handler;
   Service_URI : String);

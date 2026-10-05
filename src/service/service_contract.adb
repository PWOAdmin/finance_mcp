with AWS.Config;
with AWS.Services.Dispatchers.URI;

procedure Service_Contract
   (Web_Config  : AWS.Config.Object;
   Hdr         : in out AWS.Services.Dispatchers.URI.Handler;
    Service_URI : String)
is
begin
   Create_Service (Web_Config, Hdr, Service_URI);
end Service_Contract;
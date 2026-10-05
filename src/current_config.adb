with Cloud_Config_Service_Client;
with Cloud_Property_Source;

with Ada.Strings.Fixed;
use Ada.Strings.Fixed;

with Ada.Text_IO;
use Ada.Text_IO;

package body Current_Config is

procedure Load_Config (Path: String) is
   Client: Cloud_Config_Service_Client.Client_Type;
Data: Cloud_Property_Source.Source_Vector.Vector;
begin
   Cloud_Config_Service_Client.Setup_Client (Client, Config_Server_Url,
Config_Server_Certificate);

Data:=Cloud_Config_Service_Client.Load_Config (Client, Path);
Server_Port := Ada.Strings.Fixed.Head(Cloud_Property_Source.Get_Property(Data.Element(1), "server.port"), 255);
Database_Name := Ada.Strings.Fixed.Head(Cloud_Property_Source.Get_Property(Data.Element(1), "database.name"), 255);
Database_User := Ada.Strings.Fixed.Head(Cloud_Property_Source.Get_Property(Data.Element(1), "database.user"), 255);
Database_Password := Ada.Strings.Fixed.Head(Cloud_Property_Source.Get_Property(Data.Element(1), "database.password"), 255);
Database_Host := Ada.Strings.Fixed.Head(Cloud_Property_Source.Get_Property(Data.Element(1), "database.host"), 255);
Database_Port := Ada.Strings.Fixed.Head(Cloud_Property_Source.Get_Property(Data.Element(1), "database.port"), 255);

--Put_Line (Data.Element(1).Get_Property("server.port"));--Put_Line (Data.Element(1).Get_Property("server.port"));
end Load_Config ;

end Current_Config;
package Current_Config is

   subtype Config_Field is String (1 .. 255);
   Config_Server_Url         : constant String := "https://config.punks.work";
   Config_Server_Certificate : constant String :=
     "/home/sergei/Documents/punks_ca.pem";

   Database_Name     : Config_Field;
   Database_User     : Config_Field;
   Database_Password : Config_Field;
   Database_Host     : Config_Field;
   Database_Port     : Config_Field;
   Server_Port       : Config_Field;

   procedure Load_Config (Path : String);

end Current_Config;

with Current_Config;
with GNATCOLL.SQL;
with Logger;
use GNATCOLL;

package body Database_Config is
   procedure Session_Init is
      DB_Descr : GNATCOLL.SQL.Exec.Database_Description;
   begin
      DB_Descr :=
        GNATCOLL.SQL.Postgres.Setup
          (Database => Current_Config.Database_Name,
           User     => Current_Config.Database_User,
           Password => Current_Config.Database_Password,
           Host     => Current_Config.Database_Host,
           Port     => Integer'Value (Current_Config.Database_Port));
      GNATCOLL.SQL.Sessions.Setup (Descr => DB_Descr, Max_Sessions => 10);
      Logger.Info ("Database session initialized for " & Current_Config.Database_Name);
   end Session_Init;

   function Get_Connection return Gnatcoll.SQL.Exec.Database_Connection is
      Sess : SQL.Sessions.Session_Type := SQL.Sessions.Get_New_Session;
   begin
      return SQL.Sessions.DB (Sess);
   end Get_Connection;

end Database_Config;

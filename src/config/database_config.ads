with GNATCOLL.SQL.Exec;
with GNATCOLL.SQL.Sessions;
with GNATCOLL.SQL.Postgres;

package Database_Config is
   procedure Session_Init;
   function Get_Connection return Gnatcoll.SQL.Exec.Database_Connection;

end Database_Config;
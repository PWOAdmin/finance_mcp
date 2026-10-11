with Mcp_Tools_Registry;
with PW_Config;
package body Op_Tool is


overriding procedure Setup (Tool : in out Op_Tool_Type) is
package R renames PW_Config.MCP_Record_Fields;
begin
Tool.Name:=R.To_Bounded_String ("registerOperation");
Mcp_Tools_Registry.Register_Tool (Tool);
end Setup;


overriding function Execute (Tool : in out Op_Tool_Type)
	return GNATCOLL.JSON.JSON_Value
is
begin
	 return GNATCOLL.JSON.Create_Object;

end Execute;

end Op_Tool;
with Mcp_Tool;
with GNATCOLL.JSON;
package Op_Tool is 

type Op_Tool_Type is new Mcp_Tool.Mcp_Tool_Type with null record;

overriding procedure Setup (Tool : in out Op_Tool_Type);
overriding function Execute (Tool : in out Op_Tool_Type)
	return GNATCOLL.JSON.JSON_Value;

end Op_Tool;
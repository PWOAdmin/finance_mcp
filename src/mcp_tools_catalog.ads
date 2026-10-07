with Mcp_Tools;
with Ada.Containers.Vectors;
package Mcp_Tools_Catalog is

package Tools_Registry is new Ada.Containers.Vectors
  (Index_Type   => Positive,
  Element_Type => Mcp_Tools.Mcp_Tool_Type, "=" => Mcp_Tools."=");

--Register Tool
procedure Register_Tool (Tool : Mcp_Tools.Mcp_Tool_Type);

--Publish Tool Catalog
function Get_Tool_Catalog (Id: String) return String;

end Mcp_Tools_Catalog;
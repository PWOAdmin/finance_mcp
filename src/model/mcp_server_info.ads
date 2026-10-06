with Ada.Strings.Bounded;

package Mcp_Server_Info is

   package Mcp_Server_Field_Str is new
     Ada.Strings.Bounded.Generic_Bounded_Length (255);

   type Mcp_Server_Info_Type is record
      Server_Name    : Mcp_Server_Field_Str.Bounded_String;
      Server_Title   : Mcp_Server_Field_Str.Bounded_String;
      Server_Version : Mcp_Server_Field_Str.Bounded_String;
   end record;

   function To_Handshake_JSON (Info : Mcp_Server_Info_Type) return String;

end Mcp_Server_Info;

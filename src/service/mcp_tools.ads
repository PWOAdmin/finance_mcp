with Ada.Strings.Bounded;

package Mcp_Tools is

   --Todo: create a package for bounded strings with varying lengths
   package Str_255_Field is new
     Ada.Strings.Bounded.Generic_Bounded_Length (255);

   type Tool_Property_Type is record
      Name                 : Str_255_Field.Bounded_String;
      Property_Type        : Str_255_Field.Bounded_String;
      Property_Description : Str_255_Field.Bounded_String;
   end record;

   type Mcp_Tool_Type is record
      Name        : Str_255_Field.Bounded_String;
      Description : Str_255_Field.Bounded_String;
   end record;

end Mcp_Tools;

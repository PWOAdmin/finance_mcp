with Ada.Strings.Bounded;
with Ada.Containers.Vectors;

package Mcp_Tools is

   --Todo: create a package for bounded strings with varying lengths
   package Str_255_Field is new
     Ada.Strings.Bounded.Generic_Bounded_Length (255);

   type Tool_Property_Type is record
      Name                 : Str_255_Field.Bounded_String;
      --TODO: Make a separate type (boolean, string, integer, double, object)
      Property_Type        : Str_255_Field.Bounded_String;
      Property_Description : Str_255_Field.Bounded_String;
      Is_Required          : Boolean;
   end record;

   function "=" (Left, Right : Tool_Property_Type) return Boolean;

   package Tool_Property_Vector is new
     Ada.Containers.Vectors
       (Index_Type   => Positive,
        Element_Type => Tool_Property_Type);

   Type Schema_Type is record
      Object_Type               : Str_255_Field.Bounded_String;
      Description               : Str_255_Field.Bounded_String;
      Properties                : Tool_Property_Vector.Vector;
      Has_Additional_Properties : Boolean;
   end record;

   type Mcp_Tool_Type is record
      Name          : Str_255_Field.Bounded_String;
      Description   : Str_255_Field.Bounded_String;
      Input_Schema  : Schema_Type;
      Output_Schema : Schema_Type;
   end record;

   function "=" (Left, Right : Mcp_Tool_Type) return Boolean;

end Mcp_Tools;

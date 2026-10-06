with MCP_Tools; use Mcp_Tools;
with Gnatcoll.JSON;

with Ada.Containers.Vectors;

package body Mcp_Tools_Catalog is

   Tools : Tools_Registry.Vector;

   procedure Register_Tool (Tool : Mcp_Tools.Mcp_Tool_Type) is
   begin
      Tools_Registry.Append (Tools, Tool);
   end Register_Tool;

   --TODO: ID is a variable
   function Create_Response return GNATCOLL.JSON.Json_Value is
      use GNATCOLL;
      Response : JSON.JSON_Value := JSON.Create_Object;
   begin

      JSON.Set_Field (Response, "jsonrpc", "2.0");
      JSON.Set_Field (Response, "id", "2");

      return Response;
   end Create_Response;

   function Property_To_JSON
     (Prop : Tool_Property_Type) return GNATCOLL.JSON.JSON_Value
   is
      use GNATCOLL;
      val : JSON.JSON_Value := JSON.Create_Object;
   begin
      JSON.Set_Field
        (val, "type", Str_255_Field.To_String (Prop.Property_Type));
      JSON.Set_Field
        (val,
         "description",
         Str_255_Field.To_String (Prop.Property_Description));

      return val;
   end Property_To_JSON;

   function Schema_To_JSON
     (Schema : Schema_Type) return GNATCOLL.JSON.JSON_Value
   is
      use GNATCOLL;

      Val            : JSON.JSON_Value := JSON.Create_Object;
      Props          : JSON.JSON_Value := JSON.Create_Object;
      Required_Array : JSON.JSON_Array;
   begin
      JSON.Set_Field
        (Val, "type", Str_255_Field.To_String (Schema.Object_Type));

      for P of Schema.Properties loop
         JSON.set_Field
           (props, Str_255_Field.To_String (P.Name), Property_To_JSON (P));
         if P.Is_Required then
            declare
               Filed_Val : JSON.JSON_Value :=
                 JSON.Create (Str_255_Field.To_String (P.Name));
            begin
               Required_Array.Append (Filed_Val);
            end;
         end if;
      end loop;
      JSON.Set_Field (Val, "required", Required_Array);
      JSON.Set_Field (Val, "properties", props);
      JSON.Set_Field (Val, "additionalProperties", false);
      return val;
   end Schema_To_JSON;

   function Tool_To_JSON
     (Tool : Mcp_Tools.Mcp_Tool_Type) return GNATCOLL.JSON.JSON_Value
   is
      use GNATCOLL;
      Val : JSON.JSON_Value := JSON.Create_Object;
   begin
      JSON.Set_Field (val, "name", Str_255_Field.To_String (Tool.Name));
      JSON.Set_Field
        (val, "description", Str_255_Field.To_String (Tool.Description));
      JSON.Set_Field (val, "inputSchema", Schema_To_JSON (Tool.Input_Schema));
      JSON.Set_Field (val, "outputSchema", Schema_To_JSON (Tool.Output_Schema));
      return val;
   end Tool_To_JSON;

   function Get_Tool_Catalog return String is
      use Gnatcoll;
      Result    : JSON.JSON_Value := JSON.Create_Object;
      Tools_Arr : JSON.JSON_Array;
      Response  : JSON.JSON_Value := Create_Response;
   begin

      for Tool of Tools loop
         JSON.Append (Tools_Arr, Tool_To_JSON (Tool));
      end loop;
      JSON.Set_Field (Result, "tools", Tools_Arr);
      JSON.Set_Field (Response, "result", Result);
      return JSON.Write (Response, True);

   end Get_Tool_Catalog;

end Mcp_Tools_Catalog;

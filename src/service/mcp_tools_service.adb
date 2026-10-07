
with Mcp_tools;
with Mcp_Tools_Catalog;
with Logger;
with GNATCOLL.JSON;
package body Mcp_Tools_Service is


   function Return_Tools (Payload:String) return String
   is

      use GNATCOLL;



      Register_Operation_Tool : Mcp_Tools.Mcp_Tool_Type;
      RO_Input_Schema         : Mcp_Tools.Schema_Type;
      RO_Out_Schema           : Mcp_Tools.Schema_Type;
      Input_Properties        : Mcp_Tools.Tool_Property_Vector.Vector;
      Out_Properties          : Mcp_Tools.Tool_Property_Vector.Vector;

     

   begin

      Register_Operation_Tool.Name :=
        Mcp_Tools.Str_255_Field.To_Bounded_String ("registerOperation");
      Register_Operation_Tool.Description :=
        Mcp_Tools.Str_255_Field.To_Bounded_String
          ("Register a finance operation");

      RO_Input_Schema.Has_Additional_Properties := false;
      RO_Input_Schema.Object_Type :=
        Mcp_Tools.Str_255_Field.To_Bounded_String ("object");
         RO_Out_Schema.Object_Type :=
        Mcp_Tools.Str_255_Field.To_Bounded_String ("object");
      RO_Input_Schema.Properties := Input_Properties;

      declare
         amount_property: Mcp_Tools.Tool_Property_Type;
         op_type_property: Mcp_Tools.Tool_Property_Type;
         account_id_property: Mcp_Tools.Tool_Property_Type;

         result_property:Mcp_Tools.Tool_Property_Type;
      begin

         amount_property.Is_Required:=true;
         amount_property.Name:=Mcp_Tools.Str_255_Field.To_Bounded_String("amount");
         amount_property.Property_Type:=Mcp_Tools.Str_255_Field.To_Bounded_String("float");
         amount_property.Property_Description:=Mcp_Tools.Str_255_Field.To_Bounded_String("Money amount for operation");

         op_type_property.Is_Required:=true;
         op_type_property.Name:=Mcp_Tools.Str_255_Field.To_Bounded_String("operationType");
         op_type_property.Property_Description:=Mcp_Tools.Str_255_Field.To_Bounded_String("Can be DECREMENT or INCREMENT");
         op_type_property.Property_Type:=Mcp_Tools.Str_255_Field.To_Bounded_String("string");

         account_id_property.Is_Required:=true;
         account_id_property.Name:=Mcp_Tools.Str_255_Field.To_Bounded_String("accountId");
         account_id_property.Property_Description:=Mcp_Tools.Str_255_Field.To_Bounded_String("always use 1 for account id");
         account_id_property.Property_Type:=Mcp_Tools.Str_255_Field.To_Bounded_String("integer");

         RO_Input_Schema.Properties.Append (amount_property);
         RO_Input_Schema.Properties.Append (op_type_property);
         RO_Input_Schema.Properties.Append (account_id_property);

         result_property.Is_Required:=true;
         result_property.Name:=Mcp_Tools.Str_255_Field.To_Bounded_String("result");
         result_property.Property_Type:=Mcp_Tools.Str_255_Field.To_Bounded_String("boolean");
         result_property.Property_Description:=Mcp_Tools.Str_255_Field.To_Bounded_String("true if operation was successful");

         RO_Out_Schema.Properties.Append (result_property);

      end;

      Register_Operation_Tool.Input_Schema := RO_Input_Schema;
      Register_Operation_Tool.Output_Schema := RO_Out_Schema;

      Mcp_Tools_Catalog.Register_Tool (Register_Operation_Tool);


declare
      val: JSON.Json_Value:=JSON.Read(Payload);
      id:constant Integer:=val.get("id");
      begin

     
          return Mcp_Tools_Catalog.Get_Tool_Catalog(Id'Image);
              end;

     
   end Return_Tools;

end Mcp_Tools_Service;

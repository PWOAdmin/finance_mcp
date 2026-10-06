with AWS.Messages;
with Mcp_tools;
with Mcp_Tools_Catalog;

package body Mcp_Tools_Service is

   Dsp : Tools_Dispatcher;

   procedure Create_Service
     (Web_Config  : Config.Object;
      Hdr         : in out Services.Dispatchers.URI.Handler;
      Service_URI : String)
   is
      pragma Unreferenced (Web_Config);
   begin
      Services.Dispatchers.URI.Register
        (Hdr, URI => Service_URI, Action => Dsp, Prefix => True);
   end Create_Service;

   overriding
   function Dispatch
     (Dispatcher : Tools_Dispatcher; Request : Status.Data)
      return Response.Data
   is
      use Status;

      pragma Unreferenced (Dispatcher);

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

      if Method (Request) = GET then
         return
           Response.Build
             (Content_Type => "application/json",
              Message_Body => Mcp_Tools_Catalog.Get_Tool_Catalog);
      else
         return Response.Acknowledge (Messages.S405);
      end if;
   end Dispatch;

end Mcp_Tools_Service;

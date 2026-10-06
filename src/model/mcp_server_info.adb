with Gnatcoll.JSON;

package body Mcp_Server_Info is

   function To_JSON
     (Info : Mcp_Server_Info_Type) return Gnatcoll.JSON.JSON_Value
   is
      use Gnatcoll;
      Result : Gnatcoll.JSON.JSON_Value := JSON.Create_Object;
   begin

      JSON.Set_Field
        (Result, "name", Mcp_Server_Field_Str.To_String (Info.Server_Name));
      JSON.Set_Field
        (Result, "title", Mcp_Server_Field_Str.To_String (Info.Server_Title));
      JSON.Set_Field
        (Result,
         "version",
         Mcp_Server_Field_Str.To_String (Info.Server_Version));

      return Result;
   end To_JSON;

   function To_Handshake_JSON (Info : Mcp_Server_Info_Type) return String is
      use Gnatcoll;
      Result       : Gnatcoll.JSON.JSON_Value := JSON.Create_Object;
      Handshake    : Gnatcoll.JSON.JSON_Value := JSON.Create_Object;
      Capabilities : Gnatcoll.JSON.JSON_Value := JSON.Create_Object;
      Tools        : Gnatcoll.JSON.JSON_Value := JSON.Create_Object;
   begin

      JSON.Set_Field (Result, "jsonrpc", "2.0");
      JSON.Set_Field (Result, "id", "1");

      JSON.Set_Field (Tools, "listChanged", True);

      JSON.Set_Field (Capabilities, "supportsTransactions", True);
      JSON.Set_Field (Capabilities, "tools", Tools);

      JSON.Set_Field (Handshake, "capabilities", Capabilities);

      JSON.Set_Field (Handshake, "protocolVersion", "2025-11-25");

      JSON.Set_Field (Handshake, "serverInfo", To_JSON (Info));

      JSON.Set_Field (Result, "result", Handshake);

      return JSON.Write (Result, True);

   end To_Handshake_JSON;

end Mcp_Server_Info;

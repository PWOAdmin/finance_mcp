package body Mcp_Tools is

	function "=" (Left, Right : Tool_Property_Type) return Boolean is
	begin
		return Str_255_Field.To_String (Left.Name) =
		  Str_255_Field.To_String (Right.Name);
	end "=";

	function "=" (Left, Right : Mcp_Tool_Type) return Boolean is
	begin
		return Str_255_Field.To_String (Left.Name) =
		  Str_255_Field.To_String (Right.Name);
	end "=";

end Mcp_Tools;
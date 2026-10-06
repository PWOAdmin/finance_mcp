with Ada.Text_IO; use Ada.Text_IO;
package body Logger is

   procedure Log (Level : Logger_Level_Type; Message : String) is
   begin
      case Level is
         when Debug =>
            Put_Line ("[DEBUG] " & Message);
         when Info =>
            Put_Line ("[INFO] " & Message);
         when Warning =>
            Put_Line ("[WARNING] " & Message);
         when Error =>
            Put_Line ("[ERROR] " & Message);
      end case;
   end Log;

   procedure Info (Message : String) is
   begin
      Log (Info, Message);
   end Info;   
   procedure Warning (Message : String) is
   begin
      Log (Warning, Message);
   end Warning;
   procedure Error (Message : String) is
   begin
      Log (Error, Message);
   end Error;
   
end Logger;
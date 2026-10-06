package Logger is

   type Logger_Level_Type is (Debug, Info, Warning, Error);
   procedure Log (Level : Logger_Level_Type; Message : String);
   procedure Info (Message : String);
   procedure Warning (Message : String);
   procedure Error (Message : String);

end Logger;
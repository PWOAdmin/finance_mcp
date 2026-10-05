package Finance_Model is

Type Currency_Type is (RSD, EUR);
Type Account_Amount_Type is delta Float range 0.0 .. 2.0**(+31) - 1.0;
Type Operation_Action_Type is (INCREMENT, DECREMENT);

Type Account_Type is record
   Account_Id : Integer;
   Currency       : Currency_Type;
   Balance        : Account_Amount_Type;
   Account_Name   : String (1 .. 255);
end record;



Type Operation_Type is record
   Operation_Id : Integer;
   Account_Id   : Integer;
   Amount       : Account_Amount_Type;
   Created_At   : String (1 .. 255);
   Action       : Operation_Action_Type;
end record;

end Finance_Model;
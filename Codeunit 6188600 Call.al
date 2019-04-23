codeunit 6188600 "Call"
{
    procedure Call(PhoneNo: Text)
    begin
        HYPERLINK('Callto://' + PhoneNo);
    end;

}
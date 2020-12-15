table 50033 "Phone Book"
{
    DataPerCompany = false;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "User-ID"; code[50]) { }
        field(3; Name; text[50]) { }
        field(4; "Phone No."; text[50]) { ExtendedDatatype = PhoneNo; }
        field(5; "Sequence No."; Integer) { }
        field(6; "Temp. Sequence No."; Integer) { }

    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert();
    var
        PhoneBook: Record "Phone Book";
    begin
        "User-ID" := UserId;
        PhoneBook.SetCurrentKey("Sequence No.");
        PhoneBook.SetRange("User-ID", "User-ID");
        if PhoneBook.FindLast then
            "Sequence No." := PhoneBook."Sequence No." + 100
        else
            "Sequence No." := 100;
    end;

    procedure Call()
    begin
        HYPERLINK('Callto://' + "Phone No.");
    end;

    procedure Resequence()
    var 
        i: Integer;
    begin
        SetCurrentKey("Sequence No.");
        SetRange("User-ID", "User-ID");
        FindSet;
        repeat
            i += 100;
            "Temp. Sequence No." := i;
            Modify;
        until Next = 0;
        
        reset;
        SetCurrentKey("Temp. Sequence No.");
        SetRange("User-ID", "User-ID");
        FindSet;
        repeat
            "Sequence No." := "Temp. Sequence No.";
            Modify;
        until Next = 0;
    end;

}
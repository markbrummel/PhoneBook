page 6188600 "Phone Book"
{
    PageType = List;
    Caption = 'Phone Book';
    SourceTable = "Phone Book";
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Name) { }
                field("Phone No."; "Phone No.") { }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Call)
            {
                Caption = 'Call';
                Image = Calls;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction();
                var
                    SoftwareUsageMgt: Codeunit "Software Usage Mgt.";
                begin
                    SoftwareUsageMgt.AddActionUsage(6188600, 'CALL');
                    Call;
                end;
            }
            action(MoveUp)
            {
                Caption = 'Up';
                Image = MoveUp;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction();
                begin
                    Up;
                end;
            }
            action(MoveDown)
            {
                Caption = 'Down';
                Image = MoveDown;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction();
                begin
                    Down;
                end;
            }
        }
    }
    trigger OnOpenPage();
    var
        SoftwareUsageMgt: Codeunit "Software Usage Mgt.";
    begin
        SoftwareUsageMgt.AddPageUsage(6188600);
        SetRange("User-ID", UserId);
    end;

    procedure Up()
    begin
        "Sequence No." := "Sequence No." - 150;
        Modify;
        Resequence;
    end;

    procedure Down()
    begin
        "Sequence No." := "Sequence No." + 150;
        Modify;
        Resequence;
    end;
}
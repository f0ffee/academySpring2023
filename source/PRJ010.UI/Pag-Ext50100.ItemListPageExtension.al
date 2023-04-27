pageextension 50100 "Item List Page Extension" extends "Item List"
{
    layout
    {
        addafter(Description)
        {
            field("Reverse Description"; Rec."Reverse Description")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addfirst(Functions)
        {
            action(ShowItems)
            {
                ApplicationArea = All;
                Caption = 'Reverse Description';
                Image = Change;
                ToolTip = 'Reverse the description item';
                trigger OnAction()
                var
                    entries: Record Item;
                    desc: Text[100];
                    tmp: List of [Text];
                    word: Text;
                begin
                    if entries.Findset() then begin
                        repeat
                            entries."Reverse Description" := ' ';
                            entries.Modify();
                            tmp := entries.Description.Split(' ');
                            tmp.Reverse();
                            foreach word in tmp do begin
                                entries."Reverse Description" := word + ' ' + entries."Reverse Description";
                            end;
                            entries.Modify();
                        until entries.Next() = 0;
                    end
                    else
                        Error('entries.Get andata male');
                end;
            }
        }
    }
}

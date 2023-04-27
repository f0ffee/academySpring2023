pageextension 50100 "AND Item List Ext" extends "Item List"
{
    layout
    {
        addafter(Description)
        {
            field("AND Reverse Desc"; Rec."AND Reverse Desc")
            {
                ApplicationArea = All;
                Caption = 'Reverse Description';
            }
        }
    }

    trigger OnOpenPage()
    var
        Item: Record Item;
        Words: List of [Text];
        ReversedWords: List of [Text];
        i: Integer;
    begin
        Item.Next();
        repeat
        begin
            i := 0;

            Item."AND Reverse Desc" := '';
            Item.Modify();

            Words := Item.Description.Split(' ');

            if Words.Count > 1 then begin
                for i := Words.Count() downto 1 do begin
                    if i = Words.Count() then begin
                        // Evito lo spazio se sono alla prima parola.
                        Item."AND Reverse Desc" += Words.Get(i);
                    end
                    else begin
                        // Aggiungo lo spazio tra le parole.
                        Item."AND Reverse Desc" += ' ' + Words.Get(i);
                    end;
                end;
                Item.Modify();
            end;

            if Words.Count = 1 then begin
                Item."AND Reverse Desc" := Item.Description;
                Item.Modify();
            end;
        end;
        until Item.Next() = 0;
    end;
}
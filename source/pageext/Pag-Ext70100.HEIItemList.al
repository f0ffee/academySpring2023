pageextension 70100 "HEI Item List" extends "Item List"
{
    layout
    {
        addafter(Description)
        {
            field("Reverse Description"; Rec."Reverse Description")
            {
                ApplicationArea = All;
                Caption = 'Reverse Description';
            }
        }
    }
    actions
    {
        addfirst(Functions)
        {
            action(Reverse)
            {
                Caption = 'Reverse Description';
                ApplicationArea = All;

                trigger OnAction()
                var
                    Item: Record Item;
                    ListReverse: List of [Text];
                    i: Integer;
                    ItemList: Page "Item List";
                begin
                    if Item.FindSet() then
                        repeat begin
                            ListReverse := Item.Description.Split(' ');
                            Item."Reverse Description" := '';

                            for i := ListReverse.Count downto 1 do begin
                                Item."Reverse Description" := Item."Reverse Description" + ListReverse.Get(i);

                                if i <> 1 then
                                    Item."Reverse Description" := Item."Reverse Description" + ' ';
                            end;

                            Item.Modify();
                        end until Item.Next() = 0;
                end;
            }
        }
    }
}
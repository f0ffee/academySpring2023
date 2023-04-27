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
                begin
                    Message('ok');
                end;
            }
        }
    }




}
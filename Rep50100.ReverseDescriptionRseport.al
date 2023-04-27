report 50100 "Reverse Description Rseport"
{
    ApplicationArea = None;
    DefaultRenderingLayout = LayoutName;


    dataset
    {
        //nome che diamo noi al record :"SalesHeader" e nome della tabella del db "Sales Header"
        dataitem(Item; Item)
        {
            column(Reverse_Description; "Reverse Description") { IncludeCaption = true; }
            column(Description; "Description") { IncludeCaption = true; }

            dataitem(SalesLine; "Sales Line")
            {


            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(ReverseDescription)
                {
                    Caption = 'Reverse Description';
                    field()
                    {
                        // ApplicationArea = All;
                        // Caption = 'Show Price';
                        // ToolTip = 'Specifies if prices should be displayed.';

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    //layout di default è LayoutName
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './Layout/mylayout.rdl';
        }
    }

    var
        ShowPrice: Boolean;

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        ShowPrice := true;
    end;
}
report 50100 "Reverse Description Report"
{
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;
    Caption = 'Reverse report';
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        //nome che diamo noi al record :"SalesHeader" e nome della tabella del db "Sales Header"
        dataitem(Item; Item)
        {
            column(Reverse_Description; "Reverse Description") { IncludeCaption = true; }
            column(Description; "Description") { IncludeCaption = true; }

            trigger OnPreDataItem()
            begin
                descriptionsFounded := false;
            end;

            trigger OnAfterGetRecord()
            var
                entries: Record Item;

            begin
                if not (entries.Description.StartsWith(letter)) then
                    CurrReport.Skip();

                descriptionsFounded := true;
            end;

            trigger OnPostDataItem()
            begin
                if not Confirm('There is No description with ' + letter + '. Do you want to print anyways?') and not descriptionsFounded then
                    exit
            end;
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
                    field(letter; letter)
                    {
                        ApplicationArea = All;
                        Caption = 'Insert a letter';
                        ToolTip = 'Insert a letter (Optionally)';
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
        letter: Char;
        descriptionsFounded: Boolean;
}
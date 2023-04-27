report 70100 "HEI Item Description"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;
    Caption = 'HEI Description Item';

    dataset
    {
        dataitem(Item; Item)
        {
            column(Description; Description) { IncludeCaption = true; }
            column(Reverse_Description; "Reverse Description") { IncludeCaption = true; }
            column(StartLetter; StartLetter) { }

            trigger OnPreDataItem()

            var

                Item: Record Item;

            begin

                if Item.FindSet() then
                    repeat begin

                        if Item.Description[1] = StartLetter then begin

                            FindRecord := true;

                            exit;

                        end;

                    end until Item.Next() = 0;




                if NOT FindRecord then
                    if Confirm('Continue whitout filter?', true) then
                        NoSkip := true

                    else
                        CurrReport.Quit();

            end;




            trigger OnAfterGetRecord()

            begin

                if NOT NoSkip then
                    if Item.Description[1] <> StartLetter then
                        CurrReport.Skip()

                    else
                        FindRecord := true;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(StartLetter; StartLetter)
                    {
                        ApplicationArea = All;
                        ToolTip = 'StartLetter';
                        Caption = 'Start Letter';
                    }
                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './Layouts/HEIDescription.rdl';
        }
    }

    var
        StartLetter: Char;
        NoSKip: Boolean;
        FindRecord: Boolean;

    trigger OnInitReport()

    begin
        FindRecord:= false;
        Noskip:= false;
        StartLetter:= 'A';    
    end;




}

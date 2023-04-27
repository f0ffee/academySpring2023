report 70100 "HEI Item Description"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;
    Caption = 'HEI Item Description';

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
                group(Options)
                {
                    field(StartLetter; StartLetter)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Letter';
                        ToolTip = 'The first letter to search for';
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
        FindRecord, NoSkip : Boolean;
        StartLetter: Char;

    trigger OnInitReport()
    begin
        FindRecord := false;
        NoSkip := false;
        StartLetter := 'A';
    end;
}
report 50105 MyReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;
    dataset
    {
        dataitem(DataItemName; Item)
        {
            column(reverse; DataItemName.MyField)
            {

            }

            column(desc; DataItemName.Description)
            {

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if DataItemName.Description[1] <> filtro then
                    CurrReport.Skip();
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
                    field(filtro; filtro)
                    {
                        ApplicationArea = All;
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

                }
            }
        }
    }

    rendering
    {

        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }

    var
        filtro: text[1];
}
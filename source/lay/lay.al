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
                if find_one then begin
                    if (DataItemName.Description[1] <> filtro) then
                        CurrReport.Skip();
                end else begin
                    CurrReport.Skip();
                end;

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
                        trigger OnValidate()

                        var
                            myInt: Integer;
                            rc: record item;

                        begin
                            find_one := false;
                            IF RC.FindSet() then
                                repeat
                                    if (rc.Description[1] = filtro) then
                                        find_one := true;
                                until rc.Next() = 0;

                            if NOT (find_one) then
                                if Dialog.Confirm('NESSUN ELEMENTO TROVATO USCIRE?') = true then begin
                                    CurrReport.Quit();
                                end else begin
                                    find_one := true;
                                end;

                        end;

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
            LayoutFile = '.cartellaLay/mylayout.rdl';
        }
    }

    var
        filtro: text[1];
        find_one: Boolean;



}
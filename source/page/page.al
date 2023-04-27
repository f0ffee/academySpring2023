pageextension 50105 MyExtension extends "Item List"
{
    layout
    {
        addafter("Base Unit of Measure")
        {
            field(MyField; rec.MyField)
            {
                Caption = 'Description Reverse';
            }
        }
    }
    actions
    {
        addafter(PeriodicActivities)
        {
            action(reverse)
            {
                Caption = 'reverse';
                ApplicationArea = All;

                trigger OnAction()
                var
                    RC: Record Item;
                    myarr: List of [Text];
                    spacearr: List of [Text];
                    ControlVariable: text;

                begin
                    IF RC.FindSet() then
                        repeat
                            spacearr.Add(' ');
                            myarr := rc.Description.Split(spacearr);
                            rc.MyField := '';
                            foreach ControlVariable in myarr do begin
                                rc.MyField := ControlVariable + ' ' + rc.MyField;
                            end;
                            rc.Modify()
                        until rc.Next() = 0;

                end;
            }
        }
    }



}


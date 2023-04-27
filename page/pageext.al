pageextension 50100 MyExtension extends "Item List"
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
            action(ActionName)
            {
                ApplicationArea = All;
                Caption = 'Click to Reverse';


                trigger OnAction()
                var
                    rc: Record Item;
                    mystr: Text[100];
                    myarr: List of [Text];
                    spacearr: List of [Text];
                    space: Text;
                    final_string: Text[100];
                    ControlVariable: Text;
                begin
                    if rc.Findset() then
                        repeat
                            space := ' ';
                            spacearr.Add(space);
                            myarr := rc.Description.Split(spacearr);
                            foreach ControlVariable in myarr do begin
                                rc.MyField := ControlVariable + ' ' + rc.MyField;
                            end;
                            rc.Modify();
                        until rc.Next() = 0;
                end;
            }
        }
    }
}
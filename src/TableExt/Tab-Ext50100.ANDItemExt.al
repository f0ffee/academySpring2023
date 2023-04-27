tableextension 50100 "AND Item Ext" extends Item
{
    fields
    {
        field(50100; "AND Reverse Desc"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reverse Description';
        }
    }
}
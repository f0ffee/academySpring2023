report 70101 "HEI Order List"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            column(No_; "No.") { IncludeCaption = true; }
            column(Name; Name) { IncludeCaption = true; }

            dataitem("Purchase Line"; "Purchase Line")
            {
                column(Document_No_; "Document No.") { }
            }
        }
    }
}
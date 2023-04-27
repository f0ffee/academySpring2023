report 50100 "AND Item Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = Default;

    dataset
    {
        dataitem(Item; Item)
        {
            column(Description; Description)
            {
                IncludeCaption = true;
            }
            column("Reverse_Description"; "AND Reverse Desc")
            {
                IncludeCaption = true;
            }

            column(AlphabetLetter; AlphabetLetter)
            {

            }

            trigger OnPreDataItem()
            var
                Item: Record Item;
                UserResponse: Boolean;
            begin
                StartsWithLetter := false;
                repeat
                    if (LowerCase(Item.Description).StartsWith(LowerCase(AlphabetLetter))) then begin
                        StartsWithLetter := true;
                        break;
                    end;
                until Item.Next() = 0;

                if not StartsWithLetter then begin
                    UserResponse := Confirm('Items starting with Alphabet Letter not present. Do you want to print the whole dataset?', false);
                    if (UserResponse) then begin
                        AlphabetLetter := '';
                    end
                    else begin
                        Message('You have chosen not to print any records.');
                    end;
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                if (AlphabetLetter <> '') and not (AlphabetLetter.Contains(' ')) then begin
                    if not (LowerCase(Item.Description).StartsWith(LowerCase(AlphabetLetter))) then
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
                group(Options)
                {
                    Caption = 'Options';
                    field(Letter; AlphabetLetter)
                    {
                        ApplicationArea = All;
                        Caption = 'Alphabet Letter';
                        ToolTip = 'Write a single Alphabet Letter.';
                    }
                }
            }
        }
    }

    rendering
    {
        layout(Default)
        {
            Type = RDLC;
            LayoutFile = 'res\Layouts\TestLayout.rdl';
        }
    }

    var
        AlphabetLetter: Text[1];
        StartsWithLetter: Boolean;
}
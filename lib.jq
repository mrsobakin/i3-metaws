def escape:
    sub("\""; "\\\"");

def i3_rename(from; to): 
    "rename workspace \"\(from | escape)\" to \"\(to | escape)\"";

def or_default(maybe_empty; default):
    if isempty(maybe_empty) then
        default
    else
        maybe_empty
    end;

def parse_metaws:
    {
        true_name: .,
        name:      sub("^@metaws@.*@metaws@"; "") | sub("@metaws:pin@$"; ""),
        metaws:    or_default(scan("^@metaws@(.*)@metaws@"; "nm").[0]; null),
        current:   test("^@metaws@") | not,
        pin:       test("@metaws:pin@$"),
    };

def make_name(ws; metaws):
    "@metaws@" + metaws + "@metaws@" + ws;
